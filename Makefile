#-----------------------------------------------------
# Some usefull instructions...
#
EXCLUDE_URLS    = config.json
CHECK_RES       = check-results.txt
DOCTOR			= asciidoctor
DOCTOR-PDF		= asciidoctor-pdf
STYLE			= jmb.css
TEMPLATE		= ./book.js
#-----------------------------------------------------

all: index.html Makefile

index.html: README.adoc check
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

checks/%.txt: %.adoc
	@echo "========================================"
	@echo "==> checking the fix "
	asciidoc-link-check $ -c $(EXCLUDE_URLS) $< > $@


$(CHECK_RES): checks/*.txt
	@echo "========================================"
	@echo "==> checking the fix "
	@echo `date` > $(CHECK_RES)
	cat checks/*.txt >> $(CHECK_RES)

deploy: check index.html
	@echo "========================================"
	@echo "==> Deploy updates "
#	rake && git commit -am ":memo: Deploy updates"; git pull; git push
	rake && git commit -am ":robot: Deploy updates"; git pull; git push

clean:
	rm *.html