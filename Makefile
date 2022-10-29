BASE=./
SANITIZE= 

CC=iverilog
CXX=g++ 


CFLAGS= -std=gnu99   -Werror -Wall -Wextra -Wunused-function -Wreturn-type    -O0 -g 

IFLAGS= -E 

#LIBS = -L/opt/buildroot/buildroot_src/output/host/aarch64-buildroot-linux-gnu/sysroot/usr/lib/

all:
	$(CC) simu/alu_tb.sv src/alu.v  src/define.v  -I./src -Wall -o	alu_tb
	$(CC) simu/register_tb.sv src/registers.v  -I./src -Wall -o	register_tb

testcomp:
	$(CC) src/control_unit.v src/define.v src/opcodes.v -I./src -Wall -o	controlunit


clean:
	rm -rf *.o
