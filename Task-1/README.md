
# vsd_Task1_riscv
**Task-1: RISC-V environment setup and reference bring-up**

## Environment Used
- GitHub Codespace: Yes
- Local Machine Setup:  Not yet

---

## Step-1: Codespace Setup

I forked the official repository:
https://github.com/vsdip/vsd-riscv2

I launched a GitHub Codespace from my fork and verified that:
- Codespace opened successfully
- Required tools like riscv64-unknown-elf-gcc and spike were available

---

## Step-2: RISC-V Reference Program Execution

### Program Location
The RISC-V sample programs are located in:
vsd-riscv2/samples/sum1ton.c

### Compilation Command
```bash
riscv64-unknown-elf-gcc -c sum1ton.c -o sum1ton.o
```
**## Step-3: Understanding the Execution Flow**

**Q1. Where is the RISC-V program located?**

The RISC-V program is located inside the samples directory of the **vsd-riscv2** repository.

**Q2. How is the program compiled and loaded?**

The program is compiled using **riscv64-unknown-elf-gcc**, which converts C code into RISC-V object code.
This repository focuses on instruction-level compilation and does not include full bare-metal execution.

**Q3. How does the RISC-V core access memory and MMIO?**

The RISC-V core accesses memory and peripherals using memory-mapped addresses.
Specific address ranges are decoded to connect the CPU to memory or peripherals such as GPIO or UART.

**Q4. Where would a new FPGA IP integrate?**

A new FPGA IP would be integrated as a memory-mapped peripheral in the SoC.
It would connect to the CPU bus and be accessed through a fixed base address.
