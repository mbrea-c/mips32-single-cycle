SOURCES = $(wildcard src/*.v)
TARGET = mips

build : $(SOURCES)
	iverilog -o $(TARGET) $(SOURCES)

clean :
	rm $(TARGET)
