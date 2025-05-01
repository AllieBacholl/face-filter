#include <stdint.h>
#include <stdbool.h>

/*=== Memory Map ===*/
#define TANK_AREA_BASE    0x10000000u
#define BULLET_AREA_BASE  0x10002000u

#define MAX_TANKS    2    // 0 = user, 1 = enemy
#define MAX_BULLETS 16

enum { DIR_UP = 0, DIR_RIGHT, DIR_DOWN, DIR_LEFT };

typedef struct {
    int32_t x, y;
    int32_t dir;
    int32_t health;
    bool    alive;
    int32_t id;
} Tank;

typedef struct {
    int32_t x, y;
    int32_t dx, dy;
    bool    active;
    int32_t owner_id;
} Bullet;

/* Overlay off‐chip RAM via pointers */
static volatile Tank   * const tanks   = (Tank   * const)TANK_AREA_BASE;
static volatile Bullet * const bullets = (Bullet * const)BULLET_AREA_BASE;

/*=== Game State ===*/
static int32_t spawn_x[MAX_TANKS] = {  50, 270 };
static int32_t spawn_y[MAX_TANKS] = { 120, 120 };

static int  user_lives = 10;
static int  score      = 0;

/*=== Tank & Bullet Routines ===*/
static void tank_init(int idx, int id, int32_t x, int32_t y) {
    Tank *t = &tanks[idx];
    t->x      = x;
    t->y      = y;
    t->dir    = DIR_UP;
    t->health = 1;       // unused for user, but placeholder
    t->alive  = true;
    t->id     = id;
}

static void tank_respawn(int idx) {
    tank_init(idx, tanks[idx].id,
              spawn_x[idx], spawn_y[idx]);
}

static void tank_move(int idx, int32_t dir) {
    Tank *t = &tanks[idx];
    if (!t->alive) return;
    t->dir = dir;
    switch (dir) {
        case DIR_UP:    t->y -= 1; break;
        case DIR_DOWN:  t->y += 1; break;
        case DIR_LEFT:  t->x -= 1; break;
        case DIR_RIGHT: t->x += 1; break;
    }
}

static void bullet_spawn(int owner_idx) {
    Tank *t = &tanks[owner_idx];
    if (!t->alive) return;
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (!bullets[i].active) {
            bullets[i].active   = true;
            bullets[i].owner_id = t->id;
            bullets[i].x        = t->x;
            bullets[i].y        = t->y;
            switch (t->dir) {
                case DIR_UP:    bullets[i].dx =  0; bullets[i].dy = -1; break;
                case DIR_DOWN:  bullets[i].dx =  0; bullets[i].dy =  1; break;
                case DIR_LEFT:  bullets[i].dx = -1; bullets[i].dy =  0; break;
                case DIR_RIGHT: bullets[i].dx =  1; bullets[i].dy =  0; break;
            }
            return;
        }
    }
}

static void bullet_update(void) {
    for (int i = 0; i < MAX_BULLETS; i++) {
        if (!bullets[i].active) continue;
        bullets[i].x += bullets[i].dx;
        bullets[i].y += bullets[i].dy;
        /* off‐screen? deactivate */
        if (bullets[i].x < 0 || bullets[i].x > 320 ||
            bullets[i].y < 0 || bullets[i].y > 240) {
            bullets[i].active = false;
        }
    }
}

/*=== I/O & Rendering Stubs ===*/
/* Hook these up to your FPGA GPIO/VGA logic */
static int  read_joystick_dir(void) { return DIR_UP; /* TODO */ }
static bool read_fire_button(void) { return false;  /* TODO */ }

/* Display all tanks and bullets, plus status bar for lives & score */
static void render_frame(void) {
    // VGA driver: iterate tanks[]/bullets[] and draw sprites...
    // Then draw status bar:
    //   Lives: user_lives   Score: score
    // (Implementation depends on your VGA text/drawing routines.)
}

/*=== Main Game Loop ===*/
int main(void) {
    /* 1) Clear slots */
    for (int i = 0; i < MAX_TANKS;   i++) tanks[i].alive   = false;
    for (int i = 0; i < MAX_BULLETS; i++) bullets[i].active = false;

    /* 2) Init user (idx=0) & enemy (idx=1) */
    tank_init(0, /*id=*/0, spawn_x[0], spawn_y[0]);
    tank_init(1, /*id=*/1, spawn_x[1], spawn_y[1]);

    /* 3) Game loop */
    while (user_lives > 0) {
        int  dir  = read_joystick_dir();
        bool fire = read_fire_button();

        /* Move & fire for user only (idx=0) */
        tank_move(0, dir);
        if (fire) bullet_spawn(0);

        /* Advance bullets */
        bullet_update();

        /* Collision detection */
        for (int b = 0; b < MAX_BULLETS; b++) {
            if (!bullets[b].active) continue;
            for (int t = 0; t < MAX_TANKS; t++) {
                Tank *T = &tanks[t];
                if (!T->alive) continue;
                if (T->x == bullets[b].x && T->y == bullets[b].y) {
                    /* Address calculations (for documentation) */
                    uintptr_t hit_tank_addr   = TANK_AREA_BASE   + t * sizeof(Tank);
                    uintptr_t hit_bullet_addr = BULLET_AREA_BASE + b * sizeof(Bullet);
                    (void)hit_tank_addr;
                    (void)hit_bullet_addr;
                    /* Handle hit */
                    if (T->id == 0) {
                        /* User hit */
                        user_lives--;
                        tank_respawn(0);
                    } else {
                        /* Enemy hit */
                        score++;
                        tank_respawn(1);
                    }
                    bullets[b].active = false;
                }
            }
        }

        /* Render everything (tanks, bullets, status) */
        render_frame();
    }

    /* Game Over: you might display a "Game Over" screen here */
    while (1) { /* freeze */ }

    return 0;
}