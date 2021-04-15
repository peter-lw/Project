/*
 * usart1driver.cpp
 *
 *  Created on: Dec 20, 2016
 *      Author: schaefer
 */

#include <usart1driver.h>
#include "stm32f7xx_hal.h"
#include "stm32f7508_discovery.h"
//#include "string.h"

#define USARTx                           USART1
#define USARTx_CLK_ENABLE()              __USART1_CLK_ENABLE()
#define USARTx_RX_GPIO_CLK_ENABLE()      __GPIOB_CLK_ENABLE()
#define USARTx_TX_GPIO_CLK_ENABLE()      __GPIOA_CLK_ENABLE()

#define USARTx_FORCE_RESET()             __USART1_FORCE_RESET()
#define USARTx_RELEASE_RESET()           __USART1_RELEASE_RESET()

/* Definition for USARTx Pins */
#define USARTx_TX_PIN                    GPIO_PIN_9
#define USARTx_TX_GPIO_PORT              GPIOA
#define USARTx_TX_AF                     GPIO_AF7_USART1
#define USARTx_RX_PIN                    GPIO_PIN_7
#define USARTx_RX_GPIO_PORT              GPIOB
#define USARTx_RX_AF                     GPIO_AF7_USART1

#define USARTx_IRQn                      USART1_IRQn

UART_HandleTypeDef UartHandle;

/**
  * @brief UART MSP Initialization
  *        This function configures the hardware resources used in this example:
  *           - Peripheral's clock enable
  *           - Peripheral's GPIO Configuration
  *           - NVIC configuration for UART interrupt request enable
  * @param huart: UART handle pointer
  * @retval None
  */
extern "C" void HAL_UART_MspInit(UART_HandleTypeDef *huart)
{
  GPIO_InitTypeDef  GPIO_InitStruct={0};
  wipe( GPIO_InitStruct);

  /*##-1- Enable peripherals and GPIO Clocks #################################*/
  /* Enable GPIO TX/RX clock */
  USARTx_TX_GPIO_CLK_ENABLE();
  USARTx_RX_GPIO_CLK_ENABLE();

  /* Enable USARTx clock */
  USARTx_CLK_ENABLE();

  /*##-2- Configure peripheral GPIO ##########################################*/
  /* UART TX GPIO pin configuration  */
  GPIO_InitStruct.Pin       = USARTx_TX_PIN;
  GPIO_InitStruct.Mode      = GPIO_MODE_AF_PP;
  GPIO_InitStruct.Pull      = GPIO_PULLUP;
  GPIO_InitStruct.Speed     = GPIO_SPEED_HIGH;
  GPIO_InitStruct.Alternate = USARTx_TX_AF;

  HAL_GPIO_Init(USARTx_TX_GPIO_PORT, &GPIO_InitStruct);

  /* UART RX GPIO pin configuration  */
  GPIO_InitStruct.Pin = USARTx_RX_PIN;
  GPIO_InitStruct.Alternate = USARTx_RX_AF;

  HAL_GPIO_Init(USARTx_RX_GPIO_PORT, &GPIO_InitStruct);

  HAL_NVIC_SetPriority(USARTx_IRQn, 15,15);
  HAL_NVIC_EnableIRQ(USARTx_IRQn);
}

usart1_driver::usart1_driver(unsigned baudrate)
{
	  UartHandle.Instance        = USARTx;

	  UartHandle.Init.BaudRate   = baudrate;
	  UartHandle.Init.WordLength = UART_WORDLENGTH_8B;
	  UartHandle.Init.StopBits   = UART_STOPBITS_1;
	  UartHandle.Init.Parity     = UART_PARITY_NONE;
	  UartHandle.Init.HwFlowCtl  = UART_HWCONTROL_NONE;
	  UartHandle.Init.Mode       = UART_MODE_TX_RX;
	  UartHandle.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
	  if(HAL_UART_DeInit(&UartHandle) != HAL_OK)
			asm("bkpt 0");
	  if(HAL_UART_Init(&UartHandle) != HAL_OK)
			asm("bkpt 0");

	  HAL_NVIC_SetPriority(USARTx_IRQn, 15, 15);
	  HAL_NVIC_EnableIRQ(USARTx_IRQn);

	/* Enable the UART Data Register not empty Interrupt */
	__HAL_UART_ENABLE_IT(&UartHandle, UART_IT_RXNE);
}

void usart1_driver::put( char c)
{
	TX_queue.send(c);
	__HAL_UART_ENABLE_IT(&UartHandle, UART_IT_ERR);
	__HAL_UART_ENABLE_IT(&UartHandle, UART_IT_TXE);
}

Queue <char> usart1_driver::TX_queue(20);
Queue <char> usart1_driver::RX_queue(20);

void usart1_driver::IRQ_handler( void)
{
	  /* UART parity error interrupt occurred -------------------------------------*/
	  if((__HAL_UART_GET_IT(&UartHandle, UART_IT_PE) != RESET) && (__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_PE) != RESET))
			__HAL_UART_CLEAR_PEFLAG(&UartHandle);

	  /* UART frame error interrupt occurred --------------------------------------*/
	  if((__HAL_UART_GET_IT(&UartHandle, UART_IT_FE) != RESET) && (__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_ERR) != RESET))
	    __HAL_UART_CLEAR_FEFLAG(&UartHandle);

	  /* UART noise error interrupt occurred --------------------------------------*/
	  if((__HAL_UART_GET_IT(&UartHandle, UART_IT_NE) != RESET) && (__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_ERR) != RESET))
	    __HAL_UART_CLEAR_NEFLAG(&UartHandle);

	  /* UART Over-Run interrupt occurred -----------------------------------------*/
	  if((__HAL_UART_GET_IT(&UartHandle, UART_IT_ORE) != RESET) && (__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_ERR) != RESET))
	    __HAL_UART_CLEAR_OREFLAG(&UartHandle);

	  /* UART in mode Receiver ---------------------------------------------------*/
	  if((__HAL_UART_GET_IT(&UartHandle, UART_IT_RXNE) != RESET) && (__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_RXNE) != RESET))
	  {
		  char c;
	      c = (char)(UartHandle.Instance->RDR);
//	    __HAL_UART_SEND_REQ(&UartHandle, UART_RXDATA_FLUSH_REQUEST);
	    RX_queue.send_from_ISR(c);
	  }


	  /* UART in mode Transmitter ------------------------------------------------*/
	 if((__HAL_UART_GET_IT(&UartHandle, UART_IT_TXE) != RESET) &&(__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_TXE) != RESET))
	  {
		 char c;
		 bool more_data=usart1_driver::TX_queue.receive_from_ISR(c);
		 if( more_data)
			 UartHandle.Instance->TDR = c;
		 else
			 __HAL_UART_DISABLE_IT(&UartHandle, UART_IT_TXE);
 	  }

	  /* UART in mode Transmitter (transmission end) -----------------------------*/
	 if((__HAL_UART_GET_IT(&UartHandle, UART_IT_TC) != RESET) &&(__HAL_UART_GET_IT_SOURCE(&UartHandle, UART_IT_TC) != RESET))
	  {
//	    UART_EndTransmit_IT(&UartHandle);
	  }
}

extern "C" void USART1_IRQHandler(void)
{
	usart1_driver::IRQ_handler();
}

