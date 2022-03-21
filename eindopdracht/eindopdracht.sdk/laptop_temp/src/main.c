#include <stdlib.h>
#include <stdio.h>

#include "xgpio.h" // AXI GPIO
#include "xil_printf.h" // USB UART
#include "xparameters.h" // PERIPHERALS
#include "sleep.h"

typedef enum {
	COLOR_RED = 0, COLOR_GREEN, COLOR_BLACK
} color_t;

typedef enum {
	PITCH_C5 = 0,
	PITCH_D5,
	PITCH_E5,
	PITCH_F5,
	PITCH_G5,
	PITCH_A5,
	PITCH_B5,
	PITCH_C6,
	PITCH_D6,
	PITCH_E6,
	PITCH_F6,
	NUM_PITCH
} pitch_t;

typedef enum {
	ACCIDENTAL_FLAT = 0, ACCIDENTAL_NATURAL, ACCIDENTAL_SHARP, NUM_ACCIDENTAL
} accidental_t;

typedef struct {
	pitch_t pitch;
	accidental_t accidental;
} note_t;

note_t getNotePressed(uint8_t keyPressed) {
	switch(keyPressed) {
	// All naturals
	case 0x1C:
		return (note_t){.pitch = PITCH_C5, .accidental = ACCIDENTAL_NATURAL};
	case 0x1B:
		return (note_t){.pitch = PITCH_D5, .accidental = ACCIDENTAL_NATURAL};
	case 0x23:
		return (note_t){.pitch = PITCH_E5, .accidental = ACCIDENTAL_NATURAL};
	case 0x2B:
		return (note_t){.pitch = PITCH_F5, .accidental = ACCIDENTAL_NATURAL};
	case 0x34:
		return (note_t){.pitch = PITCH_G5, .accidental = ACCIDENTAL_NATURAL};
	case 0x33:
		return (note_t){.pitch = PITCH_A5, .accidental = ACCIDENTAL_NATURAL};
	case 0x3B:
		return (note_t){.pitch = PITCH_B5, .accidental = ACCIDENTAL_NATURAL};
	case 0x42:
		return (note_t){.pitch = PITCH_C6, .accidental = ACCIDENTAL_NATURAL};
	case 0x4B:
		return (note_t){.pitch = PITCH_D6, .accidental = ACCIDENTAL_NATURAL};
	case 0x4c:
		return (note_t){.pitch = PITCH_E6, .accidental = ACCIDENTAL_NATURAL};
	case 0x52:
		return (note_t){.pitch = PITCH_F6, .accidental = ACCIDENTAL_NATURAL};
	// All sharps
	case 0x15:
		return (note_t){.pitch = PITCH_C5, .accidental = ACCIDENTAL_SHARP};
	case 0x1d:
		return (note_t){.pitch = PITCH_D5, .accidental = ACCIDENTAL_SHARP};
	case 0x24:
		return (note_t){.pitch = PITCH_E5, .accidental = ACCIDENTAL_SHARP};
	case 0x2d:
		return (note_t){.pitch = PITCH_F5, .accidental = ACCIDENTAL_SHARP};
	case 0x2c:
		return (note_t){.pitch = PITCH_G5, .accidental = ACCIDENTAL_SHARP};
	case 0x35:
		return (note_t){.pitch = PITCH_A5, .accidental = ACCIDENTAL_SHARP};
	case 0x3c:
		return (note_t){.pitch = PITCH_B5, .accidental = ACCIDENTAL_SHARP};
	case 0x43:
		return (note_t){.pitch = PITCH_C6, .accidental = ACCIDENTAL_SHARP};
	case 0x44:
		return (note_t){.pitch = PITCH_D6, .accidental = ACCIDENTAL_SHARP};
	case 0x4d:
		return (note_t){.pitch = PITCH_E6, .accidental = ACCIDENTAL_SHARP};
	case 0x54:
		return (note_t){.pitch = PITCH_F6, .accidental = ACCIDENTAL_SHARP};
	// All flats
	case 0x1a:
		return (note_t){.pitch = PITCH_C5, .accidental = ACCIDENTAL_FLAT};
	case 0x22:
		return (note_t){.pitch = PITCH_D5, .accidental = ACCIDENTAL_FLAT};
	case 0x21:
		return (note_t){.pitch = PITCH_E5, .accidental = ACCIDENTAL_FLAT};
	case 0x2a:
		return (note_t){.pitch = PITCH_F5, .accidental = ACCIDENTAL_FLAT};
	case 0x32:
		return (note_t){.pitch = PITCH_G5, .accidental = ACCIDENTAL_FLAT};
	case 0x31:
		return (note_t){.pitch = PITCH_A5, .accidental = ACCIDENTAL_FLAT};
	case 0x3a:
		return (note_t){.pitch = PITCH_B5, .accidental = ACCIDENTAL_FLAT};
	case 0x41:
		return (note_t){.pitch = PITCH_C6, .accidental = ACCIDENTAL_FLAT};
	case 0x49:
		return (note_t){.pitch = PITCH_D6, .accidental = ACCIDENTAL_FLAT};
	case 0x4a:
		return (note_t){.pitch = PITCH_E6, .accidental = ACCIDENTAL_FLAT};
	case 0x59:
		return (note_t){.pitch = PITCH_F6, .accidental = ACCIDENTAL_FLAT};
	default:
		return (note_t){.pitch = PITCH_C5, .accidental = ACCIDENTAL_NATURAL};
	}
}

