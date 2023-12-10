#------------------------------
# Bad/Good illustration
# JMB - 2023
#------------------------------
# language: en

#--------- FEATURE ----------------
Feature: Use genericity as much as possible
    DRY: Do not Repeat Yourself

#--------- BACGROUND ----------------
    Background:
        Given a global administrator named "Greg"
        And a blog named "Greg's anti-tax rants"
        And a customer named "Dr. Bill"
        And a blog named "Expensive Therapy" owned by "Dr. Bill"

#--------- RULE ----------------
    Rule: About eating

#--------- SCENARIO ----------------
        Scenario: Bad steps definition
            Given I go to the home page
            Given I check the about page of the website
            Given I get the contact details

        Scenario: Good steps definition
            Given I go to the {} page

        Scenario: Alternative text
            Given I have {int} cucumber(s) in my belly/stomach
        # Would match all these expressions:
        #     I have 1 cucumber in my belly
        #     I have 1 cucumber in my stomach
        #     I have 42 cucumbers in my stomach
        #     I have 42 cucumbers in my belly

    Rule: With Examples

        Scenario Outline: eating
        Given there are <start> cucumbers
        When I eat <eat> cucumbers
        Then I should have <left> cucumbers

        Examples:
            | start | eat | left |
            |    12 |   5 |    7 |
            |    20 |   5 |   15 |

