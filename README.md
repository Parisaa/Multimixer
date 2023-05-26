# Multimixer
Code for Multimixers

To run the code complete the following,


Compile C files with: 
gcc -g *.c -c

Compile Assembly code with: 
gcc -mfpu=neon -c Nh.s -o Nh.o
gcc -mfpu=neon -c Multimixer128.s -o Multimixer128.o
gcc -mfpu=neon -c Multimixer156.s -o Multimixer156.o

Link them together with: 
gcc -g -o output *.o

Run it by:
./output

