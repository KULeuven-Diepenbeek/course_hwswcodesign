#include "counter.h"

void counter_clear(void) {
    COUNTER_CR |= COUNTER_CR_CLEAR; 
    COUNTER_CR &= ~COUNTER_CR_CLEAR;
}
