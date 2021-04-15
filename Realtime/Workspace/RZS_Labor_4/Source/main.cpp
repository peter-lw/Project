/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.c
 * @brief          : Main program body
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under Ultimate Liberty license
 * SLA0044, the "License"; You may not use this file except in compliance with
 * the License. You may obtain a copy of the License at:
 *                             www.st.com/SLA0044
 *
 ******************************************************************************
 */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/

#include "my_assert.h"
#include "trcRecorder.h"
#include "stm32f7508_discovery.h"
#include "stm32f7508_discovery_lcd.h"
#include "FreeRTOS_wrapper.h"
#include "button.h"
#include "task.h"
#include "LED.h"
#include "touchscreen.h"
#include "stdlib.h"

struct Zeit{
  int min = 0;
  int sec = 0;
  int mil = 0;
  int flag = 0;
  int akt = 0;
}zeit;


static void SystemClock_Config(void);
extern void *g_pfnVectors;
extern Semaphore mySemaphore;

//Aufgabe3 Queue
bool flag;
touch_coordinates a;
void LCD_Balken1 (void* parameter){
  while(true){
      //if((Flag.receive(flag))||(touch_queue.receive(a))){
      // if(((a.x<=340&&a.x>=300)&&(a.y<=240&&a.y>=200))||flag==true){
      for(int width=0 ; width<=480;width=width+5){
	  BSP_LCD_SetTextColor(LCD_COLOR_RED);
	  BSP_LCD_FillRect(0,100,width,20);
	  delay(25);
      }
      for(int width=479 ; width>0;width=width-5){
	  BSP_LCD_SetTextColor(LCD_COLOR_RED);
	  BSP_LCD_FillRect(0,100,width,20);
	  BSP_LCD_SetTextColor(LCD_COLOR_YELLOW);
	  BSP_LCD_FillRect(width,100, 480 - width - 1, 20);
	  delay(25);
      }
  }
}
// }
//}

void LCD_Balken2 (void* parameter){
  while(true){
      //touch_queue.receive(a);
      //if((a.x<=390&&a.x>=350)&&(a.y<=240&&a.y>=200)){
      for(int width=0 ; width<=480;width=width+5){
	  BSP_LCD_SetTextColor(LCD_COLOR_ORANGE);
	  BSP_LCD_FillRect(0,130,width,20);
	  delay(25);
      }
      for(int width=479 ; width>0;width=width-5){
	  BSP_LCD_SetTextColor(LCD_COLOR_ORANGE);
	  BSP_LCD_FillRect(0,130,width,20);
	  BSP_LCD_SetTextColor(LCD_COLOR_YELLOW);
	  BSP_LCD_FillRect(width,130, 480 - width - 1, 20);
	  delay(25);
      }
  }
}
//}

void LCD_Balken3 (void* parameter){
  while(true){
      //touch_queue.receive(a);
      //if((a.x<=440&&a.x>=400)&&(a.y<=240&&a.y>=200)){
      for(int width=0 ; width<=480;width=width+5){
	  BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
	  BSP_LCD_FillRect(0,160,width,20);
	  delay(25);
      }
      for(int width=479 ; width>0;width=width-5){
	  BSP_LCD_SetTextColor(LCD_COLOR_GREEN);
	  BSP_LCD_FillRect(0,160,width,20);
	  BSP_LCD_SetTextColor(LCD_COLOR_YELLOW);
	  BSP_LCD_FillRect(width,160, 480 - width - 1, 20);
	  delay(25);
      }
  }
}
//}

void print_time(void *p){
  unsigned i=0;
  unsigned temp=0;
  while(true){
      uint32_t count = 0;
      ++count;
      char buf[40];
      zeit.akt = count;
      zeit.mil = count%1000;
      zeit.akt = zeit.akt - temp*1000;
      if(zeit.akt>= 1000){
	  i=0;
      }
      if(zeit.akt>=1000 && i == 0){
	  zeit.sec++;
	  temp++;
	  i++;
      }
      if(zeit.sec>=60){
	  zeit.min++;
	  zeit.sec=0;
      }
      strcpy(buf, "Time   =");
      itoa( zeit.min, buf + strlen(buf),10);
      strcpy(buf+strlen(buf), ":");
      itoa( zeit.sec, buf + strlen(buf),10);
      strcpy(buf+strlen(buf), ":");
      itoa( zeit.mil, buf + strlen(buf),10);
      BSP_LCD_DisplayStringAtLine ( 9,(uint8_t*) buf);

  }
}
int main(void)
{
  // Make sure to have correct vector table base address
  SCB->VTOR = (__IOM uint32_t)&g_pfnVectors;
  SCB->SHCSR |= (SCB_SHCSR_BUSFAULTENA_Msk | SCB_SHCSR_MEMFAULTENA_Msk
      | SCB_SHCSR_USGFAULTENA_Msk);

  SystemClock_Config();

  SCB_EnableICache();
  SCB_EnableDCache();

#if configUSE_TRACE_FACILITY == 1
  vTraceEnable(TRC_START);
#endif


  __HAL_RCC_PWR_CLK_ENABLE();
  __HAL_PWR_OVERDRIVE_ENABLE();
  __HAL_PWR_OVERDRIVESWITCHING_ENABLE();
  __HAL_RCC_SYSCFG_CLK_ENABLE();
  __HAL_FLASH_ART_ENABLE();
  __HAL_FLASH_PREFETCH_BUFFER_ENABLE();

  Button_Init();

Task LCD_Task1( LCD_Balken1, "LCD Balken 1", configMINIMAL_STACK_SIZE, 0, 3);
//  Task LCD_Task2( LCD_Balken2, "LCD Balken 2", configMINIMAL_STACK_SIZE, 0, 2);
//  Task LCD_Task3( LCD_Balken3, "LCD Balken 3", configMINIMAL_STACK_SIZE, 0, 2);
  Task Time( print_time, "Time", configMINIMAL_STACK_SIZE, 0, 3);

  asm("b vTaskStartScheduler"); // start FreeRTOS, returns NEVER

}

