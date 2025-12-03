.PHONY: all clean install data report docker-build docker-run help

# Variables
DATA_DIR = data
REPORT_FILE = report.html
RMD_FILE = analysis.Rmd
DATASET = amazon_bestsellers_2025.csv
DATASET_URL = https://www.kaggle.com/datasets/sanskar21072005/amazon-best-sellers-2025

# Default target
all: report

# Help target
help:
	@echo "Available targets:"
	@echo "  make all          - Build the entire project (default)"
	@echo "  make data         - Download and prepare data"
	@echo "  make report       - Generate report.html"
	@echo "  make clean        - Remove generated files"
	@echo "  make docker-build - Build Docker image"
	@echo "  make docker-run   - Run Docker container"
	@echo "  make install      - Install required R packages"

# Install R packages
install:
	Rscript -e "install.packages(c('tidyverse', 'knitr', 'rmarkdown', 'ggplot2', 'scales', 'viridis', 'countrycode', 'ggrepel', 'gridExtra', 'broom'), repos='https://cloud.r-project.org/')"

# Create data directory
$(DATA_DIR):
	mkdir -p $(DATA_DIR)

# Data preparation target
data: $(DATA_DIR)
	@echo "============================================"
	@echo "Data Download Instructions:"
	@echo "============================================"
	@echo "Please download the dataset manually from:"
	@echo "$(DATASET_URL)"
	@echo ""
	@echo "After downloading, place the file in the data/ directory as:"
	@echo "  data/$(DATASET)"
	@echo ""
	@echo "The dataset should be named: $(DATASET)"
	@echo "============================================"
	@test -f $(DATA_DIR)/$(DATASET) && echo "✓ Dataset found!" || (echo "✗ Dataset not found. Please download manually." && exit 1)

# Report generation (depends on data)
$(REPORT_FILE): $(RMD_FILE) $(DATA_DIR)/$(DATASET)
	Rscript -e "pkgs <- c('tidyverse', 'knitr', 'rmarkdown', 'scales', 'viridis', 'countrycode', 'ggrepel', 'gridExtra', 'broom'); new_pkgs <- pkgs[!(pkgs %in% installed.packages()[,'Package'])]; if(length(new_pkgs)) install.packages(new_pkgs, repos='https://cloud.r-project.org/')"
	Rscript -e "if (packageVersion('xfun') > '0.19') { remove.packages('xfun'); install.packages('https://cran.r-project.org/src/contrib/Archive/xfun/xfun_0.19.tar.gz', repos=NULL, type='source') }"
	Rscript -e "rmarkdown::render('$(RMD_FILE)', output_file='$(REPORT_FILE)')"

report: $(REPORT_FILE)
	@echo "Report generated successfully: $(REPORT_FILE)"

# Clean target
clean:
	rm -f $(REPORT_FILE)
	rm -f *.html
	rm -f *.log *.aux *.out
	rm -rf report_cache/ report_files/ figure/
	rm -rf *_cache/ *_files/
	@echo "Cleaned generated files"

# Docker targets
docker-build:
	docker build . -t amazon-bestsellers-analysis

docker-run:
	docker run -it --rm \
		-p 8787:8787 \
		-v $$(pwd):/project \
		amazon-bestsellers-analysis

# Target to run everything in Docker
docker-report: docker-build
	docker run --rm \
		-v $$(pwd):/project \
		amazon-bestsellers-analysis \
		make report