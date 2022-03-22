/* C Includes ----------------------------------------------------------------*/
/* CODE BEGIN C Includes */
#include <stdlib.h>
#include <stdio.h>
/* CODE END C Includes */

/* Microblaze Includes -------------------------------------------------------*/
/* CODE BEGIN MB Includes */
#include "xgpio.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"
/* CODE END MB Includes */

/* Private typedef -----------------------------------------------------------*/
/* CODE BEGIN PTD */
typedef enum {
	COLOR_RED = 0,
	COLOR_GREEN,
	COLOR_BLACK,
	NUM_COLOR
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
	ACCIDENTAL_FLAT = 0,
	ACCIDENTAL_NATURAL,
	ACCIDENTAL_SHARP,
	NUM_ACCIDENTAL
} accidental_t;
typedef struct {
	pitch_t pitch;
	accidental_t accidental;
} note_t;
/* CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* CODE BEGIN PD */
#define HEIGHT_OFFSET 787
#define NOTE_HEIGHT 53
#define INITIAL_TONE_MS 500
#define CORRECT_TONE_MS 800
#define ERROR_TONE_MS 1000
/* CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* CODE BEGIN PM */
#define PITCH_TO_HEIGHT(pitch) (HEIGHT_OFFSET - (pitch * NOTE_HEIGHT))
#define RANDOM_NUMBER(lower, higher) ((rand() % ((higher + 1) - lower)) + lower)
#define SEND_SCORES(fails, score) XGpio_DiscreteWrite(&score_o, 1, ((fails % 100) << 16) | (score % 100))
/* CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* CODE BEGIN PV */
XGpio physical_gpio;
XGpio gpio;
XGpio score_o;
u32 new_GpioOut = 0;
uint8_t score = 0;
uint8_t fails = 0;
/* CODE END PV */

/* Private function prototype ------------------------------------------------*/
/* CODE BEGIN PFP */
note_t key_to_note(uint8_t);
void io_send_sound_note(note_t);
void io_set_sound_enabled(uint8_t);
void io_send_screen_note(note_t);
void io_set_note_color(color_t);
uint8_t kb_wait_for_code(void);
uint8_t kb_wait_for_key_pressed(void);
note_t get_random_note(void);
void initialize_gpio(void);
/* CODE END PFP */

