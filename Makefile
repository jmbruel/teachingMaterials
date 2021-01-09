#-----------------------------------------------------
# Some usefull instructions...
#
EXCLUDE_URLS    = config.json
CHECK_RES       = check-results.txt
DOCTOR			= asciidoctor
DOCTOR-PDF		= asciidoctor-web-pdf
STYLE			= jmb.css
TEMPLATE		= ./book.js
#-----------------------------------------------------

all: *.html *.slides.html *.pdf

index.html: README.adoc
	@echo '==> Generating index'
	$(DOCTOR) README.adoc -o index.html 

%.html: %.adoc 
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML'
	$(DOCTOR) $<
                
%.pdf: %.adoc
	@echo '==> Compiling asciidoc files with Asciidoctor to generate PDF'
	$(DOCTOR-PDF) -a stylesheet="$(STYLE)" --require $(TEMPLATE) $<

%.slides.html: %.adoc 
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML'
	bundle exec asciidoctor-revealjs -a slides -o $@ $<


check: $(CHECK_RES)

$(CHECK_RES): *.adoc
	@echo "========================================"
	@echo "==> checking the fix "
	asciidoc-link-check *.adoc -c $(EXCLUDE_URLS) > $(CHECK_RES)
	markdown-link-check *.md -c $(EXCLUDE_URLS) >> $(CHECK_RES)

deploy: check
	@echo "========================================"
	@echo "==> Deploy updates "
	rake && git commit -am ":memo: Deploy updates"; git pull; git push

clean:
	rm *.html