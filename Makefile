.PHONY: all clean report

all: clean report

report:
	quarto render

clean:
	rm -rf docs/