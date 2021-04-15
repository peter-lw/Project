/*
 * randomnumbergenerator.cpp
 *
 *  Created on: Nov 29, 2017
 *      Author: schaefer
 */

#include <randomnumbergenerator.h>

random_number_generator_t::random_number_generator_t()
{
	hrng.Instance=RNG;
	__RNG_CLK_ENABLE();
	HAL_RNG_Init( &hrng);
}

random_number_generator_t random_number_generator;