/* Code ----------------------------------------------------------------------*/
/* CODE BEGIN */
note_t key_to_note(uint8_t pressed_key) {
	switch(pressed_key) {
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
void io_send_sound_note(note_t note) {
	new_GpioOut &= ~(0xFC << 24);
	new_GpioOut |= ((uint8_t) note.pitch << 28);
	if (note.accidental == ACCIDENTAL_FLAT) {
		new_GpioOut |= (1 << 27);
	} else if (note.accidental == ACCIDENTAL_SHARP) {
		new_GpioOut |= (1 << 26);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}
void io_set_sound_enabled(uint8_t enable) {
	if (enable) {
		new_GpioOut |= (1 << 17);
	} else {
		new_GpioOut &= ~(1 << 17);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}
void io_send_screen_note(note_t note) {
	new_GpioOut &= ~(0xFFFF);
	new_GpioOut |= PITCH_TO_HEIGHT(note.pitch);

	new_GpioOut &= ~(1 << 23);
	new_GpioOut &= ~(1 << 22);
	if (note.accidental == ACCIDENTAL_FLAT) {
		new_GpioOut |= (1 << 23);
	} else if (note.accidental == ACCIDENTAL_SHARP) {
		new_GpioOut |= (1 << 22);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}
void io_set_note_color(color_t color) {
	new_GpioOut &= ~(1 << 24);
	new_GpioOut &= ~(1 << 25);
	if (color == COLOR_RED) {
		new_GpioOut |= (1 << 24);
	} else if (color == COLOR_GREEN) {
		new_GpioOut |= (1 << 25);
	}
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
}

uint8_t kb_wait_for_code(void) {
	while (!(XGpio_DiscreteRead(&gpio, 1) & (1 << 0))) {
	}
	uint8_t fpga_data = (uint8_t) (XGpio_DiscreteRead(&gpio, 1) >> 24);
	new_GpioOut |= (1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
	new_GpioOut &= ~(1 << 16);
	XGpio_DiscreteWrite(&gpio, 2, new_GpioOut);
	return fpga_data;
}
uint8_t kb_wait_for_key_pressed(void) {
	uint8_t code = kb_wait_for_code();
	while (kb_wait_for_code() == code) {
	}
	kb_wait_for_code();
	return code;
}
note_t get_random_note(void) {
	uint8_t pitch = RANDOM_NUMBER(0, NUM_PITCH - 1);
	uint8_t acc = RANDOM_NUMBER(0, NUM_ACCIDENTAL - 1);
	xil_printf("\rr_pitch: %d, r_accidental: %d", pitch, acc);
	return (note_t ) {
		.pitch = (pitch_t) pitch,
		.accidental = (accidental_t) acc
	};
}

void initialize_gpio(void) {
	/* Connects GPIO to their device IDs */
	XGpio_Initialize(&physical_gpio, 0);
	XGpio_Initialize(&gpio, 1);
	XGpio_Initialize(&score_o, 2);
	/* Basys 3 leds */
	XGpio_SetDataDirection(&physical_gpio, 2, 0x00000000);
	/* Basys 3 switches */
	XGpio_SetDataDirection(&physical_gpio, 1, 0xFFFFFFFF);
	/* Internal outputs */
	XGpio_SetDataDirection(&gpio, 1, 0x00000000);
	/* Internal inputs */
	XGpio_SetDataDirection(&gpio, 2, 0xFFFFFFFF);
	/* Score outputs */
	XGpio_SetDataDirection(&score_o, 1, 0x00000000); // Score
}

/*
 * Entrypoint
 */
int main(void) {
	/* Init GPIO */
	initialize_gpio();
	/* TODO Get random seed */
	srand(0);

	while (1) {
		/* Send score */
		SEND_SCORES(score, fails);
		/* Generate random note */
		note_t random_note = get_random_note();
		/* Play the note */
		io_send_sound_note(random_note);
		io_set_sound_enabled(1);
		/* Show the note */
		io_set_note_color(COLOR_BLACK);
		io_send_screen_note(random_note);
		/* Stop the sound */
		usleep(INITIAL_TONE_MS * 1000);
		io_set_sound_enabled(0);

		while(1) {
			/* Change note to black */
			io_set_note_color(COLOR_BLACK);
			uint8_t pressed_key = kb_wait_for_key_pressed();
			note_t pressed_note = key_to_note(pressed_key);
			if(pressed_note.pitch == random_note.pitch && pressed_note.accidental == random_note.accidental) {
				/* Update score */
				SEND_SCORES(++score, fails);
				/* Change note to green */
				io_set_note_color(COLOR_GREEN);
				/* Play the same note */
				io_send_sound_note(random_note);
				io_set_sound_enabled(1);
				usleep(CORRECT_TONE_MS * 1000);
				io_set_sound_enabled(0);
				break;
			} else {
				/* Update score */
				SEND_SCORES(score, ++fails);
				/* Change note to red */
				io_set_note_color(COLOR_RED);
				/* Play error sound sound */
				io_send_sound_note((note_t){.pitch = PITCH_G5, .accidental = ACCIDENTAL_NATURAL});
				io_set_sound_enabled(1);
				usleep((ERROR_TONE_MS / 5) * 1000);
				io_send_sound_note((note_t){.pitch = PITCH_F5, .accidental = ACCIDENTAL_FLAT});
				usleep((ERROR_TONE_MS / 5 * 4) * 1000);
				io_set_sound_enabled(0);
			}
		}
	}
	return 0;
}
/* CODE END */
