PANDOC := /usr/local/bin/pandoc
MARKDOWN_USAGE_FILES = $(shell find . -name index.md)
HTML_USAGE_FILES = $(MARKDOWN_USAGE_FILES:.md=.html)
BASH_USAGE_FILES = $(MARKDOWN_USAGE_FILES:.md=.sh)

all: $(HTML_USAGE_FILES) $(BASH_USAGE_FILES)

%.sh: %.md
	printf "[PANDOC] %-28s > %s\n" "$<" $@
	${PANDOC} -f markdown -t _writers/script.lua \
		--normalize -o "$@" "$<"

%.html: %.md
	printf "[PANDOC] %-28s > %s\n" "$<" $@
	${PANDOC} -f markdown -t html5 --mathjax --toc \
		--base-header-level=2 --toc-depth=4 \
		--template=./_templates/page.html -o "$@" "$<"

clean:
	rm -f $(HTML_USAGE_FILES) $(BASH_USAGE_FILES)

backgrounds: backgrounds/index.html backgrounds/index.sh

morphology: morphology/index.html morphology/index.sh

basics: basics/index.html basics/index.sh

blur: blur/index.html blur/index.sh

canvas: canvas/index.html canvas/index.sh

.SILENT: $(HTML_USAGE_FILES) $(BASH_USAGE_FILES)
