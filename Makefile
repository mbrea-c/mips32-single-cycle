SOURCES = $(wildcard src/*.v)
TARGET = mips

build : $(SOURCES)
	iverilog -o mips $(SOURCES)

clean :
	rm $(TARGET)
