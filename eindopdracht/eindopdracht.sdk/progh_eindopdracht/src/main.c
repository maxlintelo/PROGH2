#include <stdlib.h>
#include <stdio.h>

#include "xgpio.h" // AXI GPIO
#include "xil_printf.h" // USB UART
#include "xparameters.h" // PERIPHERALS

int main(void) {
	XGpio physical_gpio;
	XGpio gpio;

	u32 btn, led;

	// GPIO Init
	XGpio_Initialize(&physical_gpio, 0);
	XGpio_Initialize(&gpio, 1);

	XGpio_SetDataDirection(&physical_gpio, 2, 0x00000000); // Output leds
	XGpio_SetDataDirection(&physical_gpio, 1, 0xFFFFFFFF); // Input switches

	XGpio_SetDataDirection(&gpio, 2, 0x00000000); // Internal outputs
	XGpio_SetDataDirection(&gpio, 1, 0xFFFFFFFF); // Internal inputs

	while(1) {
		btn = XGpio_DiscreteRead(&physical_gpio, 1);

		if (btn != 0) // turn all LEDs on when any button is pressed
			led = 0xFFFFFFFF;
		else
			led = 0x00000000;

		XGpio_DiscreteWrite(&physical_gpio, 2, led);

		xil_printf("\rbutton state: %08x", btn);
	}
	return 0;
}
