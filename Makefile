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

all: index.html Makefile

index.html: README.adoc
	@echo '==> Generating index'
	$(DOCTOR) README.adoc -o index.html 

%.pdf: %.adoc
	@echo '==> Compiling asciidoc files with Asciidoctor to generate PDF'
	$(DOCTOR-PDF) -a stylesheet="$(STYLE)" --require $(TEMPLATE) $<

%.html: %.adoc 
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML'
	$(DOCTOR) $<
                
# %.slides.html: %.adoc 
# 	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML slides'
# 	asciidoctor-revealjs -a slides -o $@ $<


check: $(CHECK_RES)

$(CHECK_RES): *.adoc
	@echo "========================================"
	@echo "==> checking the fix "
	asciidoc-link-check CONTRIBUTING.adoc -c $(EXCLUDE_URLS) > $(CHECK_RES)
	asciidoc-link-check README.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check ci.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check git.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check intro.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check refactoring.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check requirements.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check tests.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check testingCI.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
	asciidoc-link-check qualityAssessment.adoc -c $(EXCLUDE_URLS) >> $(CHECK_RES)
#	markdown-link-check *.md -c $(EXCLUDE_URLS) >> $(CHECK_RES)

deploy: check index.html
	@echo "========================================"
	@echo "==> Deploy updates "
#	rake && git commit -am ":memo: Deploy updates"; git pull; git push
	rake && git commit -am ":robot: Deploy updates"; git pull; git push

clean:
	rm *.html