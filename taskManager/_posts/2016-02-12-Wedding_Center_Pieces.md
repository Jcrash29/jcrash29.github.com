---
layout: post
title: "Wedding Center Pieces"
description: ""
category: task
tags: []
comments : false
---
{% include JB/setup %}


For Marissa's and my wedding I decided I wanted to make the center pieces for each of our table. The initial idea was to have 6 inch castle towers at each table which had LEDS lighting them up. 

The castle idea was quickly revoked and replaced by simple rectangles with gental flowing lights.

## Mechanical Design

The mechanical design was done in solidworks. It consisted of 4 walls which would be engraved with our names and wedding date. These would be done in a clear plastic to allow the lights to shine through. There would than be a top placed on each of the towers which slid around the the outside. This would be done in a white plastic as to hide the electronic circuits that would be stored at the top of the tower.

All of the parts were created using equations such that depending upon the plastics thickness and the size and shape desired the mechanical design would be easily updated.

## Electrical Design
The first thing I needed to find were RGB LEDS that would work with the mechanical design. After a little research I found a strip of RGB LEDS that was 5 m long and could be cut into individual 5 inch pieces. I quickly order some and connect power to a set. With 9V connected to power I could ground each of the RGB pins to get the LEDS to turn different colors.

In order to control each of the individual colors and fade them in and out I would need 3 PWM pins.

For a processor I decided to go with what I was must familiar: the PIC family of Microcontrollers. I went online and sampled several controlers which offered 3 individually accesible PWM pins. 

Which PIC was it?

Electrical design?


## Code Design

In order to properly setup the PIC I used the following configuration:

```C
// CONFIG1
#pragma config FOSC = INTOSC    // Oscillator Selection Bits (INTOSC oscillator: I/O function on CLKIN pin)
#pragma config WDTE = OFF       // Watchdog Timer Enable (WDT disabled)
#pragma config PWRTE = ON       // Power-up Timer Enable (PWRT enabled)
#pragma config MCLRE = OFF      // MCLR Pin Function Select (MCLR/VPP pin function is digital input)
#pragma config CP = OFF         // Flash Program Memory Code Protection (Program memory code protection is disabled)
#pragma config BOREN = ON       // Brown-out Reset Enable (Brown-out Reset enabled)
#pragma config CLKOUTEN = OFF   // Clock Out Enable (CLKOUT function is disabled. I/O or oscillator function on the CLKOUT pin)

// CONFIG2
#pragma config WRT = OFF        // Flash Memory Self-Write Protection (Write protection off)
#pragma config STVREN = OFF     // Stack Overflow/Underflow Reset Enable (Stack Overflow or Underflow will not cause a Reset)
#pragma config BORV = HI        // Brown-out Reset Voltage Selection (Brown-out Reset Voltage (Vbor), high trip point selected.)
#pragma config LPBOR = ON       // Low-Power Brown Out Reset (Low-Power BOR is enabled)
#pragma config LVP = ON         // Low-Voltage Programming Enable (Low-voltage programming enabled)
```


The following #defines were used for easy modfication. I set RED GREEN and BLUE such that they could be bitwise differentiated. 

```C
#define _XTAL_FREQ  16000000        // this is used by the __delay_ms(xx) and __delay_us(xx) functions

#define DELAY(ms)   do { int i; for (i = 0; i < (ms << 9); i++) { asm ("nop"); } } while(0);


#define RED 1
#define BLUE 2
#define GREEN 4

#define ON  0
#define OFF 1000

#define STAY_DELAY 10000
#define FADE_DELAY 6
```


Now we can initialize the PWM and I/O pins inside our main() function.

```C
    OSCCONbits.IRCF=0x0F;   //set OSCCON IRCF bits to select OSC frequency=16Mhz
    OSCCONbits.SCS=0x02;    //set the SCS bits to select internal oscillator block
    // OSCON should be 0x7Ah now.

    // Set up I/O pins
    ANSELAbits.ANSELA=0;    // set all analog pins to digital I/O
    ADCON0bits.ADON=0;      // turn ADC off
    DACCON0bits.DACEN=0;    // turn DAC off

      // PORT A Assignments
    TRISAbits.TRISA0 = 0;   // RA0 = nc
    TRISAbits.TRISA1 = 0;   // RA1 = nc
    TRISAbits.TRISA2 = 0;   // RA2 = PWM Output (CCP1) connected to LED
    TRISAbits.TRISA3 = 0;   // RA3 = nc (MCLR)
    TRISAbits.TRISA4 = 0;   // RA4 = nc
    TRISAbits.TRISA5 = 0;   // RA5 = nc
	

    TRISAbits.TRISA2 = 1;       // disable pwm pin output for the moment
    TRISAbits.TRISA4 = 1;
    TRISAbits.TRISA5 = 1;

    PR2 = 0xff;                 // set PWM period as 255 per our example above

    PIR1bits.TMR2IF=0;      // clear TMR2 interrupt flag
    T2CONbits.T2CKPS=0x00;      // select TMR2 prescalar as divide by 1 as per our example above
    T2CONbits.TMR2ON=1;     // turn TMR2 on
    TRISAbits.TRISA2 = 0;   // turn PWM output back on
    TRISAbits.TRISA4 = 0;
    TRISAbits.TRISA5 = 0;

    PWM1CON = 0b11000000;
    PWM3CON = 0b11000000;
    PWM4CON = 0b11000000;
```

Finally we can setup the main function to fade the colors:

```C
    while(1)
    {        
        //Start White
        Curr_chan = BLUE||GREEN||RED;
        Duty_cycle = ON;
        SetDutyCycle(Curr_chan, Duty_cycle);
        DELAY(STAY_DELAY)
    //Light blue: Blue + Green(yellow) ==>Turn off Red
        Duty_cycle = ON;
        while(Duty_cycle != OFF){
            Curr_chan = RED;
            Duty_cycle += 1;
            SetDutyCycle(Curr_chan, Duty_cycle);
            DELAY( light_delay );
        }
        DELAY(STAY_DELAY)
    //Purple: Blue + Red(white) ==> Turn Red on, Turn Green off
        Duty_cycle = ON;
        Duty_cycle2 = OFF;
        while(Duty_cycle != OFF){
            Duty_cycle  += 1; // green
            Duty_cycle2 -= 1; //red
            SetDutyCycle(GREEN, Duty_cycle);
            SetDutyCycle(RED, Duty_cycle2);
            DELAY( light_delay );
        }
        DELAY(STAY_DELAY)
    //Dark Blue: Blue ==> Red off
        Duty_cycle = ON;
        while(Duty_cycle != OFF){
            Curr_chan = RED;
            Duty_cycle += 1;
            SetDutyCycle(Curr_chan, Duty_cycle);
            DELAY( light_delay );
        }
        DELAY(STAY_DELAY)
    //White ==> Red on, Green on
        Duty_cycle = OFF;
        while(Duty_cycle != ON){
            Duty_cycle -= 1;
            SetDutyCycle(RED, Duty_cycle);
            SetDutyCycle(GREEN, Duty_cycle);
            DELAY( light_delay );
        }

    }
```



