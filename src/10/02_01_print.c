#include "print.h"

void print_chr(char ch) {
	HWSWCD_PRINT = ch;
}

void print_str(const char *p) {
	while (*p != 0)
		HWSWCD_PRINT = *(p++);
}

void print_hex(unsigned int val, int digits) {
	unsigned int index, max;
	int i; /* !! must be signed, because of the check 'i>=0' */
	char x;

	if(digits == 0)
		return;

	max = digits << 2;

	for (i = max-4; i >= 0; i -= 4) {
		index = val >> i;
		index = index & 0xF;
		HWSWCD_PRINT="0123456789ABCDEF"[index];
	}

	print_str("\n");
}
