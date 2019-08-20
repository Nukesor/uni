.PHONY: clean all expose

all: expose clean

expose:
	rubber --unsafe -d expose.tex
	texcount expose.tex

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
