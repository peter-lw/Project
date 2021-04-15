#ifndef APPLICATION_TOUCHSCREEN_H_
#define APPLICATION_TOUCHSCREEN_H_

typedef struct
{
	uint16_t x;
	uint16_t y;
//	uint16_t z;
}
touch_coordinates;

extern Queue <touch_coordinates> touch_queue;

#endif /* APPLICATION_TOUCHSCREEN_H_ */
