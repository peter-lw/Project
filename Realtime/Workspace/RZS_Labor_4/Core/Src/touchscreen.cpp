//#include "system_configuration.h"
#include "FreeRTOS_wrapper.h"
#include "main.h"
#include "stm32f7508_discovery.h"
#include "stm32f7508_discovery_ts.h"
#include "stm32f7508_discovery_lcd.h"
#include "touchscreen.h"

Queue<touch_coordinates> touch_queue(4);


void touch_screen_runnable(void *)
{
  bool touch_detected = true;
  delay(250);
  uint8_t status = BSP_TS_Init(BSP_LCD_GetXSize(), BSP_LCD_GetYSize());

  if (status != TS_OK)
    suspend();

  for (synchronous_timer t(100); true; t.sync())
    {
      TS_StateTypeDef TS_State;
      BSP_TS_GetState(&TS_State);
      if (TS_State.touchDetected && (touch_detected == false))
	{
	  touch_coordinates coo;
	  coo.x = TS_State.touchX[0];
	  coo.y = TS_State.touchY[0];
	  //	        coo.z = TS_State.touchWeight[0];
	  touch_queue.send(coo, 100);
	  touch_detected = true;
	}
      else
	touch_detected = false;
    }
}

Task touch_task(touch_screen_runnable, "TOUCH", configMINIMAL_STACK_SIZE*2,0,5);