/**
 * @brief System Clock Configuration
 * @retval None
 */
static void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};
  RCC_PeriphCLKInitTypeDef PeriphClkInitStruct = {0};

  /** Configure LSE Drive Capability
   */
  HAL_PWR_EnableBkUpAccess();
  /** Configure the main internal regulator output voltage
   */
  __HAL_RCC_PWR_CLK_ENABLE();
  __HAL_PWR_VOLTAGESCALING_CONFIG(PWR_REGULATOR_VOLTAGE_SCALE1);
  /** Initializes the RCC Oscillators according to the specified parameters
   * in the RCC_OscInitTypeDef structure.
   */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_LSI
      |RCC_OSCILLATORTYPE_HSE;
  RCC_OscInitStruct.HSEState = RCC_HSE_ON;
  RCC_OscInitStruct.LSIState = RCC_LSI_ON;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
  RCC_OscInitStruct.PLL.PLLM = 25;
  RCC_OscInitStruct.PLL.PLLN = 400;
  RCC_OscInitStruct.PLL.PLLP = RCC_PLLP_DIV2;
  RCC_OscInitStruct.PLL.PLLQ = 9;
  HAL_RCC_OscConfig(&RCC_OscInitStruct);
  //  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  //  {
  //    Error_Handler();
  //  }
  /** Initializes the CPU, AHB and APB buses clocks
   */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
      |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV4;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV2;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_6) != HAL_OK)
    {
      Error_Handler();
    }
  PeriphClkInitStruct.PeriphClockSelection = RCC_PERIPHCLK_SPDIFRX
      |RCC_PERIPHCLK_LTDC
      |RCC_PERIPHCLK_RTC|RCC_PERIPHCLK_USART1
      |RCC_PERIPHCLK_USART6|RCC_PERIPHCLK_SAI2
      |RCC_PERIPHCLK_I2C1|RCC_PERIPHCLK_I2C3
      |RCC_PERIPHCLK_SDMMC1|RCC_PERIPHCLK_CLK48;
  PeriphClkInitStruct.PLLI2S.PLLI2SN = 100;
  PeriphClkInitStruct.PLLI2S.PLLI2SP = RCC_PLLP_DIV2;
  PeriphClkInitStruct.PLLI2S.PLLI2SR = 2;
  PeriphClkInitStruct.PLLI2S.PLLI2SQ = 2;
  PeriphClkInitStruct.PLLSAI.PLLSAIN = 384;
  PeriphClkInitStruct.PLLSAI.PLLSAIR = 5;
  PeriphClkInitStruct.PLLSAI.PLLSAIQ = 2;
  PeriphClkInitStruct.PLLSAI.PLLSAIP = RCC_PLLSAIP_DIV8;
  PeriphClkInitStruct.PLLI2SDivQ = 1;
  PeriphClkInitStruct.PLLSAIDivQ = 1;
  PeriphClkInitStruct.PLLSAIDivR = RCC_PLLSAIDIVR_2;
  PeriphClkInitStruct.RTCClockSelection = RCC_RTCCLKSOURCE_LSI;
  PeriphClkInitStruct.Sai2ClockSelection = RCC_SAI2CLKSOURCE_PLLSAI;
  PeriphClkInitStruct.Usart1ClockSelection = RCC_USART1CLKSOURCE_PCLK2;
  PeriphClkInitStruct.Usart6ClockSelection = RCC_USART6CLKSOURCE_PCLK2;
  PeriphClkInitStruct.I2c1ClockSelection = RCC_I2C1CLKSOURCE_PCLK1;
  PeriphClkInitStruct.I2c3ClockSelection = RCC_I2C3CLKSOURCE_PCLK1;
  PeriphClkInitStruct.Clk48ClockSelection = RCC_CLK48SOURCE_PLLSAIP;
  PeriphClkInitStruct.Sdmmc1ClockSelection = RCC_SDMMC1CLKSOURCE_CLK48;
  if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInitStruct) != HAL_OK)
    {
      Error_Handler();
    }
}

/**
 * @brief  This function is executed in case of error occurrence.
 * @retval None
 */
void Error_Handler(void)
{
  asm("bkpt 0");
}

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
