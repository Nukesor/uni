.PHONY: default, pdf, open, clean

mdname='bericht'
name='i-o-Analysis'

default: pandoc-pdf

all: html latex pdf epub

watch:
	python2 pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o $(name).pdf -o $(name).tex $(mdname).md

html:
	pandoc --toc --standalone -o $(name).html $(mdname).md
latex:
	pandoc --toc -V documentclass=article --template template.tex -o $(name).tex $(mdname).md

pdf:
	pandoc --filter pandoc-citeproc --bibliography=literatur.bib -o $(name).pdf $(name).tex
	xdg-open $(name).pdf

pandoc-pdf: latex pdf

epub:
	pandoc --toc -o $(name).epub $(mdname).md
