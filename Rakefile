task default: %w[test]

task deploy: [:test, :check]

fl = FileList['*.adoc']

task :test do
  ruby "test/checkImages.rb"
end

task :check do
  sh "echo `date`> check-results.txt"
  fl.each do |source|
    sh "asciidoc-link-check #{source} -c config.json >> check-results.txt"
  end
end

rule '.html' => ['.adoc'] do |t|
  sh "asciidoctor #{t.source} -o #{t.name}"
end