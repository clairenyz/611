# Amazon Best Sellers 2025 Analysis

## Project Description

This project analyzes the Amazon Best Sellers 2025 Global Software Market Intelligence dataset, which contains comprehensive information about Amazon's top 1,000 bestselling software and digital products across 10 major global markets for 2025. The analysis explores pricing patterns, rating distributions, market variations, and cross-country comparisons to identify insights about the global software marketplace.

The project includes:
- Exploratory data analysis of 10,000 product records across 10 countries
- Statistical analysis of pricing, ratings, and market rankings
- Comparative visualizations across markets
- Application of clustering and regression methods
- Reproducible workflow using Docker, Make, and R Markdown

## Dataset Information

**Source**: [Amazon Best Sellers 2025 - Kaggle](https://www.kaggle.com/datasets/sanskar21072005/amazon-best-sellers-2025)

**Description**: 10,000 records (1,000 products × 10 countries) of bestselling software products

**Markets Covered**: India, US, Canada, Australia, Germany, France, Italy, Spain, Japan, and Mexico

**Key Variables**:
- `rank`: Bestseller ranking position (1-1000)
- `product_title`: Product name and description
- `product_price`: Pricing in local currency
- `product_star_rating`: Customer rating (1-5 stars)
- `product_num_ratings`: Number of customer reviews
- `country`: Market identifier
- `asin`: Amazon product identifier

## Prerequisites

- Docker installed on your system
- Git installed
- At least 4GB of available disk space
- Internet connection for downloading data and packages

## Getting the Data

1. Visit the Kaggle dataset page: https://www.kaggle.com/datasets/sanskar21072005/amazon-best-sellers-2025

2. Download the dataset (requires Kaggle account)

3. Extract the CSV file and place it in the `data/` directory of this project:
   ```bash
   mkdir -p data
   # Copy your downloaded file to:
   # data/amazon_bestsellers_2025.csv
   ```

4. Verify the data file exists:
   ```bash
   ls data/amazon_bestsellers_2025.csv
   ```

## Quick Start

### Option 1: Using Docker (Recommended)

1. Clone this repository:
   ```bash
   git clone <your-repo-url>
   cd amazon-bestsellers-analysis
   ```

2. Ensure the dataset is in the `data/` directory (see "Getting the Data" above)

3. Build the Docker image:
   ```bash
   docker build . -t amazon-bestsellers-analysis
   ```

4. Run the container with RStudio:
   ```bash
   docker run -it --rm -p 8787:8787 -v $(pwd):/project amazon-bestsellers-analysis
   ```

5. Open RStudio in your browser:
   - Navigate to: http://localhost:8787
   - Login credentials: (default RStudio credentials)

6. In the RStudio terminal, generate the report:
   ```bash
   cd /project
   make report
   ```

### Option 2: Using Make Directly

If you have R and all dependencies installed locally:

```bash
make data      # Verify data is present
make install   # Install R packages (if needed)
make report    # Generate the PDF report
```

### Option 3: Docker One-Command Report Generation

Build and generate report in one command:
```bash
make docker-report
```

## Project Structure

```
amazon-bestsellers-analysis/
├── Dockerfile              # Docker container configuration
├── Makefile               # Build automation
├── README.md              # This file
├── .gitignore            # Git ignore patterns
├── analysis.Rmd          # R Markdown analysis file
├── report.pdf            # Generated report (after building)
└── data/                 # Data directory
    └── amazon_bestsellers_2025.csv
```

## Building the Report

The entire project is organized as a Makefile with the following targets:

- `make all` or `make report` - Generate the PDF report (default target)
- `make data` - Verify data availability and show download instructions
- `make install` - Install required R packages
- `make clean` - Remove generated files and clean up
- `make docker-build` - Build the Docker image
- `make docker-run` - Run the Docker container interactively
- `make help` - Display available targets

### Dependencies

The Makefile properly tracks dependencies:
- `report.pdf` depends on `analysis.Rmd` and `data/amazon_bestsellers_2025.csv`
- Data target verifies the dataset exists before proceeding
- Clean target removes all generated artifacts

### Example Workflow

```bash
# Check if data exists
make data

# Build report (automatically checks dependencies)
make report

# Clean up generated files
make clean

# Rebuild from scratch
make clean && make report
```

## For Developers

### Development Environment

The project uses the `amoselb/rstudio-m1` base image with the following additions:

**System Dependencies**:
- pandoc (document conversion)
- texlive (LaTeX for PDF generation)
- Standard development libraries for R packages

**R Packages**:
- `tidyverse`: Data manipulation and visualization
- `knitr`, `rmarkdown`: Report generation
- `ggplot2`: Advanced plotting
- `scales`: Plot scaling and formatting
- `viridis`: Color palettes
- `patchwork`: Multi-panel plots
- `gt`: Table formatting
- `countrycode`: Country code conversions
- `ggrepel`: Label positioning

### Adding New Dependencies

1. Edit `Dockerfile` to add system packages or R packages:
   ```dockerfile
   RUN apt-get install -y <new-package>
   RUN R -e "install.packages('new-r-package')"
   ```

2. Rebuild the Docker image:
   ```bash
   make docker-build
   ```

### Modifying the Analysis

1. Edit `analysis.Rmd` to add new sections or modify existing analysis

2. Test changes interactively in RStudio:
   ```bash
   make docker-run
   # Open http://localhost:8787
   # Edit and knit the document
   ```

3. Generate the final report:
   ```bash
   make report
   ```

### Git Workflow

The `.gitignore` is configured to exclude:
- Generated reports (PDF, HTML)
- R session files (.Rhistory, .RData)
- Cache directories
- OS-specific files
- IDE configurations

Commit only source files:
```bash
git add Dockerfile Makefile README.md analysis.Rmd .gitignore
git commit -m "Add analysis source files"
```

### Testing Your Setup

To verify everything works correctly:

```bash
# Start fresh in a temporary directory
cd /tmp
git clone <your-repo-url> test-build
cd test-build

# Add the dataset
mkdir -p data
cp /path/to/amazon_bestsellers_2025.csv data/

# Build and run
docker build . -t test-amazon-analysis
docker run --rm -v $(pwd):/project test-amazon-analysis make report

# Check output
ls -lh report.pdf
```

## Analysis Overview

The report includes:

1. **Data Description**: Comprehensive exploration of the dataset structure, variables, and coverage

2. **Exploratory Visualizations** (4-6 figures):
   - Price distribution across markets
   - Rating patterns and review counts
   - Cross-country price comparisons
   - Market-specific bestseller characteristics
   - Correlation analysis between variables
   - Top products by market

3. **Statistical Methods**:
   - K-means clustering of products based on price and rating patterns
   - Linear regression analysis of factors affecting product ratings
   - Summary statistics and hypothesis testing

4. **Conclusions**: Key findings and potential future directions for analysis

## Troubleshooting

**Issue**: Dataset not found
- **Solution**: Ensure `data/amazon_bestsellers_2025.csv` exists. Run `make data` for instructions.

**Issue**: Docker build fails
- **Solution**: Ensure Docker daemon is running. Try `docker ps` to verify.

**Issue**: R package installation fails
- **Solution**: Check internet connection. Some packages require system dependencies.

**Issue**: PDF generation fails
- **Solution**: Ensure LaTeX is installed. The Docker image includes texlive.

**Issue**: Permission denied errors
- **Solution**: Ensure proper permissions on project directory. Try `chmod -R 755 .`

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-analysis`)
3. Commit your changes (`git commit -m 'Add amazing analysis'`)
4. Push to the branch (`git push origin feature/amazing-analysis`)
5. Open a Pull Request

## License

This project is provided for educational purposes.

## Contact

For questions or issues, please open an issue in the GitHub repository.

---

**Note**: This project was created as part of a data science course requirement demonstrating reproducible research practices using Docker, Make, and R Markdown.
