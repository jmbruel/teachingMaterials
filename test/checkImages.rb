
re = Regexp.new("\.adoc$") # asciidoc source file
status = 0

dir = Dir.new('.')
dir.each  {|fn|
    if ( fn =~ re ) then
        print "----------------------------------\n"
        print "asciidoc source : " + fn + "\n"
        paths = []
        imagesDirs = [] # can be many by error => we take the last only
        imagesDir = ""
        # find all image: or image:: asciidoc macros
        File.open(fn) { |f|
            content = f.read
            imagesDirs = content.scan(/:images: (.*)/)
            paths = content.scan(/image::?([^\[ ]+)\[/)
        }
        imagesDir="images"
        # test that path is a file
        paths.flatten.each {|path|
          if (!path.match(/^http/)) and (!path.match(/^{/)) 
            if (data = /({images}).*/.match(path))
              oldpath=path
              path=path.gsub("{images}",imagesDir)              
              if (File.file?("images/"+path))
                print " OK " + oldpath + "\n"
              else
                print " NOK " + oldpath + "\n"  
                status = 1          
              end
            else
              if (File.file?("images/"+path))
                print " OK " + path + "\n"
              else
                print " NOK " + path + "\n"  
                status = 1          
              end
            end
          end
        }
    end
    exit status
}
