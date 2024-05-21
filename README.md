[![Build and Deploy](https://github.com/jeev20/jeev20.github.io/actions/workflows/pages-deploy.yml/badge.svg)](https://github.com/jeev20/jeev20.github.io/actions/workflows/pages-deploy.yml)

The makefile contains some of the essential actions.

```makefile
newpost:
	bundle exec jekyll post $(name)
edits:
	bundle exec jekyll s --livereload --trace 
publish:
	bash ./tools/publish.sh
```