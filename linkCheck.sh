#!/bin/sh
echo $(date) > check-results.txt
echo "------------------------" >> check-results.txt
for i in *.adoc
do
  asciidoc-link-check "$i" -c config.json >> check-results.txt
done