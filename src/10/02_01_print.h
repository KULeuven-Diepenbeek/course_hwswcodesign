#ifndef PRINT_H
#define PRINT_H

#define HWSWCD_PRINT_BASE_ADDRESS   0x80000000
#define HWSWCD_PRINT                *((volatile unsigned int*)HWSWCD_PRINT_BASE_ADDRESS)

void print_chr(char ch);
void print_str(const char *p);
void print_hex(unsigned int val, int digits);

#endif
