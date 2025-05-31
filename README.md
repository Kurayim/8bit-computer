# 8bit-computer
This project is a practical implementation of an 8-bit computer, inspired by the final chapter of the book Quick Start Guide to VHDL. After studying the concepts, I developed this design as a hands-on exercise and decided to share it with others who are learning or working with VHDL.<br>



## Educational Explanation for the Block Diagram (Top-Level: computer.vhd)<br>

![Screenshot 2025-05-31 005030](https://github.com/user-attachments/assets/be4064cc-9944-4cc8-a316-74548bacc422)<br><br>

This block diagram represents the top-level architecture of an 8-bit computer system, composed of two main components: the CPU (cpu.vhd) and the Memory System (memory.vhd). The system is implemented in VHDL and is designed to simulate a fully functional yet simple processor for educational purposes.
The CPU module handles instruction execution. It provides address, control (write), and data signals (to_memory and from_memory) to communicate with the memory system.
The Memory module stores both the program and data. It receives the address and control signals from the CPU and responds with the requested data or stores new values as instructed.
The design supports 16 input ports (port_in_00 to port_in_15) and 16 output ports (port_out_00 to port_out_15), each 8 bits wide, allowing the system to interact with external devices or peripherals.
The clock and reset signals are shared between both modules to ensure synchronized operation.

This structure demonstrates the principle of modular design, enabling easy expansion, testing, and debugging.
This diagram is essential for understanding how data flows between the CPU and memory and how external I/O is handled in a basic digital computer system using VHDL.
As part of this project, we aim to implement all of these blocks entirely in VHDL and verify their operation through simulation, ensuring each module functions correctly before hardware synthesis.<br>






##  Memory Block Diagram <br>

 ![Screenshot 2025-05-31 005124](https://github.com/user-attachments/assets/7c672d19-f740-4d2d-95fb-259fa445a11a)<br><br>   

This block diagram shows the structure of the memory.vhd module used in our 8-bit computer project. It connects the CPU to program memory, data memory, and I/O ports.
Key VHDL Components:
rom_128x8_sync.vhd – holds program instructions.
rw_96x8_sync.vhd – read/write memory for data storage.
Input Ports – 16 input ports, selected via a multiplexer.
Output Ports – 16 output ports, updated through address decoding.
All of these components are implemented in VHDL and integrated in the memory.vhd system. The module routes data based on the address and supports clocked write operations for output and RAM.
We have designed and simulated all these blocks to ensure correct behavior before synthesis.<br>



## CPU Architecture Overview <br><br>

![Screenshot 2025-05-31 005124](https://github.com/user-attachments/assets/9e96f86b-616d-4c99-8f3d-8e8955aca7d4)<br><br>   

The image above illustrates the internal architecture of a simple 8-bit computer, divided into two main sections: the Control Unit and the Data Path. This modular design is implemented across multiple VHDL files (control_unit.vhd, data_path.vhd, alu.vhd, etc.) and coordinated by a top-level entity (cpu.vhd).
Control Unit (FSM): This section generates control signals such as IR_Load, PC_Load, ALU_Sel, and others to orchestrate data movement and operations within the data path. It is responsible for sequencing instructions and managing the finite state machine logic.
Data Path: Contains the core registers (IR, PC, MAR, A, B), buses (BUS1, BUS2), and the ALU. Multiplexers select the source and destination of data flow, and the CCR register stores condition flags (NZVC) for branching and status checks.

Communication with Memory: The architecture includes inputs and outputs such as from_memory, to_memory, and address to interface with external RAM or ROM modules.
This block diagram served as the reference for developing the VHDL code and testbenches in this project.<br>









