# Multimixer
Code for Multimixer-128

To run the code complete the following,


Compile C files with: 
gcc -g *.c -c

Compile Assembly code with: 

for NH assembly code:
gcc -mfpu=neon -c Nh.s -o Nh.o

for Multimixer128 assembly code:
gcc -mfpu=neon -c Multimixer128.s -o Multimixer128.o

Link them together with: 
gcc -g -o output *.o

Run it by:
./output

