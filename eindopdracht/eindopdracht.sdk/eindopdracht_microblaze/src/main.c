#include <stdlib.h>
#include <stdio.h>

#include "xgpio.h" // AXI GPIO
#include "xil_printf.h" // USB UART
#include "xparameters.h" // PERIPHERALS
#include "sleep.h"

int random_number(int min_num, int max_num)
{
	int result = 0, low_num = 0, hi_num = 0;

	if (min_num < max_num)
	{
		low_num = min_num;
		hi_num = max_num + 1; // include max_num in output
	} else {
		low_num = max_num + 1; // include max_num in output
		hi_num = min_num;
	}

	result = (rand() % (hi_num - low_num)) + low_num;
	return result;
}

int main(void) {
	XGpio physical_gpio;
	XGpio gpio;

	u32 btn, led;

	// GPIO Init
	XGpio_Initialize(&physical_gpio, 0);
	XGpio_Initialize(&gpio, 1);

	XGpio_SetDataDirection(&physical_gpio, 2, 0x00000000); // Output leds
	XGpio_SetDataDirection(&physical_gpio, 1, 0xFFFFFFFF); // Input switches

	XGpio_SetDataDirection(&gpio, 1, 0x00000000); // Internal outputs
	XGpio_SetDataDirection(&gpio, 2, 0xFFFFFFFF); // Internal inputs

	u16 note = 0;

	while(1) {
		btn = XGpio_DiscreteRead(&physical_gpio, 1);

		if (btn != 0) // turn all LEDs on when any button is pressed
			led = 0xFFFFFFFF;
		else
			led = 0x00000000;

		XGpio_DiscreteWrite(&gpio, 2, random_number(1, 24));
		//XGpio_DiscreteWrite(&gpio, 2, btn);

		xil_printf("\rbutton state: %08x", btn);
		usleep(100000);
	}
	return 0;
}
