#include <stdint.h>

#define INIT_PLAYER_X 50
#define INIT_PLAYER_Y 50
#define INIT_AI1_X    20
#define INIT_AI1_Y    20
#define INIT_AI2_X    80
#define INIT_AI2_Y    80

volatile int8_t *player_x            = (int8_t*)0x1000;
volatile int8_t *player_y            = (int8_t*)0x1001;
volatile int8_t *ai1_x               = (int8_t*)0x1002;
volatile int8_t *ai1_y               = (int8_t*)0x1003;
volatile int8_t *ai2_x               = (int8_t*)0x1004;
volatile int8_t *ai2_y               = (int8_t*)0x1005;
volatile int8_t *player_bullet_x     = (int8_t*)0x1006;
volatile int8_t *player_bullet_y     = (int8_t*)0x1007;
volatile int8_t *player_bullet_dx    = (int8_t*)0x1008;
volatile int8_t *player_bullet_dy    = (int8_t*)0x1009;
volatile int8_t *player_bullet_active= (int8_t*)0x100A;
volatile int8_t *ai1_bullet_x        = (int8_t*)0x100B;
volatile int8_t *ai1_bullet_y        = (int8_t*)0x100C;
volatile int8_t *ai1_bullet_dx       = (int8_t*)0x100D;
volatile int8_t *ai1_bullet_dy       = (int8_t*)0x100E;
volatile int8_t *ai1_bullet_active   = (int8_t*)0x100F;
volatile int8_t *ai2_bullet_x        = (int8_t*)0x1010;
volatile int8_t *ai2_bullet_y        = (int8_t*)0x1011;
volatile int8_t *ai2_bullet_dx       = (int8_t*)0x1012;
volatile int8_t *ai2_bullet_dy       = (int8_t*)0x1013;
volatile int8_t *ai2_bullet_active   = (int8_t*)0x1014;
// input buttons
volatile int8_t *input_up            = (int8_t*)0x1015;
volatile int8_t *input_down          = (int8_t*)0x1016;
volatile int8_t *input_left          = (int8_t*)0x1017;
volatile int8_t *input_right         = (int8_t*)0x1018;
volatile int8_t *input_shoot         = (int8_t*)0x1019;
volatile int8_t *input_start         = (int8_t*)0x101A;
volatile int8_t *player_lives        = (int8_t*)0x101B;

static int32_t rand_seed = 1;

