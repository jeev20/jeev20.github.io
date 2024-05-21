newpost:
	bundle exec jekyll post $(name)

dev:
	bundle exec jekyll s --livereload --trace 

publish:
	bash ./tools/publish.sh