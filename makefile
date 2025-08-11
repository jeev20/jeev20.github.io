date := $(shell date "+%Y-%m-%d %H:%M %z")


post:
	mkdir -p posts/$(name)/images && \
	printf '%s\n' '---' \
	'title: $(name)' \
	'description: $(name)' \
	'author: "Jeevith Hegde"' \
	'date: $(date)' \
	'format: html' \
	'toc: true' \
	'lang: en' \
	'jupyter: python3' \
	'ipynb-shell-interactivity: all' \
	'execute:' \
	'  echo: false' \
	'categories: ["UNTITLED"]' \
	'tags: ["TAG"]' \
	'comments:' \
	'  giscus:' \
	'    repo: jeev20/jeev20.github.io' \
	'---' > posts/$(name)/index.qmd



publish:
	bash ./tools/publish.sh    

dev:
	quarto preview index.qmd --no-browser --no-watch-inputs