int main() {
    int32_t game_over = 0;

  // reset game state
    if (*input_start) {
        *player_x            = INIT_PLAYER_X;
        *player_y            = INIT_PLAYER_Y;
        *ai1_x               = INIT_AI1_X;
        *ai1_y               = INIT_AI1_Y;
        *ai2_x               = INIT_AI2_X;
        *ai2_y               = INIT_AI2_Y;

        *player_bullet_active= 0;
        *ai1_bullet_active   = 0;
        *ai2_bullet_active   = 0;
        *player_lives        = 8;
    }
    else if (*player_lives > 0) {
        // shooting and moving
        int8_t dx = 0, dy = 0;
        if (*input_up)    dy = -1;
        else if (*input_down)  dy = 1;
        if (*input_left)  dx = -1;
        else if (*input_right) dx = 1;

        if (*input_shoot && !*player_bullet_active) {
            int8_t bdx = 0, bdy = 0;
            if (*input_up)       { bdx = 0;  bdy = -1; }
            else if (*input_down){ bdx = 0;  bdy =  1; }
            else if (*input_left){ bdx = -1; bdy =  0; }
            else if (*input_right){bdx =  1; bdy =  0; }

            if (bdx || bdy) {
                *player_bullet_x      = *player_x + bdx;
                *player_bullet_y      = *player_y + bdy;
                *player_bullet_dx     = bdx;
                *player_bullet_dy     = bdy;
                *player_bullet_active = 1;
            }
        }

       
        rand_seed = rand_seed * 1103515245 + 12345;
        int8_t ai1_dir = rand_seed % 5;
        int8_t ai1_dx = 0, ai1_dy = 0;
        if (ai1_dir == 1)      ai1_dy = -1;
        else if (ai1_dir == 2) ai1_dy =  1;
        else if (ai1_dir == 3) ai1_dx = -1;
        else if (ai1_dir == 4) ai1_dx =  1;

        rand_seed = rand_seed * 1103515245 + 12345;
        if ((rand_seed & 3) == 0 && !*ai1_bullet_active) {
            int8_t bdx = 0, bdy = 0;
            if (*player_x == *ai1_x)  bdy = (*player_y < *ai1_y ? -1 : 1);
            else if (*player_y == *ai1_y) bdx = (*player_x < *ai1_x ? -1 : 1);
            else {
                rand_seed = rand_seed * 1103515245 + 12345;
                int8_t rd = rand_seed & 3;
                if (rd == 0)      { bdx =  1; }
                else if (rd == 1) { bdx = -1; }
                else if (rd == 2) { bdy =  1; }
                else              { bdy = -1; }
            }
            *ai1_bullet_x      = *ai1_x + bdx;
            *ai1_bullet_y      = *ai1_y + bdy;
            *ai1_bullet_dx     = bdx;
            *ai1_bullet_dy     = bdy;
            *ai1_bullet_active = 1;
        }

       // pusedeo ai 2
        rand_seed = rand_seed * 1103515245 + 12345;
        int8_t ai2_dir = rand_seed % 5;
        int8_t ai2_dx = 0, ai2_dy = 0;
        if (ai2_dir == 1)      ai2_dy = -1;
        else if (ai2_dir == 2) ai2_dy =  1;
        else if (ai2_dir == 3) ai2_dx = -1;
        else if (ai2_dir == 4) ai2_dx =  1;

        rand_seed = rand_seed * 1103515245 + 12345;
        if ((rand_seed & 3) == 0 && !*ai2_bullet_active) {
            int8_t bdx = 0, bdy = 0;
            if (*player_x == *ai2_x)  bdy = (*player_y < *ai2_y ? -1 : 1);
            else if (*player_y == *ai2_y) bdx = (*player_x < *ai2_x ? -1 : 1);
            else {
                rand_seed = rand_seed * 1103515245 + 12345;
                int8_t rd = rand_seed & 3;
                if (rd == 0)      { bdx =  1; }
                else if (rd == 1) { bdx = -1; }
                else if (rd == 2) { bdy =  1; }
                else              { bdy = -1; }
            }
            *ai2_bullet_x      = *ai2_x + bdx;
            *ai2_bullet_y      = *ai2_y + bdy;
            *ai2_bullet_dx     = bdx;
            *ai2_bullet_dy     = bdy;
            *ai2_bullet_active = 1;
        }

        /* update tank positions */
        int8_t opx = *player_x,  opy = *player_y;
        int8_t o1x = *ai1_x,      o1y = *ai1_y;
        int8_t o2x = *ai2_x,      o2y = *ai2_y;

        int8_t npx = opx + dx,    npy = opy + dy;
        int8_t n1x = o1x + ai1_dx, n1y = o1y + ai1_dy;
        int8_t n2x = o2x + ai2_dx, n2y = o2y + ai2_dy;

        if (npx < 0 || npx > 99) npx = opx;
        if (npy < 0 || npy > 99) npy = opy;
        if (n1x < 0 || n1x > 99) n1x = o1x;
        if (n1y < 0 || n1y > 99) n1y = o1y;
        if (n2x < 0 || n2x > 99) n2x = o2x;
        if (n2y < 0 || n2y > 99) n2y = o2y;

        if ((npx == o1x && npy == o1y) || (npx == o2x && npy == o2y)) {
            npx = opx; npy = opy;
        }
        if ((n1x == *player_x && n1y == *player_y) || (n1x == o2x && n1y == o2y)) {
            n1x = o1x; n1y = o1y;
        }
        if ((n2x == *player_x && n2y == *player_y) || (n2x == n1x && n2y == n1y)) {
            n2x = o2x; n2y = o2y;
        }

        *player_x = npx; *player_y = npy;
        *ai1_x     = n1x; *ai1_y   = n1y;
        *ai2_x     = n2x; *ai2_y   = n2y;

       // blues clash
        if (*player_bullet_active) {
            int8_t bx = *player_bullet_x + *player_bullet_dx;
            int8_t by = *player_bullet_y + *player_bullet_dy;
            if (bx < 0 || bx > 99 || by < 0 || by > 99)
                *player_bullet_active = 0;
            else {
                *player_bullet_x = bx;
                *player_bullet_y = by;
            }
        }

        if (*ai1_bullet_active) {
            int8_t bx = *ai1_bullet_x + *ai1_bullet_dx;
            int8_t by = *ai1_bullet_y + *ai1_bullet_dy;
            if (bx < 0 || bx > 99 || by < 0 || by > 99)
                *ai1_bullet_active = 0;
            else {
                *ai1_bullet_x = bx;
                *ai1_bullet_y = by;
            }
        }

        if (*ai2_bullet_active) {
            int8_t bx = *ai2_bullet_x + *ai2_bullet_dx;
            int8_t by = *ai2_bullet_y + *ai2_bullet_dy;
            if (bx < 0 || bx > 99 || by < 0 || by > 99)
                *ai2_bullet_active = 0;
            else {
                *ai2_bullet_x = bx;
                *ai2_bullet_y = by;
            }
        }

     // collisions for bullets
        if (*player_bullet_active && *ai1_bullet_active &&
            *player_bullet_x == *ai1_bullet_x && *player_bullet_y == *ai1_bullet_y)
        {
            *player_bullet_active = 0;
            *ai1_bullet_active    = 0;
        }
// bullet hits
        if (*player_bullet_active && *ai2_bullet_active &&
            *player_bullet_x == *ai2_bullet_x && *player_bullet_y == *ai2_bullet_y)
        {
            *player_bullet_active = 0;
            *ai2_bullet_active    = 0;
        }

        if (*ai1_bullet_active && *ai2_bullet_active &&
            *ai1_bullet_x == *ai2_bullet_x && *ai1_bullet_y == *ai2_bullet_y)
        {
            *ai1_bullet_active = 0;
            *ai2_bullet_active = 0;
        }

      // player hits
        if (*ai1_bullet_active && *ai1_bullet_x == *player_x && *ai1_bullet_y == *player_y)
        {
            *ai1_bullet_active = 0;
            (*player_lives)--;
            if (*player_lives > 0) {
                *player_x = INIT_PLAYER_X;
                *player_y = INIT_PLAYER_Y;
            } else {
                game_over = 1;
            }
        }

        if (!game_over && *ai2_bullet_active &&
            *ai2_bullet_x == *player_x && *ai2_bullet_y == *player_y)
        {
            *ai2_bullet_active = 0;
            (*player_lives)--;
            if (*player_lives > 0) {
                *player_x = INIT_PLAYER_X;
                *player_y = INIT_PLAYER_Y;
            } else {
                game_over = 1;
            }
        }

        if (*player_bullet_active && *player_bullet_x == *ai1_x && *player_bullet_y == *ai1_y) {
            *player_bullet_active = 0;
            *ai1_x = INIT_AI1_X;
            *ai1_y = INIT_AI1_Y;
        }

        if (*player_bullet_active && *player_bullet_x == *ai2_x && *player_bullet_y == *ai2_y) {
            *player_bullet_active = 0;
            *ai2_x = INIT_AI2_X;
            *ai2_y = INIT_AI2_Y;
        }

        if (*ai1_bullet_active && *ai1_bullet_x == *ai2_x && *ai1_bullet_y == *ai2_y) {
            *ai1_bullet_active = 0;
            *ai2_x = INIT_AI2_X;
            *ai2_y = INIT_AI2_Y;
        }

        if (*ai2_bullet_active && *ai2_bullet_x == *ai1_x && *ai2_bullet_y == *ai1_y) {
            *ai2_bullet_active = 0;
            *ai1_x = INIT_AI1_X;
            *ai1_y = INIT_AI1_Y;
        }
    }

    if (*player_lives <= 0) {
        game_over = 1;
    }

    return game_over;
}
