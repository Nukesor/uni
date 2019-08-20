.PHONY: default all watch show clean
DEPS = thesis.tex thesis.bib thesis.cls
PRESENTATION_DEPS = presentation.tex

default: thesis clean show

all:thesis.pdf presentation.pdf clean

watch:
	evince thesis.pdf &
	while true; do inotifywait -e close_write,moved_to,create */**/*.tex $(DEPS); make thesis; make clean; done;

watch-presentation:
	evince presentation.pdf &
	while true; do inotifywait -e close_write,moved_to,create $(PRESENTATION_DEPS); make presentation; make clean; done;

thesis:
	rubber --unsafe --pdf thesis.tex

presentation:
	rubber --unsafe --pdf presentation.tex

show:
	evince thesis.pdf &

clean:
	@rm -f *.aux
	@rm -f *.lol
	@rm -f *.bbl
	@rm -f *.blg
	@rm -f *.bcf
	@rm -f *.lof
	@rm -f *.log
	@rm -f *.lot
	@rm -f *.out
	@rm -f *.nav
	@rm -f *.run.xml
	@rm -f *.snm
	@rm -f *.toc
	@rm -f *.vrb
	@rm -rf _minted*
	@rm -f *.pyg