static uint16_t new_GetNoteHeight(note_t note) {
	uint16_t start = 787; // Lower C
	for (uint8_t i = 0; i < (uint8_t) note.pitch; i++) {
		start -= 53;
	}
	return start;
}

/*
 * GPIO
 * 31   27   23   19   15   11   7    3
 * 0000_0000_0000_0000_0000_0000_0000_0000
 * ^^^^------------------------------------ NOTE PITCH
 *		^^--------------------------------- ACCIDENTAL
 * 		  ^^------------------------------- COLOR
 * 		  	 ^^---------------------------- SCREEN ACCIDENTAL
 * 					^---------------------- SOUND ENABLED
 * 					 ^--------------------- RESET KEYBOARD
 * 					   ^^^^ ^^^^ ^^^^ ^^^^- NOTE HEIGHT Y
 */

XGpio physical_gpio;
XGpio gpio;

u32 new_GpioOut = 0x00000000;
void new_SendSoundNote(note_t note) {
	new_GpioOut &= ~(0xFC << 24);
	new_GpioOut |= ((uint8_t) note.pitch << 28);
	if (note.accidental == ACCIDENTAL_FLAT) {
		new_GpioOut |= (1 << 27);
	} else if (note.accidental == ACCIDENTAL_SHARP) {
		new_GpioOut |= (1 << 26);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}
void new_SetSoundEnabled(uint8_t enable) {
	if (enable) {
		new_GpioOut |= (1 << 17);
	} else {
		new_GpioOut &= ~(1 << 17);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}
void new_SendScreenNote(note_t note) {
	// Reset the note height on the screen
	new_GpioOut &= ~(0xFFFF);
	// Set the new height
	new_GpioOut |= new_GetNoteHeight(note);

	new_GpioOut &= ~(1 << 23);
	new_GpioOut &= ~(1 << 22);
	if (note.accidental == ACCIDENTAL_FLAT) {
		new_GpioOut |= (1 << 23);
	} else if (note.accidental == ACCIDENTAL_SHARP) {
		new_GpioOut |= (1 << 22);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}

void new_SetNoteColor(color_t color) {
	new_GpioOut &= ~(1 << 24);
	new_GpioOut &= ~(1 << 25);
	if (color == COLOR_RED) {
		new_GpioOut |= (1 << 24);
	} else if (color == COLOR_GREEN) {
		new_GpioOut |= (1 << 25);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}

uint8_t waitForCode() {
	while (!(XGpio_DiscreteRead(&gpio, 1) & (1 << 0))) {
	}
	uint8_t fpga_data = (uint8_t) (XGpio_DiscreteRead(&gpio, 1) >> 24);
	new_GpioOut |= (1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
	new_GpioOut &= ~(1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
	return fpga_data;
}
uint8_t new_WaitForKey() {
	uint8_t code = waitForCode();
	while (waitForCode() == code) {
	}
	waitForCode();
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

note_t getRandomNote() {
	return (note_t ) {
		.pitch = (pitch_t) random_number(0, NUM_PITCH - 1),
		.accidental = (accidental_t) random_number(0, NUM_ACCIDENTAL - 1)
	};
}

void init(void) {
	XGpio_Initialize(&physical_gpio, 0);
	XGpio_Initialize(&gpio, 1);
	XGpio_SetDataDirection(&physical_gpio, 2, 0x00000000); // Output leds
	XGpio_SetDataDirection(&physical_gpio, 1, 0xFFFFFFFF); // Input switches
	XGpio_SetDataDirection(&gpio, 1, 0x00000000); // Internal outputs
	XGpio_SetDataDirection(&gpio, 2, 0xFFFFFFFF); // Internal inputs
}

//XGpio_DiscreteWrite(&gpio, 2, data);
//XGpio_DiscreteWrite(&physical_gpio, 2, data >> 16);



int main(void) {
	init();
	srand(12); // TODO Random seed
	while (1) {
		note_t random_note = getRandomNote();
		new_SendSoundNote(random_note);
		new_SetNoteColor(COLOR_BLACK);
		new_SendScreenNote(random_note);
		new_SetSoundEnabled(1);
		usleep(500000);
		new_SetSoundEnabled(0);



		while(1) {
			uint8_t pressed_key = new_WaitForKey(); // Blocking
			xil_printf("\rkey pressed: %08x", pressed_key);
			note_t pressed_note = getNotePressed(pressed_key);
			if(pressed_note.pitch == random_note.pitch && pressed_note.accidental == random_note.accidental) {
				xil_printf("\rsuccess");
				new_SetNoteColor(COLOR_GREEN);
				new_SendSoundNote(random_note);
				new_SetSoundEnabled(1);
				usleep(1000000);
				new_SetNoteColor(COLOR_BLACK);
				new_SetSoundEnabled(0);
				break;
			} else {
				new_SetNoteColor(COLOR_RED);

				new_SendSoundNote((note_t){.pitch = PITCH_G5, .accidental = ACCIDENTAL_NATURAL});
				new_SetSoundEnabled(1);
				usleep(200000);
				new_SendSoundNote((note_t){.pitch = PITCH_F5, .accidental = ACCIDENTAL_FLAT});
				usleep(800000);

				new_SetSoundEnabled(0);
				new_SetNoteColor(COLOR_BLACK);
			}
		}
	}
	return 0;
}
