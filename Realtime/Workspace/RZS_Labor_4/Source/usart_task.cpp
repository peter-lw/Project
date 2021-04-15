#include <usart1driver.h>
#include "FreeRTOS_wrapper.h"

#ifndef ROM
#define ROM const __attribute__ ((section (".rodata")))
#endif

static ROM char t1[]="Hello from USART1\r\n";

static void runnable( void *)
{
  usart1_driver usart(115200);

  usart.puts(t1);

  while( true) // echo loop
  {
	  char c = usart.get();
	  usart.put( c);
  }
}

Task usart_tester(runnable);
