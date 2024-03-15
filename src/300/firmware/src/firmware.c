#include "print.h"
#include "counter.h"


void main(void) {

	uint32_t counter;
	
	print_str("hello world");
	print_chr('\n');

	counter_clear();
	counter_start();
	counter_stop();

	counter = counter_get_value();
	print_hex((unsigned int)(counter), 8);
	print_chr('\n');
}
