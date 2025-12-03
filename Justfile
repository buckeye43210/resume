# Justfile to generate resume.pdf from resume_short.md using Pandoc and xelatex
# Assumes RHEL 8/9
# Input: resume_short.md (Markdown resume content)
# Template: resume_template.tex (Pandoc LaTeX template)
# Output: resume.pdf

# Generate PDF border using ps2pdf
border:
	echo "Generating border with ps2pdf..."
	ps2pdf ./images/border01.ps ./images/border01.pdf
	ps2pdf ./images/border02.ps ./images/border02.pdf

# Generate PDF using Pandoc with xelatex
pdf:
	echo "Generating resume.pdf using Pandoc..."
	pandoc resume_long.md -o resume.pdf --pdf-engine=xelatex --template=resume_template.tex

typst:
	echo "Generating resume.pdf using Typst..."
	typst compile resume.typ resume.pdf

watch:
	echo "Recompiling after change detection..."
	typst watch resume.typ resume.pdf
