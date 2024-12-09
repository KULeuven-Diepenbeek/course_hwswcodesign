#ifndef PRINT_H
#define PRINT_H

#define OUTPORT 0x80000000

void print_chr(char ch);
void print_str(const char *p);
void print_hex(unsigned int val, int digits);

#endif
