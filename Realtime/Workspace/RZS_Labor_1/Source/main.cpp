/**
 ******************************************************************************
 * @file           : main.cpp
 * @brief          : Main program and system start
 * @mainpage
 * Project for the STM32F7508-dk Evaluation-Board
 *
 * @see main.cpp
 *
 ******************************************************************************
 */
#include "cortex_driver.h"
#include "stm32f7508_discovery.h"
#include "stm32f7508_discovery_lcd.h"
#include "touchscreen.h"
#include "string.h"
#include "button.h"
#include "sys_tick.h"
#include "usart1driver.h"
#include "stdlib.h"

void LCD_init(void);
void Button_Init(void);
void cortex_m7_init(void);
void handle_touch_screen( void);
void prepare_LCD( void);

/**
 * @brief  The application entry point.
 *
 * initialization, implements the super loop
 */
struct Zeit{
	int min = 0;
	int sec = 0;
	int mil = 0;
	int flag = 0;
	int akt = 0;
}zeit;

extern "C" int main(void)
{
	cortex_m7_init(); 			// diverse settings for the micro-controller
	BSP_LED_Init (LED1); 			// GPIO setup
	Button_Init(); 			// GPIO + ISR setup
	touch_screen_init(); 			// touchscreen I/O HW setup
	usart1_driver usart1(115200); 	// create USART driver object

	prepare_LCD();

	usart1.puts("Hello from USART\r\n"); 	// goes to CDC ACM device -> USB COM port

	unsigned loops=0;
	unsigned randZeit=0;
	unsigned reaktionZeit=0;
	unsigned i=0;
	unsigned temp=0;

	while( true) // *THE* SUPERLOOP
	{
		char buf[40]; // beware: limited length !
		randZeit=rand()%10000+5000;
		uint32_t time=0;

		//		//Totmannschalter
		//		if(button_flag==true){
		//			timer_ticks_1000Hz=0;
		//			button_flag=false;
		//			while(timer_ticks_1000Hz<1000+1){
		//				BSP_LED_On(LED1);
		//				if(button_flag==true){
		//					break;
		//				}
		//			}
		//			BSP_LED_Off(LED1);
		//		}

		//Reaktionstester
		//		if(button_flag==true){
		//			reaktionZeit=new_timer_ticks_1000Hz;
		//			timer_ticks_1000Hz=0;
		//			strcpy(buf, "Reaktion =");
		//			itoa( reaktionZeit, buf + strlen(buf),10);
		//			BSP_LCD_DisplayStringAtLine (6, buf);
		//			button_flag=false;
		//			while(timer_ticks_1000Hz<randZeit+1){
		//				BSP_LED_On(LED1);
		//			}
		//			BSP_LED_Off(LED1);
		//			new_timer_ticks_1000Hz=0;
		//		}


		//		if( (button_interrupt_count & 1) !=0 ) // this variable is being changed by the button ISR
		//			BSP_LED_On(LED1);
		//		else
		//			BSP_LED_Off(LED1);

		//		strcpy(buf, "Count   =");
		//		itoa( button_interrupt_count, buf + strlen(buf),10);
		//		BSP_LCD_DisplayStringAtLine (4, buf);

		// 1.2 Echtzeit-Uhr
		touch_coordinates t;
		//if( ){
		if((touch_screen_check(t))&&(t.x<=475&&t.x>=350)&&(t.y<=130&&t.y>=100)){
			timer_ticks_1000Hz=0;
			while(true){
				zeit.akt = timer_ticks_1000Hz;
				zeit.mil = timer_ticks_1000Hz%1000;
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
				strcpy(buf+strlen(buf), ".");
				itoa( zeit.sec, buf + strlen(buf),10);
				strcpy(buf+strlen(buf), ".");
				itoa( zeit.mil, buf + strlen(buf),10);
				BSP_LCD_DisplayStringAtLine ( 8, buf);
				if((touch_screen_check(t))&&(t.x<=475&&t.x>=350)&&(t.y<=230&&t.y>=220)){
					zeit.mil=0;
					zeit.sec=0;
					zeit.min=0;
					i=0;
					temp=0;
					break;
				}
			}

		}
		//}


		//handle_touch_screen();


		++loops;
	}
}

/**
 * @brief  Touch screen handler
 *
 * Test for "touched"
 * and report coordinates if touch detected
 */
void handle_touch_screen( void)
{
	touch_coordinates t;
	if( touch_screen_check(t)) // if new touch detected
	{
		char buf[40]; // beware: limited length !
		strcpy(buf, "Touch x =");
		itoa( t.x, buf + strlen(buf),10);
		strcpy(buf + strlen(buf), "       "); // wipe old info
		BSP_LCD_DisplayStringAtLine (6, buf);
		strcpy(buf, "Touch y =");
		itoa( t.y, buf+strlen(buf),10);
		strcpy(buf + strlen(buf), "       ");
		BSP_LCD_DisplayStringAtLine (7, buf);
	}
}

/**
 * @brief  LCD initialization
 *
 * initialization and content setup
 */
void prepare_LCD( void)
{
	LCD_init(); 				// LCD initialization + start-screen
	// write sample rectangle
	BSP_LCD_SetTextColor(LCD_COLOR_DARKGREEN);
	BSP_LCD_FillRect( 400, 150, 40, 40);
	BSP_LCD_SetTextColor(LCD_COLOR_BLUE);

	// write sample key text box
	BSP_LCD_SetBackColor(LCD_COLOR_RED);
	BSP_LCD_SetTextColor(LCD_COLOR_BLACK);
	BSP_LCD_DisplayStringAt( 350, 100, " START ", LEFT_MODE);

	// write sample key text box
	BSP_LCD_SetBackColor(LCD_COLOR_RED);
	BSP_LCD_SetTextColor(LCD_COLOR_BLACK);
	BSP_LCD_DisplayStringAt( 350, 220, " STOP ", LEFT_MODE);

	// set LCD defaults
	BSP_LCD_SetBackColor(LCD_COLOR_YELLOW);
	BSP_LCD_SetTextColor(LCD_COLOR_BLUE);
}
