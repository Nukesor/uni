TEX=paper.tex
build:
	rubber --unsafe --pdf $(TEX)

watch:
	watchexec -e tex,bib make build

clean:
	rubber --clean $(TEX)
	rm -rf _minted-$(TEX)
