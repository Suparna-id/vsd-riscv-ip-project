# Task-2: Simple GPIO Output IP

## Objective
Design a simple memory-mapped GPIO IP and integrate it into a RISC-V SoC.
The IP allows software to write and read a 32-bit GPIO register.

---

## IP Specification

- **IP Name:** Simple GPIO Output IP
- **Register Width:** 32-bit
- **Access Type:** Read / Write
- **Offset Map:**
  - 0x00 → GPIO_DATA

---

## Functionality

- Writing to GPIO_DATA updates the GPIO output register
- Reading GPIO_DATA returns the last written value
- Reset clears the register to zero

---

## RTL Implementation

RTL file location:
**Task-2/rtl/gpio_ip.v**
