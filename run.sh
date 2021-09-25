rm *.out #clean the files
rm *.class #clean the files
python3 vector_generate.py #Generate test file
touch vector_output.out #create result file
iverilog -g2005-sv -o test.out EnhancedSuperTestbench.sv
vvp test.out
javac check.java
java check
rm *.class #clean the files