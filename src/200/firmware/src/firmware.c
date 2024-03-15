#include "print.h"

extern unsigned int hwswcd_hd(unsigned int value1, unsigned int value2);

void main(void) {
	volatile unsigned int value1, value2, hd;

	value1 = 5;
	value2 = 9;

    hd = hwswcd_hd(value1, value2);

	print_str("HD(0x");
	print_hex(value1, 2);
	print_str(", ");
	print_hex(value2, 2);
	print_str(") = 0x");
	print_hex(hd, 2);
	print_str(".");
}
