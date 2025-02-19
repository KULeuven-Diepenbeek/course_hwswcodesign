#define LED_BASEAxDDRESS 0x80000000
#define LED_REG0_ADDRESS (LED_BASEAxDDRESS + 0*4)
#define LED              (*(volatile unsigned int *) LED_REG0_ADDRESS)

void main(void) {
	
	unsigned int counter=1;

	while(1) {
		if (counter == 4) {
			counter = 0;
			LED = 0xFFFFFFFF;
		} else {
			counter += 1;
			LED = 0x1;
		}
		
		LED = 0x0;
	}
}