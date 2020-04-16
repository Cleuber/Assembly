# Tic-Tac-Toe in Assembly (machine vs player) Intel x86 32 bits

This project was a work of computer architecture at the college of the 3th period.

Finally... to run the project you need nasm and gcc installed.

### Installing dependencies

$ sudo dnf install nasm

$ sudo dnf  install glibc-devel.i686


### Running binary

$ nasm -f elf tic-tac.asm

$ gcc -m32 -o tic-tac tic-tac.o

$ ./tic-tac

<i>Alternative to debian</i>

$ sudo apt install gcc-4.8-multilib

### Note

User needs to mark position with number (0 - 8)<br>
| 0 | 1 | 2| <br>
| 3 | 4 | 5| <br>
| 6 | 7 | 8| <br>


<b>X</b> -> represents player's move <br>
<b>O</b> -> represents machine move
