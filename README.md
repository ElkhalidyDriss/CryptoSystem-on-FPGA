## CryptoSystem-on-FPGA

### Overview

This project outlines the RTL implementation of the Advanced Encryption Standard (AES) using VHDL, with focus on area efficiency. By utilizing a logic reuse technique, the design incorporates a single instance of each essential module SBox, MixColumn, AddKey, and ShiftRows—thereby significantly reducing resource usage . A finite state machine (FSM) manages the control of these modules, orchestrating operations based on a round counter variable and facilitating smooth transitions throughout each encryption round. The diagram below illustrates how the FSM coordinates the execution of each module: 

![SVG Image](./Docs/FSM.svg)
### Project Structure 
```plaintext
├── Docs
│   └── FSM.svg
│   └── gtkwave.png
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
### Generating and Visualizing Waveforms

#### Overview

This guide explains how to generate waveform files and visualize them using the `generate_waveform.py` script. This script compiles your VHDL design files along with a specified test bench file using GHDL, and generates a waveform file in VCD format, which can be visualized in GTKWave.

#### Prerequisites

Before running the script, ensure that you have the following installed and accessible in your system PATH:

- **GHDL**: A VHDL simulator used for compiling the design files and running the simulations.
- **GTKWave**: A VCD waveform viewer used for visualizing the generated waveform files.
  
#### Usage

To generate the waveforms and visualize them, follow these steps:

1. **Open a terminal.**
2. **Navigate to the project directory**
3. **Run the script** with the name of test bench file as a parameter. For example:
   ```bash
   python generate_waveforms.py top_tb.vhd```
**vcd file will be saved to waveforms/ and GTKwave will be opened**
![gtkwave](./Docs/gtkwave.png)
### Future Enhancements

There is always room for improvement in this project. Here are some planned enhancements for the near and distant future:

- **Random Key Generation**: Implementing a random key generation mechanism to replace the current hardcoded fixed key value. *(Near Future)*

- **On-the-Fly S-Box Calculation**: Transitioning from a pre-saved ROM table to on-the-fly calculations using Galois fields for the S-Box implementation. *(Later)*

- **Padding Support**: Adding functionality to support padding for plaintext inputs that are not equal to 128 bits. *(Near Future)*

- **Control and Buffer Registers**: Introducing control registers and buffer registers to store the input plaintext and the generated ciphertext and key   . *(Near Future)*

- **SoC Integration**: Integrating the design into a System on Chip (SoC) for useful usage. *(Later)*

 
 

