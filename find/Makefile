find : find.o
	ld find.o -o find

find.o : find.asm
	nasm -O0 -felf64 find.asm -o find.o

.PHONY : clean

clean:
	rm -f find.o find
