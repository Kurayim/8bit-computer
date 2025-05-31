# 8bit-computer
This project is a practical implementation of an 8-bit computer, inspired by the final chapter of the book Quick Start Guide to VHDL. After studying the concepts, I developed this design as a hands-on exercise and decided to share it with others who are learning or working with VHDL.


    

![Screenshot 2025-05-31 005030](https://github.com/user-attachments/assets/be4064cc-9944-4cc8-a316-74548bacc422)



Educational Explanation for the Block Diagram (Top-Level: computer.vhd)

This block diagram represents the top-level architecture of an 8-bit computer system, composed of two main components: the CPU (cpu.vhd) and the Memory System (memory.vhd). The system is implemented in VHDL and is designed to simulate a fully functional yet simple processor for educational purposes.
The CPU module handles instruction execution. It provides address, control (write), and data signals (to_memory and from_memory) to communicate with the memory system.
The Memory module stores both the program and data. It receives the address and control signals from the CPU and responds with the requested data or stores new values as instructed.
The design supports 16 input ports (port_in_00 to port_in_15) and 16 output ports (port_out_00 to port_out_15), each 8 bits wide, allowing the system to interact with external devices or peripherals.
The clock and reset signals are shared between both modules to ensure synchronized operation.

This structure demonstrates the principle of modular design, enabling easy expansion, testing, and debugging.
This diagram is essential for understanding how data flows between the CPU and memory and how external I/O is handled in a basic digital computer system using VHDL.
As part of this project, we aim to implement all of these blocks entirely in VHDL and verify their operation through simulation, ensuring each module functions correctly before hardware synthesis.








![Screenshot 2025-05-31 005124](https://github.com/user-attachments/assets/7c672d19-f740-4d2d-95fb-259fa445a11a)









