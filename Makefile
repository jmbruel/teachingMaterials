#-----------------------------------------------------
# Some usefull instructions...
#
EXCLUDE_URLS    = config.json
CHECK_RES       = check-results.txt
#DOCTOR			= asciidoctor -r asciidoctor-diagram
DOCTOR			= asciidoctor
#DOCTOR-PDF		= asciidoctor-web-pdf --require $(TEMPLATE)
DOCTOR-PDF		= asciidoctor-pdf -a pdf-backend -a slides!
STYLE			= jmb.css
TEMPLATE		= ./book.js
#-----------------------------------------------------

all: *.html *.pdf Makefile

index.html: README.adoc check
	@echo '==> Generating index'
	$(DOCTOR) README.adoc -o index.html 

%.pdf: %.adoc
	@echo '==> Compiling asciidoc files with Asciidoctor to generate PDF'
	$(DOCTOR-PDF) -a stylesheet="$(STYLE)" -a toc -a numbered $<

%.html: %.adoc 
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML'
	$(DOCTOR) -a slides! -a toc=left $<
                
%.slides.html: %.adoc 
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML slides'
	asciidoctor-revealjs -a slides -o $@ $<

images/%.svg: images/%.plantuml
	@echo '==> Compiling plantUML files to generate SVG'
	java -jar plantuml.jar -tsvg $<

images/%.png: images/%.plantuml
	@echo '==> Compiling plantUML files to generate SVG'
	java -jar plantuml.jar -tpng $<

check: $(CHECK_RES)

checks/%.txt: %.adoc
	@echo "========================================"
	@echo "==> checking the URLs "
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
	rake && git commit -am "🤖 DEPLOY: last updates"; git pull; git push

clean:
	rm *.html