CC = hcc
SRC = main.hc
BIN = bin

TARGET = $(BIN)/main

all: $(TARGET)

$(TARGET): $(SRC)
	@echo "Creating $(BIN) directory..."
	@mkdir -p $(BIN)
	@echo "Compiling $(SRC)..."
	$(CC) $(SRC) -o $(TARGET)
	@echo "Build successful! Run with: ./$(TARGET)"

clean:
	@echo "Cleaning up..."
	rm -rf $(BIN)

.PHONY: all clean