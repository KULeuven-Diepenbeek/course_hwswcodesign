#include "print.h"

void wait(void) {
	volatile unsigned int i;

	for(i=0;i<50;i++);
}

void main(void) {
	
	unsigned int i;

	for(i=1;i<1000;i++) {
		if((i & 0xF) == 0) {
			print_chr(';');
		} else if((i & 0x7) == 0) {
			print_chr(':');
		} else {
			print_chr('.');
		}
		wait();
	}
	    
	while(1);
}