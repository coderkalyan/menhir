.section .text.init

.global _start
_start:
    # TODO: support bootstrapping multiple harts
    csrw satp, zero

.option push
.option norelax
    la gp, _global_pointer
.option pop

    # initialize the stack
    la sp, _stack_end

    # clear the bss section
    la t1, _bss_start
    la t2, _bss_end
clear:
    sd zero, 0(t1)
    addi t1, t1, 8
    bltu t1, t2, clear

    j main
