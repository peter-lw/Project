/*
 * usart1driver.h
 *
 *  Created on: Dec 20, 2016
 *      Author: schaefer
 */

#ifndef APPLICATION_USER_USART1DRIVER_H_
#define APPLICATION_USER_USART1DRIVER_H_

#include "serial_io.h"
#include "FreeRTOS_wrapper.h"

class usart1_driver : public serial_io
{
public:
	usart1_driver( unsigned baudrate);
	void put( char);
	bool input_ready(void)
	{
		return RX_queue.messages_waiting() !=0;
	}
	char get( void)
	{
		char retv;
		(void)(RX_queue.receive(retv));
		return retv;
	}
static void IRQ_handler(void);
static Queue <char> TX_queue;
static Queue <char> RX_queue;
};

#endif /* APPLICATION_USER_USART1DRIVER_H_ */
