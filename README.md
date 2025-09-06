
⚙️ Project: Hardware/Software Co-Design with RISC-V & FPGA

This project explores processor design, simulation, and testing using a RISC-V–like architecture. It combines hardware description, software tooling, and automation scripts to run experiments on FPGA platforms.

The work includes:
	•	Building and simulating a simple processor architecture
	•	Running automated test suites and generating results
	•	Using Vivado scripts (.tcl) for FPGA synthesis and programming
	•	Automating compilation, simulation, and deployment via Makefiles and shell scripts


Requirements
	•	GNU Make
	•	RISC-V GCC toolchain
	•	Xilinx Vivado (for FPGA synthesis & programming)

Build & Run

To compile:

make

To run automated tests:

make autotest

To program FPGA (via Vivado):

make program


⸻

🧪 Tests
	•	autotest.res contains results from automated test execution
	•	gen_tests_mutants.sh allows generating mutant test variations

⸻

📖 Learning Outcomes

This project provides hands-on experience with:
	•	Processor design and low-level software/hardware interaction
	•	Automating builds and tests for FPGA targets
	•	Using Vivado .tcl scripts for hardware synthesis and deployment

