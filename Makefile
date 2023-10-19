BOOK_TITLE = Pull\ Requests\ and\ Code\ Review
BOOK_AUTHOR = Sebastien\ Castiel

BOOK_FILENAME = $(BOOK_TITLE)\ -\ $(BOOK_AUTHOR)

all: epub pdf

epub: dist/$(BOOK_FILENAME).epub

pdf: dist/$(BOOK_FILENAME).pdf

dist/$(BOOK_FILENAME).epub: dist manuscript.md cover.jpg style-epub.css
		@echo "Generating ePub: $@..." && \
		pandoc -s manuscript.md \
			-o "$@" \
			--highlight-style=kate \
			--metadata title="$(subst  \,,$(BOOK_TITLE))" \
			--metadata author="$(subst \,,$(BOOK_AUTHOR))" \
			--epub-cover-image=cover.jpg \
			-N --table-of-contents --toc-depth=1 -M toc-title:"Table of contents" \
			-c style-epub.css

dist/$(BOOK_FILENAME).pdf: dist manuscript.md header.tex cover.txt cover.pdf
		@echo "Generating PDF: $@..." && \
		pandoc -s cover.txt manuscript.md \
						-o "$@" \
						--highlight-style=kate \
						-N \
						-H header.tex \
						-V title-meta="$(subst  \,,$(BOOK_TITLE))" \
						-V author-meta="$(subst  \,,$(BOOK_AUTHOR))" \
						-V lang="en-US" \
						-V geometry="paperwidth=8in, paperheight=10in, margin=1in" \
						-V fontsize="12pt" \
						-V documentclass="book" \
						-V classoption="openany" \
						-V monofont="FiraCode"

dist:
		@mkdir -p dist

clean:
		@rm -rf dist
