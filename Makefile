.PHONY: all clean report

all: clean docs/index.html

# Step 1: Data Cleaning
data/clean/titanic_clean.csv: code/01-load_clean.R data/original/titanic.csv
	Rscript code/01-load_clean.R --file_path=data/original/titanic.csv --output_path=data/clean/titanic_clean.csv

# Step 2: Modeling
output/model.RDS: code/03-model.R data/clean/titanic_clean.csv
	Rscript code/03-model.R --file_path=data/clean/titanic_clean.csv --output_path=output/model.RDS

# Step 3: Analysis and Visualization
output/coef.csv output/fig.png: code/04-analyze.R output/model.RDS
	Rscript code/04-analyze.R --model=output/model.RDS --output_coef=output/coef.csv --output_fig=output/fig.png

# Step 4: Quarto render
docs/index.html: index.qmd output/coef.csv output/fig.png
	quarto render

report:
	quarto render

clean:
	rm -rf docs/
