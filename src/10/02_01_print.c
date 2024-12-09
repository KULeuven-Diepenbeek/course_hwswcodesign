#include "print.h"

void print_chr(char ch) {
	HWSWCD_PRINT = ch;
}

void print_str(const char *p) {
	while (*p != 0)
		HWSWCD_PRINT = *(p++);
}

void print_hex(unsigned int val, int digits) {
	for (int i = (4*digits)-4; i >= 0; i -= 4)
		HWSWCD_PRINT = "0123456789ABCDEF"[(val >> i) & 255];
	print_chr('\n');
}
