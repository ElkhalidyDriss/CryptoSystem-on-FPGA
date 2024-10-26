"""
generate_waveform.py

Author: Idriss Elkhalidy
Description:
This script compiles VHDL design files and a specified test bench file using GHDL,
generates a waveform file in VCD format, and opens it in GTKWave for visualization.

Usage:
    python generate_waveform.py [test_bench_file] 

Parameters:
    [test_bench_file] - The name of the test bench VHDL file (must be located in the 'testbench' directory).

Requirements:
    - GHDL: A VHDL simulator.
    - GTKWave: A VCD waveform viewer.
    - VHDL design files should be located in the 'src' directory.
    - The specified test bench file must exist in the 'testbench' directory.

Note:
    Ensure GHDL and GTKWave are installed and accessible in the system PATH.

"""
import os
import subprocess
import sys
import glob
import shutil
import time 
import signal 
def main():
    if len(sys.argv) != 2:
        print("Usage: python3 generate_waveform.py [test_bench_file]")
        sys.exit(1)

    test_bench = sys.argv[1]
    test_bench_path = os.path.join("testbench", test_bench)

    if not os.path.isfile(test_bench_path):  # Checking if the file exists
        print(f"Error: Test bench file '{test_bench}' does not exist in the 'testbench' directory.")
        sys.exit(1)

    base_name = os.path.splitext(os.path.basename(test_bench))[0]

    vhdl_files = glob.glob("src/*.vhd")
    if not vhdl_files:
        print("Error: No VHDL files found in the 'src' directory.")
        sys.exit(1)

    for command in ["ghdl", "gtkwave"]:
        if not shutil.which(command):
            print(f"Error: '{command}' is not installed. Please install it and try again.")
            sys.exit(1)

    print("Compiling design files...")
    for vhdl_file in vhdl_files:
        subprocess.run(["ghdl", "-a", "-fsynopsys", vhdl_file], check=True)

    print("Compiling test bench file...")
    subprocess.run(["ghdl", "-a", "-fsynopsys", test_bench_path], check=True)
    print(f"Elaborating {base_name}...")
    subprocess.run(["ghdl", "-e", "-fsynopsys", base_name], check=True)
    waveforms_dir = "./waveforms"
    os.makedirs(waveforms_dir, exist_ok=True)

    vcd_file = os.path.join(waveforms_dir, f"{base_name}.vcd")
    ghdl_process = subprocess.Popen(
        ["ghdl", "-r", "-fsynopsys", base_name, "--vcd=" + vcd_file],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    time.sleep(2)
    ##! In my host machine the process stucks so I should terminate it after sometime enough time for generating vcd_file
    if ghdl_process.poll() is None:  
        ghdl_process.terminate() 
        ghdl_process.wait()
    print(f"Waveform generated at {vcd_file}.")
    print("opening gtkwave ...")
    subprocess.run(["gtkwave", vcd_file], check=True)

if __name__ == "__main__":
    main()
