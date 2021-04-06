#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# usage: ruby check.rb [inputFile] [outputFile]
# -------------------
# Author::    Jean-Michel Bruel  (mailto:jbruel@gmail.com) 
# Copyright:: Copyright (c) 2020 JMB
# License::   Distributes under the same terms as Ruby
# -------------------

README = ARGV[0] ? ARGV[0] : "README.adoc"
RESULTS = ARGV[1] ? ARGV[1] : "results.csv"

all_repos = Dir.glob "*"
all_repos.each do |repo| 
  if (repo != "check.rb" && repo != RESULTS && repo != "plagiat.sh") then
    # do something
    print "----------------------------------\n"
    puts "Visiting  " + repo
    
    File.open(repo+"/"+README, :encoding => 'utf-8') { |f|

    error = []
    # ------------------- Get details
    content = f.read
    lastName = content.scan(/\{lastName\}:: (\w+)/) 
    firstName = content.scan(/\{firstName\}:: ([\w|\-]+)/)
    groupNb = content.scan(/\- \[[x|X]\] ([\w|\{|\}]+)/)

    if (lastName[0][0] != "BRUEL") then
      print "----------------------------------\n"
      print "Looking for autograding of " + firstName[0][0] + " "  + lastName[0][0] + "...\n"

      # ------------------- Maven results
      Dir.chdir(repo)
      result = `mvn test`
      stat = result.scan(/Tests run: (\d+), Failures: (\d+), Errors: (\d+), Skipped: (\d+)$/)
      error = result.scan(/\[ERROR\]/)
      Dir.chdir('..')
      
    #  print result

      # If no tests found
      if stat == [] then 
        stat = [['0','0','0']]
      end

      # Store the results
      File.open(RESULTS, "a") { |of| 
        of.write repo + "," \
        + firstName[0][0] + "," \
        + lastName[0][0] + "," \
        + groupNb[0][0] + "," \
        + stat[0][0] + "," \
        + stat[0][1] + "," \
        + stat[0][2] + ","
        if error != [] then 
          of.write "KO\n"
        else
          of.write "OK\n"
        end
      }
    end
  }
end
  # ------------------- Gradle results
end