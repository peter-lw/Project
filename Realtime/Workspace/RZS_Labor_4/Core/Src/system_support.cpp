/*
* system_support.cpp
 *
 *  Created on: Nov 2, 2015
 *      Author: schaefer
 */

#include "stm32f7xx_hal.h"
#include "FreeRTOS.h"
#include "task.h"

#define CACHING 0

uint64_t SystemTicks;

extern "C" void vPortInitMemory ();
extern "C" void init_system (void)
{
//	extern int _s_system_ram;
//	extern int _e_system_ram;
//
//	for(int *ptr = &_s_system_ram; ptr < &_e_system_ram; ++ptr)
//	*ptr = 0;

	vPortInitMemory ();

#if configUSE_TRACE_FACILITY == 1
	vTraceEnable(TRC_INIT);
#endif
}

volatile uint32_t idle_counter;

extern "C" void vApplicationIdleHook( void)
{
	++idle_counter;
}

extern "C" __weak void Systick_Callback( uint64_t ticks)
{
}

/********************************************************************//**
 * @brief Tick Hook: Callback for system Tick ISR
 *
 * do SystemTicks timekeeping
 *********************************************************************/
extern "C" void vApplicationTickHook( void)
{
  ++SystemTicks;
  HAL_IncTick();
  Systick_Callback( SystemTicks);
}

extern "C" uint64_t getTime_usec_privileged(void)
{
  uint64_t time;
  uint64_t present_systick;
  uint64_t reload = (* (uint32_t *)0xe000e014) + 1;

  do
  {
	  __DSB();
	  time= __LDREXW( (uint32_t*)&SystemTicks);
	  present_systick=(uint64_t) ( * (uint32_t *)0xe000e018);
	  __DSB();
  }
  while( __STREXW( (uint32_t)time, (uint32_t*)&SystemTicks) != 0)

  ; // milliseconds -> microseconds
  time *= 1000;

  present_systick = reload - present_systick; // because it's a down-counter
  present_systick *= 1000; // millisecs -> microsecs
  present_systick /= reload;

  return time + present_systick;
}

extern "C" BaseType_t xPortRaisePrivilege( void );

//typedef int ( *FPTR)( void *); // declare void* -> int function pointer
//int call_function_privileged( void * parameters, FPTR function)
//{
//  portBASE_TYPE running_privileged = xPortRaisePrivilege();
//  int retval = function( parameters );
//  if( ! running_privileged)
//    portSWITCH_TO_USER_MODE(); // go protected again
//  return retval;
//}

//static int getTime_usec_helper(void *parameters)
//{
//  *(uint64_t *)parameters = getTime_usec_privileged();
//  return 0; // no meaningful return value here
//}
//
//uint64_t getTime_usec(void)
//{
//  uint64_t retv;
//  (void)call_function_privileged( &retv, getTime_usec_helper);
//  return retv;
//}
//
//extern "C" void * _sbrk( uint32_t size)
//{
//	extern uint32_t _end;
//	extern uint32_t _heap_end;
//	static uint32_t * current_end=&_end;
//	current_end += size;
//	if( current_end >= &_heap_end)
//		return (void *)0;
//	else
//		return current_end;
//}

extern "C" void HAL_Delay(uint32_t delay)
{
	// MPU_vTaskDelay( delay);
	vTaskDelay( delay);
}
extern "C" void __cxa_pure_virtual( void) {}
extern "C" void _init(void) {}
