## CryptoSystem-on-FPGA

### Overview

This project outlines the RTL implementation of the Advanced Encryption Standard (AES) using VHDL, with focus on area efficiency. By utilizing a logic reuse technique, the design incorporates a single instance of each essential module SBox, MixColumn, AddKey, and ShiftRows—thereby significantly reducing resource usage . A finite state machine (FSM) manages the control of these modules, orchestrating operations based on a round counter variable and facilitating smooth transitions throughout each encryption round. The diagram below illustrates how the FSM coordinates the execution of each module: 

![SVG Image](./Docs/FSM.svg)
