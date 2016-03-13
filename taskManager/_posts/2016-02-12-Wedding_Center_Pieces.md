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

The parts were than cut out using a laser cutter, and engraved with the following images.

## Electrical Design
The first thing I needed to find were RGB LEDS that would work with the mechanical design. After a little research I found a strip of RGB LEDS that was 5 m long and could be cut into individual 5 inch pieces. I quickly order some and connect power to a set. With 9V connected to power I could ground each of the RGB pins to get the LEDS to turn different colors.

In order to control each of the individual colors and fade them in and out I would need 3 PWM pins.

For a processor I decided to go with what I was must familiar: the PIC family of Microcontrollers. I went online and sampled several controlers which offered 3 individually accesible PWM pins. 

Which PIC was it?

Electrical design?


## Code Design

The coding for this project was simple: control 3 PWM outputs. Each controlling a seperate color: RED, BLUE, GREEN. The PWM outputs needed be setup at a fixed frequency and than the duty cycle of the signal can be modified from 0%(LED ON) to 100% (LED OFF).

However in order to make the light changes smooth the PWM signal needs to be changed in a smooth motion. For example as the RED LED is transisitoning from off to on a while loop must be setup that slowly increases the duty cycle to full. On each pass through the while loop the duty cycle increases and than a variable delay is used to change how quickly the LED transitions from one state to another.

The full code for this project can be seen [here](https://github.com/BananaSlug/WeddingCenterPieces).