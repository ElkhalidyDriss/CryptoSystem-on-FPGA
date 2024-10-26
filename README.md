## CryptoSystem-on-FPGA

### Overview

This project outlines the RTL implementation of the Advanced Encryption Standard (AES) using VHDL, with focus on area efficiency. By utilizing a logic reuse technique, the design incorporates a single instance of each essential module SBox, MixColumn, AddKey, and ShiftRows—thereby significantly reducing resource usage . A finite state machine (FSM) manages the control of these modules, orchestrating operations based on a round counter variable and facilitating smooth transitions throughout each encryption round. The diagram below illustrates how the FSM coordinates the execution of each module: 

![SVG Image](./Docs/FSM.svg)
### Project Structure 
```plaintext
├── Docs
│   └── FSM.svg
├── generate_waveforms.py
├── LICENSE
├── README.md
├── src
│   ├── addKey.vhd
│   ├── keyExpansion.vhd
│   ├── mixColumn.vhd
│   ├── polyMultBy2.vhd
│   ├── polyMultBy3.vhd
│   ├── shiftRows.vhd
│   ├── subByte.vhd
│   └── top.vhd
├── testbench
│   ├── mixColumnTB.vhd
│   ├── polyMultBy3tb.vhd
│   ├── shiftRows_TB.vhd
│   └── top_tb.vhd
├── waveforms
│   ├── mixColumnTB.vcd
│   └── top_tb.vcd
└── work-obj93.cf
```

