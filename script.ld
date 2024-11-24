OUTPUT_ARCH("riscv")

ENTRY(_start)

MEMORY
{
    ram (rwxa): ORIGIN = 0x80000000, LENGTH = 128M
}

PHDRS
{
    ram_fakerom PT_LOAD;
    ram_init PT_LOAD;
    ram PT_LOAD;
}

SECTIONS
{
    .text : ALIGN(4K) {
        *(.text.init);
        *(.text);
    } >ram :ram_fakerom

    .rodata : ALIGN(4K) {
        PROVIDE(_global_pointer = .);
        *(.rodata);
    } >ram :ram_fakerom

    .data : ALIGN(4K) {
        *(.data);
    } >ram :ram_init

    .bss : ALIGN(4K) {
        *(.bss);
    } >ram :ram

    PROVIDE(_bss_start = ADDR(.bss));
    PROVIDE(_bss_end = ADDR(.bss) + SIZEOF(.bss));

    PROVIDE(_stack_start = _bss_end);
    PROVIDE(_stack_end = _stack_start + 0x8000);
    PROVIDE(_heap_start = _stack_end);
    PROVIDE(_PHYSTOP = ORIGIN(ram) + LENGTH(ram));
}
