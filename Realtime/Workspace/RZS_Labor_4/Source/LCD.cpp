#include "main.h"
#include "stm32f7508_discovery.h"
#include "stm32f7508_discovery_lcd.h"
#include "FreeRTOS_wrapper.h"
#include "my_memory.h"
#include "touchscreen.h"
#include "stdlib.h"
#include "string.h"
#include "button.h"

extern volatile uint32_t idle_counter;

#define MULT 1 // tuning factors for idle measurement
#define SHIFT 0

void LCD_runnable (void*)
{
  uint64_t serial;
  serial = *(uint32_t*) 0x1ff0f420;
  serial |= (uint64_t) (*(uint32_t*) 0x1ff0f424) << 32;
  serial ^= (uint64_t) (*(uint32_t*) 0x1ff0f428) << 24;
  serial ^= serial << 8;

  BSP_LCD_Init ();
  BSP_LCD_LayerDefaultInit (LTDC_ACTIVE_LAYER, SDRAM_DEVICE_ADDR);
  BSP_LCD_SelectLayer (LTDC_ACTIVE_LAYER);
  BSP_LCD_DisplayOn ();
  BSP_LCD_SetFont (&LCD_DEFAULT_FONT);
  BSP_LCD_Clear(LCD_COLOR_YELLOW);

  BSP_LCD_SetFont (&Font24);
  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);
  BSP_LCD_FillRect(0, 0, BSP_LCD_GetXSize(), Font24.Height * 3);

  BSP_LCD_SetTextColor(LCD_COLOR_WHITE);
  BSP_LCD_SetBackColor(LCD_COLOR_BLUE);
  BSP_LCD_DisplayStringAt(
      0, Font24.Height , (unsigned char *)"RZS Construction Site", CENTER_MODE);

  BSP_LCD_SetBackColor(LCD_COLOR_YELLOW);
  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

  //Button red
  BSP_LCD_SetTextColor(LCD_COLOR_RED);
  BSP_LCD_FillRect( 300, 200, 40, 40);
  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

  //Button orange
  BSP_LCD_SetTextColor(LCD_COLOR_ORANGE);
  BSP_LCD_FillRect( 350, 200, 40, 40);
  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

  //Button green
  BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
  BSP_LCD_FillRect( 400, 200, 40, 40);
  BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

  //  static char line[30] = "BrdID:";
  //  itoa(serial, line + strlen( line),16);
  //  BSP_LCD_DisplayStringAtLine (10, (uint8_t*)line);

  bool flag;
  touch_coordinates coo;
  while (true) {
      if( touch_queue.receive(coo, 200)){

	  char buf[40]; // beware: limited length !
	  strcpy(buf, "Touch x =");
	  itoa( coo.x, buf + strlen(buf),10);
	  //strcpy(buf + strlen(buf), "       "); // wipe old info
	  BSP_LCD_DisplayStringAtLine (9, (uint8_t*)buf);
	  strcpy(buf, "Touch y =");
	  itoa( coo.y, buf+strlen(buf),10);
	  //strcpy(buf + strlen(buf), "       ");
	  BSP_LCD_DisplayStringAtLine (10,(uint8_t*) buf);
      }
      if(Flag.receive(flag, 200)){
	  char buf[40]; // beware: limited length !
	  strcpy(buf, "Button = true");
	  BSP_LCD_DisplayStringAtLine (9, (uint8_t*)buf);
      }
  }
  //  strcpy( line, "idle :");
  //  itoa( idle_counter * MULT >> SHIFT, line + strlen(line), 10); // may be tuned for 100 %
  //  strcpy( line + strlen(line), "     "); // clean line end
  //  idle_counter=0; // new measurement started
  //  BSP_LCD_DisplayStringAtLine (9, (uint8_t*) line);
  //  delay( 200);
}




Task LCD_Task0( LCD_runnable, "LCD", configMINIMAL_STACK_SIZE, 0, 4);

