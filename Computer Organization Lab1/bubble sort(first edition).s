#Bubble Sort

.data
a: .word 5
b: .word 3
c: .word 6
d: .word 7
e: .word 31
f: .word 23
g: .word 43
h: .word 12
i: .word 45
j: .word 1

x: .word 9

str: .string" "

.text
main:
        addi    sp, sp, -100
        sw      s0, 60(sp)
#array
        lw      a0, a
        sw      a0, 0(s0)
        lw      a0, b
        sw      a0, -4(s0)
        lw      a0, c
        sw      a0, -8(s0)
        lw      a0, d
        sw      a0, -12(s0)
        lw      a0, e
        sw      a0, -16(s0)
        lw      a0, f
        sw      a0, -20(s0)
        lw      a0, g
        sw      a0, -24(s0)
        lw      a0, h
        sw      a0, -28(s0)
        lw      a0, i
        sw      a0, -32(s0)
        lw      a0, j
        sw      a0, -40(s0)
        jal     ra, printResult
#i=1
        lw      a0, j
        sw      a0, -44(s0)
        jal     ra, bubble1
#print
        jal     ra, printResult
        addi    sp, sp, 80
#end
        li      a0, 10
        ecall
        

#check i <= 9
bubble1:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        lw      a3, -44(s0)
        lw      a4, x
        bge     a4, a3, bubble2
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret

#j = i-1
bubble2:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        lw      a3, -44(s0)
        addi    a4, a3, -1
        sw      a4, -48(s0)
        jal     ra, bubble3
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret

#check j >= 0
bubble3:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        lw      a4, -48(s0)
        jal     ra, bubble4
#i++
        lw      a3, -44(s0)
        addi    a3, a3, 1
        sw      a3, -44(s0)
        lw      ra, 0(sp)
        addi    sp, sp, 8
        jal     ra, bubble1
        ret

#array[j] > array[j+1]
bubble4:
#a1 = array[j]
        lw      a4, -48(s0)
        slli    a4, a4, 2
        add     a5, s0, a4
        lw      a1, 0(a5)
#a2 = array[j+1]
        lw      a4, -48(s0)
        addi    a4, a4, 1
        slli    a4, a4, 2
        add     a5, s0, a4
        lw      a2, 0(a5)
#if array[j+1] > array[j]
        bge     a2, a1, bubble5
#else, swap
#save array[j] to temp
        lw      a4, -48(s0)
        slli    a4, a4, 2
        add     a5, s0, a4
        lw      a1, 0(a5)

        sw      a1, -52(a0)
#array[j] = array[j+1]
        lw      a4, -48(s0)
        addi    a4, a4, 1
        slli    a4, a4, 2
        add     a5, s0, a4
        lw      a2, 0(a5)

        lw      a4, -48(s0)
        slli    a4, a4, 2
        add     a5, s0, a4
        sw      a2, 0(a5)
#array[j+1] = temp
        lw      a4, -48(s0)
        addi    a4, a4, 1
        slli    a4, a4, 2
        add     a5, s0, a4
        lw      a1, -52(s0)
        sw      a1, 0(a5)
        jal     ra, bubble5
        ret

#j--
bubble5:
        bge     a0, zero, print5
        lw      a4, -48(s0)
        addi    a4, a4, -1
        sw      a4, -48(s0)
        jal     ra, bubble3
        ret

#print
printResult:
        lw       t0, 0(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -4(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -8(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -12(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -16(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -20(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -24(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -28(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -32(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        la       a1, str
        li       a0, 4
        ecall
        lw      t0, -40(s0)
        mv       a1, t0
        li       a0, 1
        ecall
        ret

