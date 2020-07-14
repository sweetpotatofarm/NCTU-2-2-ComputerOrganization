#Bubble Sort

.data
arr: .word 5, 3, 6, 7, 31, 23, 43, 12, 45, 1

n: .word 10

str: .string " "
str1: .string "\n"
str2: .string "Sorted: \n"
str3: .string "Array: \n"

.text
main:
#array initialize
        la      t0, arr
        lw      t1, n
        slli    t2, t1, 2
        add     t0, t0, t2
        addi    t0, t0, -4
        jal     ra, loop

        la      a1, str3
        li      a0, 4
        ecall
        li      a6, 0
        lw      a7, n
        jal     ra, printResult
        la      a1, str1
        li      a0, 4
        ecall
        
        jal     ra, bubble1

        la      a1, str2
        li      a0, 4
        ecall
        li      a6, 0
        lw      a7, n
        jal     ra, printResult
        la      a1, str1
        li      a0, 4
        ecall

        li      a0, 10
        ecall
#load array, and save in s0
loop:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        addi    t1, t1, -1
        addi    s0, s0, -4
        lw      t2, 0(t0)
        sw      t2, 0(s0)
        addi    t0, t0, -4
        bne     t1, zero, loop
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret
#a3 = i = 0, a5 = n
bubble1:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        li      a3, 0
        lw      a5, n
        jal     ra, bubble2
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret
#j = i-1, in loop j, i++(loop i)
bubble2:
#if i > n, ret
        bge     a3, a5, return
        addi    sp, sp, -8
        sw      ra, 0(sp)
        addi    a4, a3, -1
        jal     ra, bubble3
        addi    a3, a3, 1
        jal     ra, bubble2
        lw      ra,0(sp)
        addi    sp,sp,8
        ret
#if arr[j+1] > array[j](loop j)
bubble3:
#if j > 0, ret
        blt     a4, zero, return
        addi    sp, sp, -8
        sw      ra, 0(sp)
        slli    a6, a4, 2
        add     a7, s0, a6
        lw      a1, 0(a7)
        lw      a2, 4(a7)
#if arr[j+1] > arr[j], no change
        bge     a2, a1, bubble4
#else, swap, and j--, loop again
        jal     ra, bubble5
        addi    a4, a4, -1
        jal     ra, bubble3
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret
#j--, loop again
bubble4:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        addi    a4, a4, -1
        jal     ra, bubble3
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret
#swap
bubble5:
        addi    sp, sp, -8
        sw      ra, 0(sp)
        slli    a6, a4, 2
        add     a7, s0, a6
        lw      a1, 0(a7)
        lw      a2, 4(a7)
        sw      a2, 0(a7)
        sw      a1, 4(a7)
        lw      ra, 0(sp)
        addi    sp, sp, 8
        ret
#risc v need at least one line to return
return:
        addi    a0, a0, 0
        ret

#print
printResult:
        addi    sp,sp,-8
        sw      ra,0(sp)
#s2 = s0 + 4*i
        slli    a0,a6,2
        add     s2,s0,a0
#print number
        lw      a1,0(s2)
        li      a0,1
        ecall
#print " "
        la      a1,str
        li      a0,4
        ecall
        addi    a6,a6,1
        blt     a6,a7,printResult
        lw      ra,0(sp)
        addi    sp,sp,8
        ret
