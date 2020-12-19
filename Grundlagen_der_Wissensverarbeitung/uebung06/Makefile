.PHONY: default, all, watch, html, latex, pdf, epub, find

name=uebung06_gruppe4
group=BeerHansenNevermannWaller

default: open

all: html latex pdf epub

watchpdf:
	python2 ../pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o $(name)_$(group).pdf uebung.md

html:
	pandoc --toc --standalone -o uebung.html uebung.md

latex:
	pandoc --toc -V documentclass=article --template template.tex -o uebung.tex uebung.md

pdf:
	pandoc --toc -V documentclass=article --template template.tex -o $(name)_$(group).pdf uebung.md

open: pdf
	xdg-open $(name).pdf

epub:
	pandoc --toc -o uebung.epub uebung.md

package: pdf
	mkdir $(group)
	cp *.pdf $(group)
	cp *.py $(group)
	zip -r $(name)_$(group).zip $(group)
	rm -rf $(name)_$(group)

clean:
	rm -rf $(group)
	rm *.zip

