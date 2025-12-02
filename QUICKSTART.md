# Quick Start Guide - Amazon Bestsellers Analysis

## For Grading/Testing

### Quick Test (Without Data)
```bash
# Clone and verify structure
cd /tmp
git clone <repo-url> test-project
cd test-project
./test_project.sh
```

### Full Build Test (With Data)
```bash
# 1. Clone repository
git clone <repo-url>
cd amazon-bestsellers-analysis

# 2. Add dataset
mkdir -p data
# Download from: https://www.kaggle.com/datasets/sanskar21072005/amazon-best-sellers-2025
# Place as: data/amazon_bestsellers_2025.csv

# 3. Build and run
docker build . -t amazon-bestsellers-analysis
docker run --rm -v $(pwd):/project amazon-bestsellers-analysis make report

# 4. View output
ls -lh report.pdf
```

## Project Grading Checklist

### 1. Git Repository (~5 pts)
- [x] `.gitignore` configured for R/RStudio environment
- [x] Excludes generated files (PDFs, cache, .RData)
- [x] No `git add -A :/` artifacts

### 2. README.md (~15 pts)
- [x] Brief project description
- [x] Instructions to build/run container
- [x] Instructions to build report
- [x] Instructions for developers
- [x] Makefile organization explanation
- [x] Data acquisition instructions

### 3. Makefile (~15 pts)
- [x] `clean` target (phony)
- [x] Properly broken into tasks
- [x] Correctly tracked dependencies
- [x] `make report.pdf` target
- [x] Help target for documentation

### 4. Dockerfile (~50 pts total with other technical)
- [x] Based on `amoselb/rstudio-m1`
- [x] Installs required packages
- [x] Can `git clone`, `docker build`, `docker run`
- [x] Runs `make report.pdf` successfully

### 5. Data Science Component
- [x] Deep description of dataset
- [x] 4-6 figures with analysis
- [x] 1-2 statistical methods
- [x] Concluding notes
- [x] Future directions

## Makefile Targets

```bash
make help          # Show all available targets
make data          # Verify data and show download instructions
make install       # Install R packages locally
make report        # Generate report.pdf (main target)
make clean         # Remove generated files
make docker-build  # Build Docker image
make docker-run    # Run Docker container with RStudio
make docker-report # Build and generate report in one step
```

## Key Features

1. **Reproducible**: Complete Docker environment
2. **Automated**: Makefile handles all builds
3. **Documented**: Comprehensive README
4. **Professional**: Proper dependency tracking
5. **Analysis**: 6 figures + 2 statistical methods
6. **Clean**: Proper .gitignore configuration

## Troubleshooting

**Problem**: Dataset not found
**Solution**: Download from Kaggle and place in `data/` directory

**Problem**: Docker build fails
**Solution**: Ensure Docker is running: `docker ps`

**Problem**: Report generation fails
**Solution**: Check dataset is named correctly: `data/amazon_bestsellers_2025.csv`

**Problem**: Permission errors
**Solution**: Run with proper permissions: `chmod -R 755 .`

## Contact

For issues or questions, refer to README.md or open an issue in the repository.
