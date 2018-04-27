/* link-arm-eabi.ld - linker script for arm eabi */
ENTRY(_start)
 
SECTIONS
{
    /* One of the following lines should be commented out! */ 
    . = 0x8000;         /* Raspbery Pi will load the image here */

    __text_start__ = .;
    .text :
    {
	/*(.start)           /* put the start section first ! */
        KEEP(*(.text.boot))
        *(.text)
    }
    . = ALIGN(4096);    /* align to page size */
    __text_end__ = .;
 
    __rodata_start__ = .;
    .rodata :
    {
        *(.rodata)
    }
    . = ALIGN(4096);    /* align to page size */
    __rodata_end__ = .;
 
    __data_start__ = .;
    .data :
    {
        *(.data)
    }
    . = ALIGN(4096);    /* align to page size */
    __data_end__ = .;
 
    __bss_start__ = .;
    .bss :
    {
        bss = .;
        *(.bss)
    }
    . = ALIGN(4096);    /* align to page size */
    __bss_end__ = .;
    _end = .;
}
