# Tim Richardson - CV

LaTeX-based CV with automated build system and pre-commit hooks.

## Prerequisites

- **LaTeX Distribution**: You need a LaTeX distribution installed (e.g., MacTeX for macOS, TeX Live for Linux)
  - macOS: `brew install --cask mactex` or download from [MacTeX](http://www.tug.org/mactex/)
  - Linux: `sudo apt-get install texlive-full` (Ubuntu/Debian) or equivalent

## Quick Start

```bash
# Clone the repository
git clone git@github.com:timini/cv.git
cd cv

# Build the CV
./build.sh

# View the generated PDF
./build.sh open
```

## Build Script Usage

The `build.sh` script provides several useful commands:

```bash
./build.sh           # Build the CV (creates cv.pdf)
./build.sh --verbose # Build with detailed output (useful for debugging)
./build.sh clean     # Remove auxiliary files (.aux, .log, etc.)
./build.sh clean-all # Remove all generated files including PDF
./build.sh open      # Open the generated PDF
./build.sh watch     # Auto-rebuild on file changes (requires fswatch)
./build.sh --help    # Show help message
```

## Pre-commit Hook

This repository includes an automatic pre-commit hook that:
1. Detects when `cv.tex` is modified
2. Automatically rebuilds the PDF
3. Adds the updated `cv.pdf` to your commit
4. Cleans up auxiliary LaTeX files

The hook is already installed in `.git/hooks/pre-commit` and will run automatically when you commit changes.

### How it works

When you modify and commit `cv.tex`:
```bash
# Edit the CV
vim cv.tex

# Stage your changes
git add cv.tex

# Commit - the PDF will be built automatically
git commit -m "Update CV"
```

The pre-commit hook will:
- ✅ Rebuild the PDF automatically
- ✅ Add the updated PDF to your commit
- ✅ Clean up auxiliary files
- ❌ Prevent commit if LaTeX compilation fails

## Project Structure

```
cv/
├── cv.tex          # LaTeX source file
├── cv.pdf          # Generated PDF (auto-built)
├── build.sh        # Build script
├── README.md       # This file
└── .gitignore      # Ignores LaTeX auxiliary files
```

## Making Changes

1. Edit `cv.tex` with your preferred text editor
2. Run `./build.sh` to preview changes (or use `./build.sh watch` for auto-rebuild)
3. Commit your changes - the PDF will be automatically rebuilt

```bash
git add cv.tex
git commit -m "Update experience section"
git push
```

## Troubleshooting

### LaTeX Package Missing

If you encounter errors about missing packages (e.g., `titlesec.sty not found`):
```bash
# macOS with MacTeX
sudo tlmgr install package-name

# Linux
sudo apt-get install texlive-package-name
```

### Build Failures

If the build fails:
1. Run `./build.sh --verbose` to see detailed error messages
2. Check the `cv.log` file for LaTeX compilation errors
3. Ensure all required packages are installed

### Pre-commit Hook Not Working

If the pre-commit hook isn't running:
```bash
# Ensure it's executable
chmod +x .git/hooks/pre-commit
```

## License

Personal CV - All rights reserved

## Contact

- Email: tim@rewire.it
- GitHub: [github.com/timini](https://github.com/timini)
- Website: [rewire.it](http://rewire.it)