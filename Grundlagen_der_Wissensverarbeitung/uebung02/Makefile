.PHONY: default, all, watch, html, latex, pdf, epub

name=uebung02_gruppe4.pdf

default: pdf

all: html latex pdf epub

watch:
	python2 ../pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o $(name) uebung.md

html:
	pandoc --toc --standalone -o uebung.html uebung.md

latex:
	pandoc --toc -V documentclass=article --template template.tex -o uebung.tex uebung.md

pdf:
	pandoc --toc -V documentclass=article --template template.tex -o $(name) uebung.md
	xdg-open $(name)

epub:
	pandoc --toc -o uebung.epub uebung.md

