Smart Packaging System
Overview
This project implements a Smart Packaging System for a factory that produces magnetic products. Using VHDL, an FPGA, and real hardware components including a breadboard and a conveyor belt, the system automates the product counting and packaging process to increase efficiency and reduce human error.

Features
Automatic Product Counting:
The system detects and counts magnetic products as they pass on the conveyor belt using sensors.

7-Segment Display:
The current count of products (up to 5) is shown in real-time using a 7-segment display.

Conveyor Belt Control:
The belt automatically stops when exactly 5 products are detected.

Worker Presence Detection:
The system checks for nearby workers using a proximity sensor.

Alert System:
If no worker is nearby when the belt stops, an alert (e.g., LED or buzzer) notifies them to close and seal the package.

Reset & Restart Mechanism:
A physical switch is used by the worker to:

Acknowledge packaging completion

Restart the conveyor

Reset the product counter

Hardware Components
FPGA Development Board (e.g., Xilinx/Altera)

Breadboard

Magnetic Product Sensor (e.g., Hall effect sensor)

7-Segment Display Module

Proximity Sensor (e.g., IR or Ultrasonic)

Conveyor Belt System (motor-controlled)

Control Switch

LEDs or Buzzer for Alerts

Power Supply

Software/Logic Design
VHDL is used to design:

A counter module for tracking magnetic products

Display drivers for the 7-segment module

Motor control logic for starting/stopping the belt

Sensor interface modules for magnetic detection and proximity detection

Reset logic for the switch control

Functional Flow
Conveyor belt is running and products pass over a magnetic sensor.

Each magnetic product increments the count.

The count is displayed on a 7-segment display.

When 5 products are counted:

The belt stops.

Worker proximity is checked.

If no worker is detected:

An alert is triggered.

When the worker finishes packaging:

They press the switch.

The count resets.

The belt restarts.

Applications
Industrial packaging lines

Smart manufacturing

Educational embedded systems projects

Real-time control and monitoring systems

