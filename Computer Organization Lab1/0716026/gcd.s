# gcd

.data
N1: .word 512
N2: .word 480
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw       a0, N1
        lw       a1, N2
        jal      ra, gcd

        #print
        mv       a2, a0
        lw       a0, N1
        lw       a1, N2
        jal      ra, printResult

        #exit
        li       a0, 10
        ecall

gcd:
        sw       ra, 8(sp)
        bne      a1, zero, ngcd
        ret

ngcd:
        addi     sp, sp, -16
        rem      a2, a0, a1
        mv       a0, a1
        mv       a1, a2
        
        jal      ra, gcd
        lw       ra, 8(sp)
        addi     sp, sp, 16
        ret


printResult:
        lw       t0, N1
        lw       t1, N2
        mv       t2, a2

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        la       a1, str3
        li       a0, 4
        ecall

        mv       a1, t2
        li       a0, 1
        ecall

        ret

