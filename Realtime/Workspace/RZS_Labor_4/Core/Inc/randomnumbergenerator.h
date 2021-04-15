/*
 * randomnumbergenerator.h
 *
 *  Created on: Nov 29, 2017
 *      Author: schaefer
 */

#ifndef DRIVERS_RANDOMNUMBERGENERATOR_H_
#define DRIVERS_RANDOMNUMBERGENERATOR_H_

#include "stm32f7xx_hal.h"

class random_number_generator_t
{
public:
	random_number_generator_t();
	uint32_t get( void)
	{
		uint32_t n;
		HAL_RNG_GenerateRandomNumber( &hrng, &n);
		return n;
	}
private:
	RNG_HandleTypeDef hrng;
};

extern random_number_generator_t random_number_generator;

#endif /* DRIVERS_RANDOMNUMBERGENERATOR_H_ */
