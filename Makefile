BEAMER_TEMPLATE = pandoc_template.tex

MEXT = md
SRC = $(wildcard *.$(MEXT))

SLIDES_PDF = react.slides.pdf
NOTES_PDF = react.notes.pdf

all: slides

slides: $(SLIDES_PDF)

notes: $(NOTES_PDF)

clean:
	rm -f "$(SLIDES_PDF)" "$(NOTES_PDF)"

%.slides.pdf: %.slides.$(MEXT) $(BEAMER_TEMPLATE)
	pandoc -t beamer --latex-engine=xelatex --template=$(BEAMER_TEMPLATE) -o $@ $<

%.notes.pdf: %.notes.$(MEXT)
	pandoc -t latex -o $@ $<
