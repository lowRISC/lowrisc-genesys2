// See LICENSE for license details.

#include "uart.h"

volatile uint32_t *uart_base_ptr = (uint32_t *)(UART_BASE);

void uart_init() {
  // set 0x0080 to UART.LCR to enable DLL and DLM write
  // configure baud rate
  *(uart_base_ptr + UART_LCR) = 0x0080;

  // System clock 50 MHz, 115200 baud rate
  // divisor = clk_freq / (16 * Baud)
  *(uart_base_ptr + UART_DLL) = 50*1000*1000u / (16u * 115200u) % 0x100u;
  *(uart_base_ptr + UART_DLM) = 50*1000*1000u / (16u * 115200u) >> 8;

  // 8-bit data, 1-bit odd parity
  *(uart_base_ptr + UART_LCR) = 0x000Bu;

  // Disable all interrupt, use polling
  *(uart_base_ptr + UART_IER) = 0x0000u;

}

void uart_send(uint8_t data) {
  // wait until THR empty
  while(! (*(uart_base_ptr + UART_LSR) & 0x40u));
  *(uart_base_ptr + UART_THR) = data;
}

void uart_send_string(const uint8_t *str) {
  while(*str != 0) {
    while(! (*(uart_base_ptr + UART_LSR) & 0x40u));
    *(uart_base_ptr + UART_THR) = *(str++);
  }
}

void uart_send_buf(const uint8_t *buf, const int32_t len) {
  int32_t i;
  for(i=0; i<len; i++) {
    while(! (*(uart_base_ptr + UART_LSR) & 0x40u));
    *(uart_base_ptr + UART_THR) = *(buf + i);
  }
}

uint8_t uart_recv() {
  // wait until RBR has data
  uint32_t status;
  while(! (*(uart_base_ptr + UART_LSR) & 0x01u)) { }

  return *(uart_base_ptr + UART_RBR);

}
