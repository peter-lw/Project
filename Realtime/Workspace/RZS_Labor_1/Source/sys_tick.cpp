/**
  ******************************************************************************
  * @file           : sys_tick.cpp
  * @brief          : periodic interrupt driver
  ******************************************************************************
*/
#include "sys_tick.h"

volatile uint32_t timer_ticks_1000Hz; //!< written by SysTick ISR
volatile uint32_t new_timer_ticks_1000Hz;
/**
  * @brief systick callback
  * setiap naik 1ms nambah counting 1;
  * called from SysTick ISR within interrupt context
  */
extern "C" void sys_tick_callback(void)
{
  ++timer_ticks_1000Hz;
  ++new_timer_ticks_1000Hz;
}





