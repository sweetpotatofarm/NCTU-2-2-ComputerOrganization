#Fibonacci

.data
N: .word 10
str: .string "th number in the Fibonacci sequence is "
z: .word 0
o: .word 1

.text
main:
        lw       a0, N
        
        jal      ra, fib

        #print
        jal      ra, printResult

        #exit problem
        li       a0, 10
        ecall

fib:
        bne      a0, zero, fib_not_0
        mv       a1, a0
        ret

fib_not_0:
        addi     t0, a0, -1
        bne      t0, zero, fib_not_01
        mv       a1, a0
        ret

fib_not_01:
        addi     sp, sp, -24
        sw       ra, 0(sp)
        sw       a0, 8(sp)
        addi     a0, a0, -1
        jal      ra, fib
        sw       a1, 16(sp)
        lw       a0, 8(sp)
        addi     a0, a0, -2
        jal      ra, fib
        lw       a3, 16(sp)
        add      a1, a1, a3
        lw       ra, 0(sp)
        addi     sp, sp, 24
        ret
        

printResult:
        lw       t0, N
        mv       t1, a1

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        ret
