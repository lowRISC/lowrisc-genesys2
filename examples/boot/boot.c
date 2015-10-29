// See LICENSE for license details.

#include <stdio.h>
#include "diskio.h"
#include "ff.h"
#include "uart.h"
#include "elf.h"
#include "memory.h"

FATFS FatFs;   /* Work area (file system object) for logical drive */

// 4K size read burst
#define SD_READ_SIZE 4096

#define SYS_soft_reset 617
#define SYS_set_iobase 0x12200
#define SYS_set_membase 0x2100
extern long syscall(long num, long arg0, long arg1, long arg2);

int main (void)
{
  FIL fil;                /* File object */
  FRESULT fr;             /* FatFs return code */
  uint8_t *boot_file_buf = (uint8_t *)(get_ddr_base()) + 0x38000000; // 0x8000000 (128M)
  uint8_t *memory_base = (uint8_t *)(get_ddr_base());

  // map DDR3 to IO
  syscall(SYS_set_membase, 0x0, 0x3fffffff, 0x0); /* BRAM, 0x00000000 - 0x3fffffff */
  syscall(SYS_set_membase+5, 0, 0, 0);            /* update memory space */

  syscall(SYS_set_iobase, 0x80000000, 0x7fffffff, 0);   /* IO devices, 0x80000000 - 0xffffffff */
  syscall(SYS_set_iobase+1, 0x40000000, 0x3fffffff, 0); /* DDR3, 0x40000000 - 0x7fffffff */
  syscall(SYS_set_iobase+5, 0, 0, 0);                   /* update io space */

  uart_init();

  /* Register work area to the default drive */
  f_mount(&FatFs, "", 0);

  /* Open a text file */
  printf("load boot into memory\n");
  fr = f_open(&fil, "boot", FA_READ);
  if (fr) {
    printf("failed to open boot!\n");
    return (int)fr;
  }

  /* Read file into memory */
  uint8_t *buf = boot_file_buf;
  uint32_t br;                  /* Read count */
  do {
    fr = f_read(&fil, buf, SD_READ_SIZE, &br);  /* Read a chunk of source file */
    buf += br;
  } while(!(fr || br == 0));

  printf("load %0x bytes to memory\n.", fil.fsize);

  /* read elf */
  printf("read boot and load elf to DDR memory\n");
  if(br = load_elf(memory_base, boot_file_buf, fil.fsize))
    printf("elf read failed with code %0d", br);

  /* Close the file */
  f_close(&fil);

  printf("read the loaded program:\n");

  // remap DDR3 to memory space
  syscall(SYS_set_membase, 0x0, 0x7fffffff, 0x0); /* BRAM, 0x00000000 - 0x3fffffff */
  syscall(SYS_set_membase+5, 0, 0, 0);            /* update memory space */

  syscall(SYS_set_iobase, 0x80000000, 0x7fffffff, 0); /* IO devices, 0x80000000 - 0xffffffff */
  syscall(SYS_set_iobase+1, 0, 0, 0);                 /* clear prevvious mapping */
  syscall(SYS_set_iobase+5, 0, 0, 0);                 /* update io space */

  uint64_t *memory = (uint64_t *)memory_base;
  do {
    printf("%16lx: %16lx%16lx\n", memory, *(memory+ 1), *memory);
    memory += 2;
  } while(memory <= get_ddr_base() + 0x200);

  // map DDR3 to address 0
  syscall(SYS_set_membase, 0x0, 0x3fffffff, 0x40000000); /* map DDR to 0x0 */
  syscall(SYS_soft_reset, 0, 0, 0);                      /* soft reset */

}
