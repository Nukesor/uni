version	:= $(shell cat ./version)
default: pdf

all: html latex pdf epub

watch:
	python2 pandoc-watch/pandocwatch.py --toc -V documentclass=article --template template.tex -o "Praktikum Vernetzte Systeme SS 2014 Gruppe 10 Labreport Part $(version).pdf" "Labreport.md"
html:
	pandoc --toc --standalone -o "Praktikum Vernetzte Systeme SS 2014 Gruppe 10 Labreport Part $(version).html" "Labreport.md"
latex:
	pandoc --toc -V documentclass=article --template template.tex -o "Praktikum Vernetzte Systeme SS 2014 Gruppe 10 Labreport Part $(version).tex" "Labreport.md"
pdf:
	pandoc --toc -V documentclass=article --template template.tex -o "Praktikum Vernetzte Systeme SS 2014 Gruppe 10 Labreport Part $(version).pdf" "Labreport.md"
epub:
	pandoc --toc -o "Praktikum Vernetzte Systeme SS 2014 Gruppe 10 Labreport Part $(version).epub" "Labreport.md"
