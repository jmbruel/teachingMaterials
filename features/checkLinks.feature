#------------------------------
# Checking URLs
# JMB - 2020
#------------------------------
# language: en
Feature: Teaching Materials Quality Assemsment
    Every material should have correct links

Scenario: The URLs mentioned in an Asciidoc document should be verified (non 404)
    Given An Asciidoc file
    Then All the URLs should be active        

