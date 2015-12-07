.PHONY: default, pdf, open, clean

name=securitySeminar

default: open

pdf:
	rm -f $(name).pdf
	pdflatex sheet.tex
	mv sheet.pdf $(name).pdf

open: pdf
	xdg-open $(name)_$(group).pdf

clean:
	rm -f *.zip
	rm -f *.fls
	rm -f *.log
	rm -f *.out
	rm -f *.aux
	rm -f *.fdb*

