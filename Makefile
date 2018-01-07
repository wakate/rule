LATEX  = platex
DVIPDF = dvipdfmx
PANDOC = pandoc
RM = rm

ROOT = rule

ROOT_MD = $(ROOT).md
TEMPLATE_TEX = template.tex
ROOT_TEX = $(ROOT).tex
ROOT_DVI = $(ROOT).dvi
ROOT_PDF = $(ROOT).pdf
ROOT_AUX = $(ROOT).aux

GENERATED_FILES = $(ROOT).log

.DEFAULT_GOAL = pdf

.PHONY : pdf
pdf : $(ROOT_PDF)
$(ROOT_PDF) : $(ROOT_DVI)
	$(DVIPDF) $(ROOT_DVI)

.PHONY : dvi
dvi : $(ROOT_DVI)
$(ROOT_DVI) : $(ROOT_TEX) $(ROOT_AUX)
	$(LATEX) -halt-on-error $(ROOT_TEX)
	$(LATEX) -halt-on-error $(ROOT_TEX)

.PHONY : aux
aux : $(ROOT_AUX)
$(ROOT_AUX) : $(ROOT_TEX)
	$(LATEX) -halt-on-error $(ROOT_TEX)

.PHONY : tex
tex : $(ROOT_TEX)
$(ROOT_TEX) : $(ROOT_MD) $(TEMPLATE_TEX)
	$(PANDOC) $(ROOT_MD) --template=$(TEMPLATE_TEX) -o $(ROOT_TEX)

.PHONY : clean
clean:
	$(RM) \
		$(ROOT_PDF) \
		$(ROOT_TEX) \
		$(ROOT_DVI) \
		$(ROOT_AUX) \
		$(GENERATED_FILES); true

