/**
  ******************************************************************************
  * @file           : button.h
  * @brief          : pushbutton GPIO driver
  ******************************************************************************
*/
#ifndef BUTTON_H_
#define BUTTON_H_
#include "stdint.h"
#include "main.h"
#include "LED.h"
#include "FreeRTOS_wrapper.h"


void Button_Init(void);

extern volatile uint32_t button_interrupt_count; // button ISR -> user interface
extern Queue<bool>Flag;

#endif /* BUTTON_H_ */
