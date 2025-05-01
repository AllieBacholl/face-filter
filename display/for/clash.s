        .file   "test.c"
        .option nopic
        .attribute arch, "rv32i2p1_m2p0"
        .attribute unaligned_access, 0
        .attribute stack_align, 16
        .text
        .section        .srodata,"a"
        .align  2
        .type   tanks, @object
        .size   tanks, 4
tanks:
        .word   268435456
        .align  2
        .type   bullets, @object
        .size   bullets, 4
bullets:
        .word   268443648
        .section        .sdata,"aw"
        .align  2
        .type   spawn_x, @object
        .size   spawn_x, 8
spawn_x:
        .word   50
        .word   270
        .align  2
        .type   spawn_y, @object
        .size   spawn_y, 8
spawn_y:
        .word   120
        .word   120
        .align  2
        .type   user_lives, @object
        .size   user_lives, 4
user_lives:
        .word   10
        .local  score
        .comm   score,4,4
        .text
        .align  2
        .type   tank_init, @function
tank_init:
.LFB0:
        .cfi_startproc
        addi    sp,sp,-48
        .cfi_def_cfa_offset 48
        sw      ra,44(sp)
        sw      s0,40(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,48
        .cfi_def_cfa 8, 0
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      a2,-44(s0)
        sw      a3,-48(s0)
        li      a3,268435456
        lw      a4,-36(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        lw      a4,-44(s0)
        sw      a4,0(a5)
        lw      a5,-20(s0)
        lw      a4,-48(s0)
        sw      a4,4(a5)
        lw      a5,-20(s0)
        sw      zero,8(a5)
        lw      a5,-20(s0)
        li      a4,1
        sw      a4,12(a5)
        lw      a5,-20(s0)
        li      a4,1
        sb      a4,16(a5)
        lw      a5,-20(s0)
        lw      a4,-40(s0)
        sw      a4,20(a5)
        nop
        lw      ra,44(sp)
        .cfi_restore 1
        lw      s0,40(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 48
        addi    sp,sp,48
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE0:
        .size   tank_init, .-tank_init
        .align  2
        .type   tank_respawn, @function
tank_respawn:
.LFB1:
        .cfi_startproc
        addi    sp,sp,-32
        .cfi_def_cfa_offset 32
        sw      ra,28(sp)
        sw      s0,24(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,32
        .cfi_def_cfa 8, 0
        sw      a0,-20(s0)
        li      a3,268435456
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a1,20(a5)
        lui     a5,%hi(spawn_x)
        addi    a4,a5,%lo(spawn_x)
        lw      a5,-20(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a2,0(a5)
        lui     a5,%hi(spawn_y)
        addi    a4,a5,%lo(spawn_y)
        lw      a5,-20(s0)
        slli    a5,a5,2
        add     a5,a4,a5
        lw      a5,0(a5)
        mv      a3,a5
        lw      a0,-20(s0)
        call    tank_init
        nop
        lw      ra,28(sp)
        .cfi_restore 1
        lw      s0,24(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 32
        addi    sp,sp,32
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE1:
        .size   tank_respawn, .-tank_respawn
        .align  2
        .type   tank_move, @function
tank_move:
.LFB2:
        .cfi_startproc
        addi    sp,sp,-48
        .cfi_def_cfa_offset 48
        sw      ra,44(sp)
        sw      s0,40(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,48
        .cfi_def_cfa 8, 0
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        li      a3,268435456
        lw      a4,-36(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      a5,-20(s0)
        lw      a5,-20(s0)
        lbu     a5,16(a5)
        xori    a5,a5,1
        andi    a5,a5,0xff
        bne     a5,zero,.L10
        lw      a5,-20(s0)
        lw      a4,-40(s0)
        sw      a4,8(a5)
        lw      a4,-40(s0)
        li      a5,3
        beq     a4,a5,.L6
        lw      a4,-40(s0)
        li      a5,3
        bgt     a4,a5,.L3
        lw      a4,-40(s0)
        li      a5,2
        beq     a4,a5,.L7
        lw      a4,-40(s0)
        li      a5,2
        bgt     a4,a5,.L3
        lw      a5,-40(s0)
        beq     a5,zero,.L8
        lw      a4,-40(s0)
        li      a5,1
        beq     a4,a5,.L9
        j       .L3
.L8:
        lw      a5,-20(s0)
        lw      a5,4(a5)
        addi    a4,a5,-1
        lw      a5,-20(s0)
        sw      a4,4(a5)
        j       .L3
.L7:
        lw      a5,-20(s0)
        lw      a5,4(a5)
        addi    a4,a5,1
        lw      a5,-20(s0)
        sw      a4,4(a5)
        j       .L3
.L6:
        lw      a5,-20(s0)
        lw      a5,0(a5)
        addi    a4,a5,-1
        lw      a5,-20(s0)
        sw      a4,0(a5)
        j       .L3
.L9:
        lw      a5,-20(s0)
        lw      a5,0(a5)
        addi    a4,a5,1
        lw      a5,-20(s0)
        sw      a4,0(a5)
        j       .L3
.L10:
        nop
.L3:
        lw      ra,44(sp)
        .cfi_restore 1
        lw      s0,40(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 48
        addi    sp,sp,48
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE2:
        .size   tank_move, .-tank_move
        .align  2
        .type   bullet_spawn, @function
bullet_spawn:
.LFB3:
        .cfi_startproc
        addi    sp,sp,-48
        .cfi_def_cfa_offset 48
        sw      ra,44(sp)
        sw      s0,40(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,48
        .cfi_def_cfa 8, 0
        sw      a0,-36(s0)
        li      a3,268435456
        lw      a4,-36(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      a5,-24(s0)
        lw      a5,-24(s0)
        lbu     a5,16(a5)
        xori    a5,a5,1
        andi    a5,a5,0xff
        bne     a5,zero,.L22
        sw      zero,-20(s0)
        j       .L14
.L21:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lbu     a5,16(a5)
        andi    a5,a5,0xff
        xori    a5,a5,1
        andi    a5,a5,0xff
        beq     a5,zero,.L15
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        li      a4,1
        sb      a4,16(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a4,-24(s0)
        lw      a4,20(a4)
        sw      a4,20(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a4,-24(s0)
        lw      a4,0(a4)
        sw      a4,0(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a4,-24(s0)
        lw      a4,4(a4)
        sw      a4,4(a5)
        lw      a5,-24(s0)
        lw      a5,8(a5)
        li      a4,3
        beq     a5,a4,.L16
        li      a4,3
        bgt     a5,a4,.L23
        li      a4,2
        beq     a5,a4,.L18
        li      a4,2
        bgt     a5,a4,.L23
        beq     a5,zero,.L19
        li      a4,1
        beq     a5,a4,.L20
        j       .L23
.L19:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      zero,8(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        li      a4,-1
        sw      a4,12(a5)
        j       .L17
.L18:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      zero,8(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        li      a4,1
        sw      a4,12(a5)
        j       .L17
.L16:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        li      a4,-1
        sw      a4,8(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      zero,12(a5)
        j       .L17
.L20:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        li      a4,1
        sw      a4,8(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      zero,12(a5)
        nop
.L17:
        j       .L23
.L15:
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L14:
        lw      a4,-20(s0)
        li      a5,15
        ble     a4,a5,.L21
        j       .L11
.L22:
        nop
        j       .L11
.L23:
        nop
.L11:
        lw      ra,44(sp)
        .cfi_restore 1
        lw      s0,40(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 48
        addi    sp,sp,48
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE3:
        .size   bullet_spawn, .-bullet_spawn
        .align  2
        .type   bullet_update, @function
bullet_update:
.LFB4:
        .cfi_startproc
        addi    sp,sp,-32
        .cfi_def_cfa_offset 32
        sw      ra,28(sp)
        sw      s0,24(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,32
        .cfi_def_cfa 8, 0
        sw      zero,-20(s0)
        j       .L25
.L29:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lbu     a5,16(a5)
        andi    a5,a5,0xff
        xori    a5,a5,1
        andi    a5,a5,0xff
        bne     a5,zero,.L30
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a2,8(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a3,0(a5)
        li      a1,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a1,a5
        add     a4,a2,a3
        sw      a4,0(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a2,12(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a3,4(a5)
        li      a1,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a1,a5
        add     a4,a2,a3
        sw      a4,4(a5)
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a5,0(a5)
        blt     a5,zero,.L28
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a4,0(a5)
        li      a5,320
        bgt     a4,a5,.L28
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a5,4(a5)
        blt     a5,zero,.L28
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lw      a4,4(a5)
        li      a5,240
        ble     a4,a5,.L27
.L28:
        li      a3,268443648
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sb      zero,16(a5)
        j       .L27
.L30:
        nop
.L27:
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L25:
        lw      a4,-20(s0)
        li      a5,15
        ble     a4,a5,.L29
        nop
        nop
        lw      ra,28(sp)
        .cfi_restore 1
        lw      s0,24(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 32
        addi    sp,sp,32
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE4:
        .size   bullet_update, .-bullet_update
        .align  2
        .type   read_joystick_dir, @function
read_joystick_dir:
.LFB5:
        .cfi_startproc
        addi    sp,sp,-16
        .cfi_def_cfa_offset 16
        sw      ra,12(sp)
        sw      s0,8(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,16
        .cfi_def_cfa 8, 0
        li      a5,0
        mv      a0,a5
        lw      ra,12(sp)
        .cfi_restore 1
        lw      s0,8(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 16
        addi    sp,sp,16
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE5:
        .size   read_joystick_dir, .-read_joystick_dir
        .align  2
        .type   read_fire_button, @function
read_fire_button:
.LFB6:
        .cfi_startproc
        addi    sp,sp,-16
        .cfi_def_cfa_offset 16
        sw      ra,12(sp)
        sw      s0,8(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,16
        .cfi_def_cfa 8, 0
        li      a5,0
        mv      a0,a5
        lw      ra,12(sp)
        .cfi_restore 1
        lw      s0,8(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 16
        addi    sp,sp,16
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE6:
        .size   read_fire_button, .-read_fire_button
        .align  2
        .type   render_frame, @function
render_frame:
.LFB7:
        .cfi_startproc
        addi    sp,sp,-16
        .cfi_def_cfa_offset 16
        sw      ra,12(sp)
        sw      s0,8(sp)
        .cfi_offset 1, -4
        .cfi_offset 8, -8
        addi    s0,sp,16
        .cfi_def_cfa 8, 0
        nop
        lw      ra,12(sp)
        .cfi_restore 1
        lw      s0,8(sp)
        .cfi_restore 8
        .cfi_def_cfa 2, 16
        addi    sp,sp,16
        .cfi_def_cfa_offset 0
        jr      ra
        .cfi_endproc
.LFE7:
        .size   render_frame, .-render_frame
        .align  2
        .globl  main
        .type   main, @function
main:
.LFB8:
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
        j       .L37
.L38:
        li      a3,268435456
        lw      a4,-20(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sb      zero,16(a5)
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
.L37:
        lw      a4,-20(s0)
        li      a5,1
        ble     a4,a5,.L38
        sw      zero,-24(s0)
        j       .L39
.L40:
        li      a3,268443648
        lw      a4,-24(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sb      zero,16(a5)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
.L39:
        lw      a4,-24(s0)
        li      a5,15
        ble     a4,a5,.L40
        lui     a5,%hi(spawn_x)
        addi    a5,a5,%lo(spawn_x)
        lw      a4,0(a5)
        lui     a5,%hi(spawn_y)
        addi    a5,a5,%lo(spawn_y)
        lw      a5,0(a5)
        mv      a3,a5
        mv      a2,a4
        li      a1,0
        li      a0,0
        call    tank_init
        lui     a5,%hi(spawn_x)
        addi    a5,a5,%lo(spawn_x)
        lw      a4,4(a5)
        lui     a5,%hi(spawn_y)
        addi    a5,a5,%lo(spawn_y)
        lw      a5,4(a5)
        mv      a3,a5
        mv      a2,a4
        li      a1,1
        li      a0,1
        call    tank_init
        j       .L41
.L53:
        call    read_joystick_dir
        sw      a0,-36(s0)
        call    read_fire_button
        mv      a5,a0
        sb      a5,-37(s0)
        lw      a1,-36(s0)
        li      a0,0
        call    tank_move
        lbu     a5,-37(s0)
        beq     a5,zero,.L42
        li      a0,0
        call    bullet_spawn
.L42:
        call    bullet_update
        sw      zero,-28(s0)
        j       .L43
.L52:
        li      a3,268443648
        lw      a4,-28(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        lbu     a5,16(a5)
        andi    a5,a5,0xff
        xori    a5,a5,1
        andi    a5,a5,0xff
        bne     a5,zero,.L55
        sw      zero,-32(s0)
        j       .L46
.L51:
        li      a3,268435456
        lw      a4,-32(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sw      a5,-44(s0)
        lw      a5,-44(s0)
        lbu     a5,16(a5)
        xori    a5,a5,1
        andi    a5,a5,0xff
        bne     a5,zero,.L56
        lw      a5,-44(s0)
        lw      a3,0(a5)
        li      a2,268443648
        lw      a4,-28(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a2,a5
        lw      a5,0(a5)
        bne     a3,a5,.L48
        lw      a5,-44(s0)
        lw      a3,4(a5)
        li      a2,268443648
        lw      a4,-28(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a2,a5
        lw      a5,4(a5)
        bne     a3,a5,.L48
        lw      a4,-32(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        mv      a4,a5
        li      a5,268435456
        add     a5,a4,a5
        sw      a5,-48(s0)
        lw      a4,-28(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        mv      a4,a5
        li      a5,268443648
        add     a5,a4,a5
        sw      a5,-52(s0)
        lw      a5,-44(s0)
        lw      a5,20(a5)
        bne     a5,zero,.L49
        lui     a5,%hi(user_lives)
        lw      a5,%lo(user_lives)(a5)
        addi    a4,a5,-1
        lui     a5,%hi(user_lives)
        sw      a4,%lo(user_lives)(a5)
        li      a0,0
        call    tank_respawn
        j       .L50
.L49:
        lui     a5,%hi(score)
        lw      a5,%lo(score)(a5)
        addi    a4,a5,1
        lui     a5,%hi(score)
        sw      a4,%lo(score)(a5)
        li      a0,1
        call    tank_respawn
.L50:
        li      a3,268443648
        lw      a4,-28(s0)
        mv      a5,a4
        slli    a5,a5,1
        add     a5,a5,a4
        slli    a5,a5,3
        add     a5,a3,a5
        sb      zero,16(a5)
        j       .L48
.L56:
        nop
.L48:
        lw      a5,-32(s0)
        addi    a5,a5,1
        sw      a5,-32(s0)
.L46:
        lw      a4,-32(s0)
        li      a5,1
        ble     a4,a5,.L51
        j       .L45
.L55:
        nop
.L45:
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
.L43:
        lw      a4,-28(s0)
        li      a5,15
        ble     a4,a5,.L52
        call    render_frame
.L41:
        lui     a5,%hi(user_lives)
        lw      a5,%lo(user_lives)(a5)
        bgt     a5,zero,.L53
.L54:
        j       .L54
        .cfi_endproc
.LFE8:
        .size   main, .-main
        .ident  "GCC: (g04696df09) 14.2.0"
        .section        .note.GNU-stack,"",@progbits