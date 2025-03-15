[![Build and Deploy](https://github.com/jeev20/jeev20.github.io/actions/workflows/pages-deploy.yml/badge.svg)](https://github.com/jeev20/jeev20.github.io/actions/workflows/pages-deploy.yml)

The makefile contains some of the essential actions.

```makefile
new:
	bundle exec jekyll post $(name)

dev:
	bundle exec jekyll s --livereload --trace 

publish:
	bash ./tools/publish.sh                                        

build:
	bundle exec jekyll build

htmlproofer:
	bundle exec htmlproofer _site     \-\-disable-external     \-\-ignore-urls "/^http:\/\/127.0.0.1/,/^http:\/\/0.0.0.0/,/^http:\/\/localhost/"
```