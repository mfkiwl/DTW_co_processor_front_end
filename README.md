# Important Notice!!!
dtw.py used to test the functionality of the RTL design is from https://github.com/pollen-robotics/dtw

# DTW_co_processor_front_end
Open Source Chip!!!

DTW_co_processor_front_end

# Authors

Zhongchun Zhou (zhouzc2000@foxmail.com)

Run Run (rr18@mails.tsinghua.edu.cn)

# Environment Requirements
* GNU/Linux Version >= 4.4.0
* Oracle Java
* Python3 (packages: matplot, scipy, numpy)
* Icarus iverilog (With System Verilog support)
* Synopsys Design Compiler
* Synopsys IC Compiler

# Test
* Testbench: Initial testbench of the chip
* SuperTestbench: Support SRAM printing
* EnhancedSuperTestbench: Support random test in SystemVerilog

# Run the code
```
rm *.out #clean the files
rm *.class #clean the files
python3 vector_generate.py #Generate test file
touch vector_output.out #create result file
iverilog -g2005-sv -o test.out EnhancedSuperTestbench.sv
vvp test.out
javac check.java
java check
rm *.class #clean the files
```
(It is the content of run.sh)

# Vector generator
File names: vector_memory.out  vector_input.out  vector_result.out
10 random templates
