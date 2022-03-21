#include <stdlib.h>
#include <stdio.h>

#include "xgpio.h" // AXI GPIO
#include "xil_printf.h" // USB UART
#include "xparameters.h" // PERIPHERALS
#include "sleep.h"

#define false 0
#define true 1

typedef enum {
	COLOR_RED,
	COLOR_GREEN,
	COLOR_BLACK
} color_t;

XGpio physical_gpio;
XGpio gpio;

u32 output = 0x00000000;

void setColor(color_t color) {
	output &= ~(1 << 18);
	output &= ~(1 << 19);
	switch(color) {
	case COLOR_RED:
	{
		output |= (1 << 18);
		break;
	}
	case COLOR_GREEN:
	{
		output |= (1 << 19);
		break;
	}
	default:
	{
		break;
	}
	}
	XGpio_DiscreteWrite(&gpio, 2, output);
}
void enableSound() {
	output |= (1 << 17);
	XGpio_DiscreteWrite(&gpio, 2, output);
}
void disableSound() {
	output &= ~(1 << 17);
	XGpio_DiscreteWrite(&gpio, 2, output);
}
void sendSoundNote(int8_t note) {
	output &= 0xFFFFFF00;
	output |= note;
	XGpio_DiscreteWrite(&gpio, 2, output);
}
void sendScreenNote(uint8_t note) {
	output &= 0xFFFF00FF;
	output |= note << 8;
	XGpio_DiscreteWrite(&gpio, 2, output);
}
/*void sendNote(int note) {
	output &= 0xFFFF0000; // Reset rechter 16 bits
	output |= note;
	XGpio_DiscreteWrite(&gpio, 2, output);
}*/
uint8_t waitForKeycode() {
	while (!(XGpio_DiscreteRead(&gpio, 1) & (1 << 0))) {
	}
	uint8_t fpga_data = (uint8_t) (XGpio_DiscreteRead(&gpio, 1) >> 24);
	output |= (1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, output);
	output &= ~(1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, output);
	return fpga_data;
}
uint8_t getKeyPress() {
	uint8_t code = waitForKeycode();
	while (waitForKeycode() == code) {
	}
	waitForKeycode();
	return code;
}
int random_number(int min_num, int max_num) {
	int result = 0, low_num = 0, hi_num = 0;

	if (min_num < max_num) {
		low_num = min_num;
		hi_num = max_num + 1; // include max_num in output
	} else {
		low_num = max_num + 1; // include max_num in output
		hi_num = min_num;
	}

	result = (rand() % (hi_num - low_num)) + low_num;
	return result;
}

uint8_t getNote(uint8_t keyCode) {
	switch(keyCode) {
	case 0x1C:
		return 2;
	case 0x1B:
		return 5;
	case 0x23:
		return 8;
	case 0x2B:
		return 11;
	case 0x34:
		return 14;
	case 0x33:
		return 17;
	case 0x3B:
		return 20;
	case 0x42:
		return 23;
	default:
		return -1;
	}
}

int main(void) {
	u32 btn, led;
	// GPIO Init
	XGpio_Initialize(&physical_gpio, 0);
	XGpio_Initialize(&gpio, 1);

	XGpio_SetDataDirection(&physical_gpio, 2, 0x00000000); // Output leds
	XGpio_SetDataDirection(&physical_gpio, 1, 0xFFFFFFFF); // Input switches

	XGpio_SetDataDirection(&gpio, 1, 0x00000000); // Internal outputs
	XGpio_SetDataDirection(&gpio, 2, 0xFFFFFFFF); // Internal inputs

	uint8_t previousNote = -1;

	while (1) {
		uint8_t randomNoot;
		do {
			randomNoot = (random_number(0, 7) * 3) + 2;
		} while (randomNoot == previousNote);

		sendSoundNote(randomNoot);
		sendScreenNote(randomNoot);
		xil_printf("\rrandom noot: %d", randomNoot);

		enableSound();
		usleep(1000000);
		disableSound();

		while(1) {
			uint8_t keyCode = getKeyPress();
			uint8_t note = getNote(keyCode);
			xil_printf("\ruser note: %d", note);
			if(note == randomNoot) {
				xil_printf("\rsuccess");
				setColor(COLOR_GREEN);
				sendSoundNote(randomNoot);
				enableSound();
				usleep(1000000);
				setColor(COLOR_BLACK);
				disableSound();
				break;
			} else {
				enableSound();
				setColor(COLOR_RED);

				sendSoundNote(5);
				usleep(200000);
				sendSoundNote(1);
				usleep(800000);

				disableSound();
				setColor(COLOR_BLACK);
			}
		}

		previousNote = randomNoot;

		//XGpio_DiscreteWrite(&gpio, 2, XGpio_DiscreteRead(&physical_gpio, 1) << 16);
		//XGpio_DiscreteWrite(&physical_gpio, 2, XGpio_DiscreteRead(&physical_gpio, 1) << 16);
	}
	return 0;
}
