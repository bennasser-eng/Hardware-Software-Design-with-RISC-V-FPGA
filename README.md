
## Project: Hardware/Software Co-Design with RISC-V & FPGA

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

  Tests
	•	autotest.res contains results from automated test execution
	•	gen_tests_mutants.sh allows generating mutant test variations

⸻

 Learning Outcomes

This project provides hands-on experience with:
	•	Processor design and low-level software/hardware interaction
	•	Automating builds and tests for FPGA targets
	•	Using Vivado .tcl scripts for hardware synthesis and deployment


# CEP

## Instruction Status

### Métadonnées

[![timestamp status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//timestamp.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//timestamp.svg)

Fichier de [log](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//log.txt)
### Arithmetiques

[![ADDI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ADDI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ADDI.svg)
[![ADD status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ADD.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ADD.svg)
[![SUB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SUB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SUB.svg)
### Basiques

[![REBOUCLAGE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//REBOUCLAGE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//REBOUCLAGE.svg)
[![LUI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LUI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LUI.svg)
### Divers

[![AUIPC status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//AUIPC.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//AUIPC.svg)
### Logiques

[![OR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//OR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//OR.svg)
[![ORI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ORI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ORI.svg)
[![AND status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//AND.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//AND.svg)
[![ANDI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ANDI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//ANDI.svg)
[![XOR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//XOR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//XOR.svg)
[![XORI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//XORI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//XORI.svg)
### Décalages

[![SLL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLL.svg)
[![SLLI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLLI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLLI.svg)
[![SRA status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRA.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRA.svg)
[![SRAI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRAI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRAI.svg)
[![SRL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRL.svg)
[![SRLI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRLI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SRLI.svg)
### Sets

[![SLT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLT.svg)
[![SLTI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTI.svg)
[![SLTIU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTIU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTIU.svg)
[![SLTU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SLTU.svg)
### Branchements

[![BEQ status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BEQ.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BEQ.svg)
[![BGE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BGE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BGE.svg)
[![BGEU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BGEU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BGEU.svg)
[![BLT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BLT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BLT.svg)
[![BLTU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BLTU.svg)
[![BNE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BNE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//BNE.svg)
### Sauts

[![JAL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//JAL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//JAL.svg)
[![JALR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//JALR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//JALR.svg)
### Loads

[![LB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LB.svg)
[![LBU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LBU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LBU.svg)
[![LH status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LH.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LH.svg)
[![LHU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LHU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LHU.svg)
[![LW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//LW.svg)
### Stores

[![SB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SB.svg)
[![SH status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SH.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SH.svg)
[![SW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//SW.svg)
### Interruptions

[![CSRRC status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRC.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRC.svg)
[![CSRRCI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRCI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRCI.svg)
[![CSRRS status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRS.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRS.svg)
[![CSRRSI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRSI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRSI.svg)
[![CSRRW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRW.svg)
[![CSRRWI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRWI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//CSRRWI.svg)
[![IT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//IT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/bennassa_lrhorfim_eval//IT.svg)

## Travail evalué en présence des enseignants

[![compteur status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/compteur_bennassa_lrhorfim.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/compteur_bennassa_lrhorfim.svg)
[![chenillard_minimaliste status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_minimaliste_bennassa_lrhorfim.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_minimaliste_bennassa_lrhorfim.svg)
[![chenillard_rotation status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_rotation_bennassa_lrhorfim.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_rotation_bennassa_lrhorfim.svg)
[![invaders status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/invaders_bennassa_lrhorfim.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/invaders_bennassa_lrhorfim.svg)


# Auteurs:
Ahmed Bennasser & Akram Lrhorfi 
