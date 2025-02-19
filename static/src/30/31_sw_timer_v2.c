#define LED_BASEAxDDRESS 0x80000000
#define LED_REG0_ADDRESS (LED_BASEAxDDRESS + 0*4)
#define LED              (*(volatile unsigned int *) LED_REG0_ADDRESS)

#define WAIT_IMIT 		 20

void wait() {
	volatile unsigned int i,j ;
	for (i=0; i<WAIT_IMIT; i++)
		for (j=0; j<WAIT_IMIT; j++);
}

void main(void) {
	
	unsigned int counter=1;

	while(1) {
		if (counter == 4) {
			counter = 1;
			LED = 0xFFFFFFFF;
		} else {
			counter += 1;
			LED = 0x1;
		}
		wait();
		
		LED = 0x0;
		wait();
	}
}