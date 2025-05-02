        .file   "test.c"
        .option nopic
        .attribute arch, "rv32i2p1_m2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .globl  player_x
        .section        .sdata,"aw"
        .align  2
        .type   player_x, @object
        .size   player_x, 4
player_x:
        .word   4096
        .globl  player_y
        .align  2
        .type   player_y, @object
        .size   player_y, 4
player_y:
        .word   4097
        .globl  ai1_x
        .align  2
        .type   ai1_x, @object
        .size   ai1_x, 4
ai1_x:
        .word   4098
        .globl  ai1_y
        .align  2
        .type   ai1_y, @object
        .size   ai1_y, 4
ai1_y:
        .word   4099
        .globl  ai2_x
        .align  2
        .type   ai2_x, @object
        .size   ai2_x, 4
ai2_x:
        .word   4100
        .globl  ai2_y
        .align  2
        .type   ai2_y, @object
        .size   ai2_y, 4
ai2_y:
        .word   4101
        .globl  player_bullet_x
        .align  2
        .type   player_bullet_x, @object
        .size   player_bullet_x, 4
player_bullet_x:
        .word   4102
        .globl  player_bullet_y
        .align  2
        .type   player_bullet_y, @object
        .size   player_bullet_y, 4
player_bullet_y:
        .word   4103
        .globl  player_bullet_dx
        .align  2
        .type   player_bullet_dx, @object
        .size   player_bullet_dx, 4
player_bullet_dx:
        .word   4104
        .globl  player_bullet_dy
        .align  2
        .type   player_bullet_dy, @object
        .size   player_bullet_dy, 4
player_bullet_dy:
        .word   4105
        .globl  player_bullet_active
        .align  2
        .type   player_bullet_active, @object
        .size   player_bullet_active, 4
player_bullet_active:
        .word   4106
        .globl  ai1_bullet_x
        .align  2
        .type   ai1_bullet_x, @object
        .size   ai1_bullet_x, 4
ai1_bullet_x:
        .word   4107
        .globl  ai1_bullet_y
        .align  2
        .type   ai1_bullet_y, @object
        .size   ai1_bullet_y, 4
ai1_bullet_y:
        .word   4108
        .globl  ai1_bullet_dx
        .align  2
        .type   ai1_bullet_dx, @object
        .size   ai1_bullet_dx, 4
ai1_bullet_dx:
        .word   4109
        .globl  ai1_bullet_dy
        .align  2
        .type   ai1_bullet_dy, @object
        .size   ai1_bullet_dy, 4
ai1_bullet_dy:
        .word   4110
        .globl  ai1_bullet_active
        .align  2
        .type   ai1_bullet_active, @object
        .size   ai1_bullet_active, 4
ai1_bullet_active:
        .word   4111
        .globl  ai2_bullet_x
        .align  2
        .type   ai2_bullet_x, @object
        .size   ai2_bullet_x, 4
ai2_bullet_x:
        .word   4112
        .globl  ai2_bullet_y
        .align  2
        .type   ai2_bullet_y, @object
        .size   ai2_bullet_y, 4
ai2_bullet_y:
        .word   4113
        .globl  ai2_bullet_dx
        .align  2
        .type   ai2_bullet_dx, @object
        .size   ai2_bullet_dx, 4
ai2_bullet_dx:
        .word   4114
        .globl  ai2_bullet_dy
        .align  2
        .type   ai2_bullet_dy, @object
        .size   ai2_bullet_dy, 4
ai2_bullet_dy:
        .word   4115
        .globl  ai2_bullet_active
        .align  2
        .type   ai2_bullet_active, @object
        .size   ai2_bullet_active, 4
ai2_bullet_active:
        .word   4116
        .globl  input_up
        .align  2
        .type   input_up, @object
        .size   input_up, 4
input_up:
        .word   4117
        .globl  input_down
        .align  2
        .type   input_down, @object
        .size   input_down, 4
input_down:
        .word   4118
        .globl  input_left
        .align  2
        .type   input_left, @object
        .size   input_left, 4
