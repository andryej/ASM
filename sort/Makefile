CXX ?= g++
ASM ?= nasm
CXXFLAGS = -Wno-unused-result -g -O2 -std=c++0x -c
ASMFLAGS = -g -O0 -felf64 
SOURCES = main.cpp sort.asm
OBJECTSS = $(SOURCES:.cpp=.o)
OBJECTS  = $(OBJECTSS:.asm=.o)
EXECUTABLES =  main

all : main

main : main.o sort.o
	$(CXX) $? -o $@ 

sort.o : sort.asm 
	$(ASM) $(ASMFLAGS) $< -o $@

sort.asm : 

%.o : %.cpp
	$(CXX) $< $(CXXFLAGS) -o $@
 
.PHONY : clean all

clean : 
	rm -f $(OBJECTS) $(EXECUTABLES)
	
