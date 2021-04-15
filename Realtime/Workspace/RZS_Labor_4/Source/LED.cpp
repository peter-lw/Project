
#include "stm32f7508_discovery.h"
#include "FreeRTOS_wrapper.h"
#include "LED.h"

extern Semaphore mySemaphore;

void LED_runnable (void *argument)
{
  BSP_LED_Init (LED1);
  for (;;)
    {
      //vTaskSuspend(NULL); 	// LED-Toggling mit vTaskSuspend der FreeRTOS-Bibliothek
      mySemaphore.wait();	// LED-Toggling mit wait-Funktion der Klasse "Semaphore"
      BSP_LED_Toggle (LED1);
    }
}

Semaphore mySemaphore(1,0);

Task toggle_led(LED_runnable, "LED");


