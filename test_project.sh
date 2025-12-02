#!/bin/bash
# test_project.sh - Script to test the project structure

echo "=========================================="
echo "Amazon Bestsellers Analysis - Project Test"
echo "=========================================="
echo ""

# Test 1: Check project files exist
echo "Test 1: Checking project files..."
files=("Dockerfile" "Makefile" "README.md" "analysis.Rmd" ".gitignore")
all_exist=true

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file exists"
    else
        echo "  ✗ $file missing"
        all_exist=false
    fi
done

if [ "$all_exist" = true ]; then
    echo "  All required files present!"
else
    echo "  Some files are missing!"
    exit 1
fi

echo ""

# Test 2: Check data directory
echo "Test 2: Checking data directory..."
if [ -d "data" ]; then
    echo "  ✓ data/ directory exists"
    if [ -f "data/amazon_bestsellers_2025.csv" ]; then
        echo "  ✓ Dataset found!"
    else
        echo "  ! Dataset not found (this is expected - see README for download instructions)"
    fi
else
    echo "  ✗ data/ directory missing"
    exit 1
fi

echo ""

# Test 3: Validate Makefile targets
echo "Test 3: Checking Makefile targets..."
if command -v make &> /dev/null; then
    echo "  ✓ make is available"
    echo "  Available targets:"
    make help 2>/dev/null | grep -E "^  make" || echo "    (run 'make help' for details)"
else
    echo "  ! make command not found (install make to test)"
fi

echo ""

# Test 4: Check Dockerfile syntax
echo "Test 4: Validating Dockerfile..."
if command -v docker &> /dev/null; then
    echo "  ✓ Docker is available"
    # Just check if file is readable, full validation requires docker build
    if [ -r "Dockerfile" ]; then
        echo "  ✓ Dockerfile is readable"
        echo "  Run 'make docker-build' to build the image"
    fi
else
    echo "  ! Docker not found (install Docker to build container)"
fi

echo ""

# Test 5: Check .gitignore
echo "Test 5: Checking .gitignore configuration..."
if [ -f ".gitignore" ]; then
    key_patterns=("*.pdf" "*.Rhistory" ".RData" ".DS_Store")
    for pattern in "${key_patterns[@]}"; do
        if grep -q "$pattern" .gitignore; then
            echo "  ✓ Ignoring: $pattern"
        fi
    done
fi

echo ""
echo "=========================================="
echo "Project structure test complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Download dataset from Kaggle (see README.md)"
echo "2. Place it in data/amazon_bestsellers_2025.csv"
echo "3. Run 'make docker-build' to build container"
echo "4. Run 'make docker-run' to start RStudio"
echo "5. In RStudio, run 'make report' to generate PDF"
echo ""
