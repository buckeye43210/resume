# Makefile to generate resume.pdf from resume_short.md using Pandoc and xelatex
# Assumes RHEL 8/9 with Python venv at ~/ansible-venv
# Input: resume_short.md (Markdown resume content)
# Template: resume_template.tex (Pandoc LaTeX template)
# Output: resume.pdf

# Variables
PANDOC = /usr/bin/pandoc
ASPELL = /usr/bin/aspell
INPUT_MD = resume_long.md
OUTPUT_PDF = resume.pdf
TEMPLATE = resume_template.tex

# Generate PDF border using ps2pdf
.PHONY: border
border:
	@echo "Generating border with ps2pdf..."
	ps2pdf ./images/border01.ps ./images/border01.pdf
	ps2pdf ./images/border02.ps ./images/border02.pdf

# Generate PDF using Pandoc with xelatex
.PHONY: short
short:
#$(OUTPUT_PDF): $(INPUT_MD) $(TEMPLATE)
	@echo "Generating $(OUTPUT_PDF) with Pandoc..."
	$(PANDOC) $(INPUT_MD) -o $(OUTPUT_PDF) --pdf-engine=xelatex --template=$(TEMPLATE)

# Check spelling using aspell
.PHONY: spell
spell:
	@echo "Spell checking $(INPUT_MD) with aspell..."
	$(ASPELL) --lang=en --mode=markdown --add-filter=markdown check $(INPUT_MD)

# Clean up intermediate files
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(OUTPUT_PDF) *.log *.aux *.out

# Help
.PHONY: help
help:
	@echo "Makefile to generate resume.pdf from resume_short.md with Pandoc"
	@echo "Targets:"
	@echo "  all        : Generate $(OUTPUT_PDF) (default)"
	@echo "  clean      : Remove intermediate files"
	@echo "  help       : Show this help message"
	@echo "Requirements:"
	@echo "  - $(INPUT_MD): Markdown input file"
	@echo "  - $(TEMPLATE): Pandoc LaTeX template"

