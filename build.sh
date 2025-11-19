#!/bin/bash

# Build script for CV LaTeX document

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to check if pdflatex is installed
check_pdflatex() {
    if ! command -v pdflatex &> /dev/null; then
        echo -e "${RED}Error: pdflatex is not installed${NC}"
        echo "Please install a LaTeX distribution (e.g., MacTeX for macOS, TeX Live for Linux)"
        exit 1
    fi
}

# Function to build the CV
build() {
    echo "Building CV..."

    # Run pdflatex twice to resolve references
    pdflatex -interaction=nonstopmode cv.tex > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        # Run again to ensure all references are resolved
        pdflatex -interaction=nonstopmode cv.tex > /dev/null 2>&1

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ CV built successfully!${NC}"
            echo "Output: cv.pdf"
        else
            echo -e "${RED}Error during second pass of pdflatex${NC}"
            echo "Run with --verbose flag for detailed output"
            exit 1
        fi
    else
        echo -e "${RED}Error during first pass of pdflatex${NC}"
        echo "Run with --verbose flag for detailed output"
        exit 1
    fi
}

# Function to build with verbose output
build_verbose() {
    echo "Building CV (verbose mode)..."

    # Run pdflatex twice to resolve references
    pdflatex -interaction=nonstopmode cv.tex

    if [ $? -eq 0 ]; then
        pdflatex -interaction=nonstopmode cv.tex

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ CV built successfully!${NC}"
            echo "Output: cv.pdf"
        else
            echo -e "${RED}Error during second pass of pdflatex${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error during first pass of pdflatex${NC}"
        exit 1
    fi
}

# Function to clean auxiliary files
clean() {
    echo "Cleaning auxiliary files..."
    rm -f cv.aux cv.log cv.out cv.toc cv.lof cv.lot cv.bbl cv.blg
    echo -e "${GREEN}✓ Cleaned successfully${NC}"
}

# Function to clean all generated files including PDF
clean_all() {
    clean
    echo "Removing PDF..."
    rm -f cv.pdf
    echo -e "${GREEN}✓ All generated files removed${NC}"
}

# Function to open the PDF
open_pdf() {
    if [ -f "cv.pdf" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open cv.pdf
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            xdg-open cv.pdf 2>/dev/null || echo "Please open cv.pdf manually"
        else
            echo "Please open cv.pdf manually"
        fi
    else
        echo -e "${RED}cv.pdf not found. Run ./build.sh first${NC}"
        exit 1
    fi
}

# Function to watch for changes and rebuild
watch() {
    echo "Watching cv.tex for changes... (Press Ctrl+C to stop)"

    if command -v fswatch &> /dev/null; then
        fswatch -o cv.tex | while read f; do
            clear
            echo "Change detected, rebuilding..."
            build
        done
    else
        echo -e "${RED}fswatch is not installed${NC}"
        echo "Install with: brew install fswatch (macOS) or apt-get install fswatch (Linux)"
        exit 1
    fi
}

# Main script logic
check_pdflatex

case "$1" in
    clean)
        clean
        ;;
    clean-all)
        clean_all
        ;;
    open)
        open_pdf
        ;;
    watch)
        watch
        ;;
    --verbose|-v)
        build_verbose
        ;;
    --help|-h)
        echo "Usage: ./build.sh [OPTION]"
        echo ""
        echo "Options:"
        echo "  (no option)    Build the CV PDF"
        echo "  clean          Remove auxiliary files (aux, log, etc.)"
        echo "  clean-all      Remove all generated files including PDF"
        echo "  open           Open the generated PDF"
        echo "  watch          Watch for changes and auto-rebuild"
        echo "  --verbose, -v  Build with verbose output"
        echo "  --help, -h     Show this help message"
        ;;
    *)
        build
        ;;
esac