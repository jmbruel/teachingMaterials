Given('An Asciidoc file') do
    $source = "README.adoc"
  end
  
  Then('All the URLs should be active') do
    system("asciidoc-link-check #{$source} -c config.json")
  end
  