input_left:
        .word   4119
        .globl  input_right
        .align  2
        .type   input_right, @object
        .size   input_right, 4
input_right:
        .word   4120
        .globl  input_shoot
        .align  2
        .type   input_shoot, @object
        .size   input_shoot, 4
input_shoot:
        .word   4121
        .globl  input_start
        .align  2
        .type   input_start, @object
        .size   input_start, 4
input_start:
        .word   4122
        .globl  player_lives
        .align  2
        .type   player_lives, @object
        .size   player_lives, 4
player_lives:
        .word   4123
        .align  2
        .type   rand_seed, @object
        .size   rand_seed, 4
rand_seed:
        .word   1
        .text
        .align  2
        .globl  main
        .type   main, @function
main:
.LFB0:
        .cfi_startproc
        addi    sp,sp,-64
        .cfi_def_cfa_offset 64
        sw      ra,60(sp)
        sw      s0,56(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,64
        .cfi_def_cfa 8, 0
        sw      zero,-20(s0)
        lui     a5,%hi(input_start)
        lw      a5,%lo(input_start)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L2
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        li      a4,50
        sb      a4,0(a5)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        li      a4,50
        sb      a4,0(a5)
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        li      a4,20
        sb      a4,0(a5)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        li      a4,20
        sb      a4,0(a5)
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        li      a4,80
        sb      a4,0(a5)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        li      a4,80
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        li      a4,8
        sb      a4,0(a5)
        j       .L3
.L2:
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        ble     a5,zero,.L3
        sb      zero,-21(s0)
        sb      zero,-22(s0)
        lui     a5,%hi(input_up)
        lw      a5,%lo(input_up)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L4
        li      a5,-1
        sb      a5,-22(s0)
        j       .L5
.L4:
        lui     a5,%hi(input_down)
        lw      a5,%lo(input_down)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L5
        li      a5,1
        sb      a5,-22(s0)
.L5:
        lui     a5,%hi(input_left)
        lw      a5,%lo(input_left)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L6
        li      a5,-1
        sb      a5,-21(s0)
        j       .L7
.L6:
        lui     a5,%hi(input_right)
        lw      a5,%lo(input_right)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L7
        li      a5,1
        sb      a5,-21(s0)
.L7:
        lui     a5,%hi(input_shoot)
        lw      a5,%lo(input_shoot)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L8
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a5,zero,.L8
        sb      zero,-23(s0)
        sb      zero,-24(s0)
        lui     a5,%hi(input_up)
        lw      a5,%lo(input_up)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L9
        sb      zero,-23(s0)
        li      a5,-1
        sb      a5,-24(s0)
        j       .L10
.L9:
        lui     a5,%hi(input_down)
        lw      a5,%lo(input_down)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L11
        sb      zero,-23(s0)
        li      a5,1
        sb      a5,-24(s0)
        j       .L10
.L11:
        lui     a5,%hi(input_left)
        lw      a5,%lo(input_left)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L12
        li      a5,-1
        sb      a5,-23(s0)
        sb      zero,-24(s0)
        j       .L10
.L12:
        lui     a5,%hi(input_right)
        lw      a5,%lo(input_right)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L10
        li      a5,1
        sb      a5,-23(s0)
        sb      zero,-24(s0)
.L10:
        lb      a5,-23(s0)
        bne     a5,zero,.L13
        lb      a5,-24(s0)
        beq     a5,zero,.L8
.L13:
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-23(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-24(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_dx)
        lw      a5,%lo(player_bullet_dx)(a5)
        lbu     a4,-23(s0)
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_dy)
        lw      a5,%lo(player_bullet_dy)(a5)
        lbu     a4,-24(s0)
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        li      a4,1
        sb      a4,0(a5)
.L8:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a3,%lo(rand_seed)(a5)
        li      a5,1717985280
        addi    a5,a5,1639
        mulh    a5,a3,a5
        srai    a4,a5,1
        srai    a5,a3,31
        sub     a4,a4,a5
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        sub     a4,a3,a5
        sb      a4,-39(s0)
        sb      zero,-25(s0)
        sb      zero,-26(s0)
        lb      a4,-39(s0)
        li      a5,1
        bne     a4,a5,.L14
        li      a5,-1
        sb      a5,-26(s0)
        j       .L15
.L14:
        lb      a4,-39(s0)
        li      a5,2
        bne     a4,a5,.L16
        li      a5,1
        sb      a5,-26(s0)
        j       .L15
.L16:
        lb      a4,-39(s0)
        li      a5,3
        bne     a4,a5,.L17
        li      a5,-1
        sb      a5,-25(s0)
        j       .L15
.L17:
        lb      a4,-39(s0)
        li      a5,4
        bne     a4,a5,.L15
        li      a5,1
        sb      a5,-25(s0)
.L15:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a5,%lo(rand_seed)(a5)
        andi    a5,a5,3
        bne     a5,zero,.L18
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a5,zero,.L18
        sb      zero,-27(s0)
        sb      zero,-28(s0)
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L19
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bge     a4,a5,.L20
        li      a5,-1
        j       .L21
.L20:
        li      a5,1
.L21:
        sb      a5,-28(s0)
        j       .L22
.L19:
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L23
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bge     a4,a5,.L24
        li      a5,-1
        j       .L25
.L24:
        li      a5,1
.L25:
        sb      a5,-27(s0)
        j       .L22
.L23:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a5,%lo(rand_seed)(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,3
        sb      a5,-40(s0)
        lb      a5,-40(s0)
        bne     a5,zero,.L26
        li      a5,1
        sb      a5,-27(s0)
        j       .L22
.L26:
        lb      a4,-40(s0)
        li      a5,1
        bne     a4,a5,.L27
        li      a5,-1
        sb      a5,-27(s0)
        j       .L22
.L27:
        lb      a4,-40(s0)
        li      a5,2
        bne     a4,a5,.L28
        li      a5,1
        sb      a5,-28(s0)
        j       .L22
.L28:
        li      a5,-1
        sb      a5,-28(s0)
.L22:
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-27(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-28(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(ai1_bullet_dx)
        lw      a5,%lo(ai1_bullet_dx)(a5)
        lbu     a4,-27(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai1_bullet_dy)
        lw      a5,%lo(ai1_bullet_dy)(a5)
        lbu     a4,-28(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        li      a4,1
        sb      a4,0(a5)
.L18:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a3,%lo(rand_seed)(a5)
        li      a5,1717985280
        addi    a5,a5,1639
        mulh    a5,a3,a5
        srai    a4,a5,1
        srai    a5,a3,31
        sub     a4,a4,a5
        mv      a5,a4
        slli    a5,a5,2
        add     a5,a5,a4
        sub     a4,a3,a5
        sb      a4,-41(s0)
        sb      zero,-29(s0)
        sb      zero,-30(s0)
        lb      a4,-41(s0)
        li      a5,1
        bne     a4,a5,.L29
        li      a5,-1
        sb      a5,-30(s0)
        j       .L30
.L29:
        lb      a4,-41(s0)
        li      a5,2
        bne     a4,a5,.L31
        li      a5,1
        sb      a5,-30(s0)
        j       .L30
.L31:
        lb      a4,-41(s0)
        li      a5,3
        bne     a4,a5,.L32
        li      a5,-1
        sb      a5,-29(s0)
        j       .L30
.L32:
        lb      a4,-41(s0)
        li      a5,4
        bne     a4,a5,.L30
        li      a5,1
        sb      a5,-29(s0)
.L30:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a5,%lo(rand_seed)(a5)
        andi    a5,a5,3
        bne     a5,zero,.L33
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a5,zero,.L33
        sb      zero,-31(s0)
        sb      zero,-32(s0)
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L34
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bge     a4,a5,.L35
        li      a5,-1
        j       .L36
.L35:
        li      a5,1
.L36:
        sb      a5,-32(s0)
        j       .L37
.L34:
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L38
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bge     a4,a5,.L39
        li      a5,-1
        j       .L40
.L39:
        li      a5,1
.L40:
        sb      a5,-31(s0)
        j       .L37
.L38:
        lui     a5,%hi(rand_seed)
        lw      a4,%lo(rand_seed)(a5)
        li      a5,1103515648
        addi    a5,a5,-403
        mul     a4,a4,a5
        li      a5,12288
        addi    a5,a5,57
        add     a4,a4,a5
        lui     a5,%hi(rand_seed)
        sw      a4,%lo(rand_seed)(a5)
        lui     a5,%hi(rand_seed)
        lw      a5,%lo(rand_seed)(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,3
        sb      a5,-42(s0)
        lb      a5,-42(s0)
        bne     a5,zero,.L41
        li      a5,1
        sb      a5,-31(s0)
        j       .L37
.L41:
        lb      a4,-42(s0)
        li      a5,1
        bne     a4,a5,.L42
        li      a5,-1
        sb      a5,-31(s0)
        j       .L37
.L42:
        lb      a4,-42(s0)
        li      a5,2
        bne     a4,a5,.L43
        li      a5,1
        sb      a5,-32(s0)
        j       .L37
.L43:
        li      a5,-1
        sb      a5,-32(s0)
.L37:
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-31(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lbu     a5,-32(s0)
        add     a5,a4,a5
        andi    a4,a5,0xff
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(ai2_bullet_dx)
        lw      a5,%lo(ai2_bullet_dx)(a5)
        lbu     a4,-31(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai2_bullet_dy)
        lw      a5,%lo(ai2_bullet_dy)(a5)
        lbu     a4,-32(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        li      a4,1
        sb      a4,0(a5)
.L33:
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        sb      a5,-43(s0)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        sb      a5,-44(s0)
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        sb      a5,-45(s0)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        sb      a5,-46(s0)
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        sb      a5,-47(s0)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        sb      a5,-48(s0)
        lbu     a4,-43(s0)
        lbu     a5,-21(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-33(s0)
        lbu     a4,-44(s0)
        lbu     a5,-22(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-34(s0)
        lbu     a4,-45(s0)
        lbu     a5,-25(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-35(s0)
        lbu     a4,-46(s0)
        lbu     a5,-26(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-36(s0)
        lbu     a4,-47(s0)
        lbu     a5,-29(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-37(s0)
        lbu     a4,-48(s0)
        lbu     a5,-30(s0)
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-38(s0)
        lb      a5,-33(s0)
        blt     a5,zero,.L44
        lb      a4,-33(s0)
        li      a5,99
        ble     a4,a5,.L45
.L44:
        lbu     a5,-43(s0)
        sb      a5,-33(s0)
.L45:
        lb      a5,-34(s0)
        blt     a5,zero,.L46
        lb      a4,-34(s0)
        li      a5,99
        ble     a4,a5,.L47
.L46:
        lbu     a5,-44(s0)
        sb      a5,-34(s0)
.L47:
        lb      a5,-35(s0)
        blt     a5,zero,.L48
        lb      a4,-35(s0)
        li      a5,99
        ble     a4,a5,.L49
.L48:
        lbu     a5,-45(s0)
        sb      a5,-35(s0)
.L49:
        lb      a5,-36(s0)
        blt     a5,zero,.L50
        lb      a4,-36(s0)
        li      a5,99
        ble     a4,a5,.L51
.L50:
        lbu     a5,-46(s0)
        sb      a5,-36(s0)
.L51:
        lb      a5,-37(s0)
        blt     a5,zero,.L52
        lb      a4,-37(s0)
        li      a5,99
        ble     a4,a5,.L53
.L52:
        lbu     a5,-47(s0)
        sb      a5,-37(s0)
.L53:
        lb      a5,-38(s0)
        blt     a5,zero,.L54
        lb      a4,-38(s0)
        li      a5,99
        ble     a4,a5,.L55
.L54:
        lbu     a5,-48(s0)
        sb      a5,-38(s0)
.L55:
        lb      a4,-33(s0)
        lb      a5,-45(s0)
        bne     a4,a5,.L56
        lb      a4,-34(s0)
        lb      a5,-46(s0)
        beq     a4,a5,.L57
.L56:
        lb      a4,-33(s0)
        lb      a5,-47(s0)
        bne     a4,a5,.L58
        lb      a4,-34(s0)
        lb      a5,-48(s0)
        bne     a4,a5,.L58
.L57:
        lbu     a5,-43(s0)
        sb      a5,-33(s0)
        lbu     a5,-44(s0)
        sb      a5,-34(s0)
.L58:
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        lb      a4,-35(s0)
        bne     a4,a5,.L59
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        lb      a4,-36(s0)
        beq     a4,a5,.L60
.L59:
        lb      a4,-35(s0)
        lb      a5,-47(s0)
        bne     a4,a5,.L61
        lb      a4,-36(s0)
        lb      a5,-48(s0)
        bne     a4,a5,.L61
.L60:
        lbu     a5,-45(s0)
        sb      a5,-35(s0)
        lbu     a5,-46(s0)
        sb      a5,-36(s0)
.L61:
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        lb      a4,-37(s0)
        bne     a4,a5,.L62
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        lb      a4,-38(s0)
        beq     a4,a5,.L63
.L62:
        lb      a4,-37(s0)
        lb      a5,-35(s0)
        bne     a4,a5,.L64
        lb      a4,-38(s0)
        lb      a5,-36(s0)
        bne     a4,a5,.L64
.L63:
        lbu     a5,-47(s0)
        sb      a5,-37(s0)
        lbu     a5,-48(s0)
        sb      a5,-38(s0)
.L64:
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a4,-33(s0)
        sb      a4,0(a5)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a4,-34(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a4,-35(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a4,-36(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a4,-37(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a4,-38(s0)
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L65
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(player_bullet_dx)
        lw      a5,%lo(player_bullet_dx)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-49(s0)
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(player_bullet_dy)
        lw      a5,%lo(player_bullet_dy)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-50(s0)
        lb      a5,-49(s0)
        blt     a5,zero,.L66
        lb      a4,-49(s0)
        li      a5,99
        bgt     a4,a5,.L66
        lb      a5,-50(s0)
        blt     a5,zero,.L66
        lb      a4,-50(s0)
        li      a5,99
        ble     a4,a5,.L67
.L66:
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        j       .L65
.L67:
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a4,-49(s0)
        sb      a4,0(a5)
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a4,-50(s0)
        sb      a4,0(a5)
.L65:
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L68
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(ai1_bullet_dx)
        lw      a5,%lo(ai1_bullet_dx)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-51(s0)
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(ai1_bullet_dy)
        lw      a5,%lo(ai1_bullet_dy)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-52(s0)
        lb      a5,-51(s0)
        blt     a5,zero,.L69
        lb      a4,-51(s0)
        li      a5,99
        bgt     a4,a5,.L69
        lb      a5,-52(s0)
        blt     a5,zero,.L69
        lb      a4,-52(s0)
        li      a5,99
        ble     a4,a5,.L70
.L69:
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
        j       .L68
.L70:
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a4,-51(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a4,-52(s0)
        sb      a4,0(a5)
.L68:
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L71
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(ai2_bullet_dx)
        lw      a5,%lo(ai2_bullet_dx)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-53(s0)
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a4,a5,0xff
        lui     a5,%hi(ai2_bullet_dy)
        lw      a5,%lo(ai2_bullet_dy)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        andi    a5,a5,0xff
        add     a5,a4,a5
        andi    a5,a5,0xff
        sb      a5,-54(s0)
        lb      a5,-53(s0)
        blt     a5,zero,.L72
        lb      a4,-53(s0)
        li      a5,99
        bgt     a4,a5,.L72
        lb      a5,-54(s0)
        blt     a5,zero,.L72
        lb      a4,-54(s0)
        li      a5,99
        ble     a4,a5,.L73
.L72:
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
        j       .L71
.L73:
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a4,-53(s0)
        sb      a4,0(a5)
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a4,-54(s0)
        sb      a4,0(a5)
.L71:
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L74
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L74
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L74
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L74
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
.L74:
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L75
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L75
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L75
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L75
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
.L75:
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L76
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L76
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L76
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L76
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
.L76:
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L77
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L77
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L77
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a4,0(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        andi    a4,a4,0xff
        addi    a4,a4,-1
        andi    a4,a4,0xff
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        ble     a5,zero,.L78
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        li      a4,50
        sb      a4,0(a5)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        li      a4,50
        sb      a4,0(a5)
        j       .L77
.L78:
        li      a5,1
        sw      a5,-20(s0)
.L77:
        lw      a5,-20(s0)
        bne     a5,zero,.L79
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L79
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L79
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L79
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a4,0(a5)
        slli    a4,a4,24
        srai    a4,a4,24
        andi    a4,a4,0xff
        addi    a4,a4,-1
        andi    a4,a4,0xff
        slli    a4,a4,24
        srai    a4,a4,24
        sb      a4,0(a5)
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        ble     a5,zero,.L80
        lui     a5,%hi(player_x)
        lw      a5,%lo(player_x)(a5)
        li      a4,50
        sb      a4,0(a5)
        lui     a5,%hi(player_y)
        lw      a5,%lo(player_y)(a5)
        li      a4,50
        sb      a4,0(a5)
        j       .L79
.L80:
        li      a5,1
        sw      a5,-20(s0)
.L79:
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L81
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L81
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L81
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        li      a4,20
        sb      a4,0(a5)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        li      a4,20
        sb      a4,0(a5)
.L81:
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L82
        lui     a5,%hi(player_bullet_x)
        lw      a5,%lo(player_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L82
        lui     a5,%hi(player_bullet_y)
        lw      a5,%lo(player_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L82
        lui     a5,%hi(player_bullet_active)
        lw      a5,%lo(player_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        li      a4,80
        sb      a4,0(a5)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        li      a4,80
        sb      a4,0(a5)
.L82:
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L83
        lui     a5,%hi(ai1_bullet_x)
        lw      a5,%lo(ai1_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L83
        lui     a5,%hi(ai1_bullet_y)
        lw      a5,%lo(ai1_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L83
        lui     a5,%hi(ai1_bullet_active)
        lw      a5,%lo(ai1_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai2_x)
        lw      a5,%lo(ai2_x)(a5)
        li      a4,80
        sb      a4,0(a5)
        lui     a5,%hi(ai2_y)
        lw      a5,%lo(ai2_y)(a5)
        li      a4,80
        sb      a4,0(a5)
.L83:
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        beq     a5,zero,.L3
        lui     a5,%hi(ai2_bullet_x)
        lw      a5,%lo(ai2_bullet_x)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L3
        lui     a5,%hi(ai2_bullet_y)
        lw      a5,%lo(ai2_bullet_y)(a5)
        lbu     a5,0(a5)
        slli    a4,a5,24
        srai    a4,a4,24
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bne     a4,a5,.L3
        lui     a5,%hi(ai2_bullet_active)
        lw      a5,%lo(ai2_bullet_active)(a5)
        sb      zero,0(a5)
        lui     a5,%hi(ai1_x)
        lw      a5,%lo(ai1_x)(a5)
        li      a4,20
        sb      a4,0(a5)
        lui     a5,%hi(ai1_y)
        lw      a5,%lo(ai1_y)(a5)
        li      a4,20
        sb      a4,0(a5)
.L3:
        lui     a5,%hi(player_lives)
        lw      a5,%lo(player_lives)(a5)
        lbu     a5,0(a5)
        slli    a5,a5,24
        srai    a5,a5,24
        bgt     a5,zero,.L84
        li      a5,1
        sw      a5,-20(s0)
.L84:
        lw      a5,-20(s0)
        mv      a0,a5
        lw      ra,60(sp)
        .cfi_restore 1
        lw      s0,56(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 64
        addi    sp,sp,64
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE0:
        .size   main, .-main
        .ident  "GCC: (g04696df09) 14.2.0"
        .section        .note.GNU-stack,"",@progbits