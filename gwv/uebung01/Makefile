default: pdf

all: html latex pdf epub

watch:
	python2 ../pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o uebung01.pdf uebung01.md

html:
	pandoc --toc --standalone -o uebung01.html uebung01.md
latex:
	pandoc --toc -V documentclass=article --template template.tex -o uebung01.tex uebung01.md
pdf:
	pandoc --toc -V documentclass=article --template template.tex -o uebung01.pdf uebung01.md
	xdg-open uebung01.pdf
epub:
	pandoc --toc -o uebung01.epub uebung01.md

