/*
 * serial_io.h
 *
 *  Created on: Jul 3, 2013
 *      Author: schaefer
 */

#ifndef SERIAL_IO_H_
#define SERIAL_IO_H_

class serial_io
{
public:
	serial_io();
	virtual void put( char) = 0;
	virtual void puts( const char * data);
	void newline( void);
	void blank( void);
	virtual bool input_ready(void) = 0;
	virtual char get( void) = 0;
	virtual char get_blocking( void)
	{
	  return get(); // default if blocking not supported
	}
};

#endif /* SERIAL_IO_H_ */
