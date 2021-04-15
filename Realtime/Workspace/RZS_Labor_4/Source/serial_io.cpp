/*
 * serial_io.cpp
 *
 *  Created on: Jul 3, 2013
 *      Author: schaefer
 */

#include "serial_io.h"

serial_io::serial_io()
{
}

void serial_io::puts( const char * data)
{
	while (*data != 0)
		put( *data++);
}
void serial_io::newline( void)
{
	puts((char *)"\r\n");
}
void serial_io::blank( void)
{
	put( ' ');
}
