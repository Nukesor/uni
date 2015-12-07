default: pdf

all: html latex pdf epub

watch:
	python2 pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o p2p.pdf p2p.md

html:
	pandoc --toc --standalone -o p2p.html p2p.md
latex:
	pandoc --toc -V documentclass=article --template template.tex -o p2p.tex p2p.md
pdf:
	pandoc --toc -V documentclass=article --template template.tex -o p2p.pdf p2p.md
	xdg-open p2p.pdf
epub:
	pandoc --toc -o p2p.epub p2p.md

