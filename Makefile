BEAMER_TEMPLATE = pandoc_template.tex

MEXT = md
SRC = $(wildcard *.$(MEXT))

SLIDES_PDF = react.slides.pdf

TEXC = xelatex
TEXC_OPTS = -shell-escape -halt-on-error

all: slides

slides: $(SLIDES_PDF)

clean:
	rm -f "$(SLIDES_PDF)"

%.slides.pdf: %.slides.$(MEXT) $(BEAMER_TEMPLATE)
	pandoc -t beamer --latex-engine=xelatex --template=$(BEAMER_TEMPLATE) -o $@ $<

#%.slides.pdf: %.slides.tex $(BEAMER_TEMPLATE)
	#$(TEXC) $(TEXC_OPTS) $<
