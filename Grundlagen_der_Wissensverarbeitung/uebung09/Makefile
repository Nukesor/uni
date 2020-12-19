.PHONY: default, all, watch, html, latex, pdf, epub, find

name=uebung08_gruppe4
group=BeerHansenNevermannWaller

default: open

latex:
	pandoc --toc -V documentclass=article --template template.tex -o uebung.tex uebung.md

texpdf:
	rm -f $(name)_$(group).pdf
	pdflatex uebung.tex
	mv uebung.pdf $(name)_$(group).pdf

pdf:
	pandoc --toc -V documentclass=article --template template.tex -o $(name)_$(group).pdf uebung.md

open: texpdf
	xdg-open $(name)_$(group).pdf

package: pdf
	mkdir $(group)
	cp *.pdf $(group)
	cp *.py $(group)
	zip -r $(name)_$(group).zip $(group)
	rm -rf $(name)_$(group)

clean:
	rm -rf $(group)
	rm -f *.zip
	rm -f *.fls
	rm -f *.log
	rm -f *.out
	rm -f *.aux
	rm -f *.fdb*

