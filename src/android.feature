Feature: Book Search
    Scenario: Search books by author
      Given there's a book called "Tips for job interviews" written by "John Smith"
        And there's a book called "Bananas and their many colors" written by "James Doe"
        And there's a book called "Mama look I'm a rock star" written by "John Smith"
      When an employee searches by author "John Smith"
      Then 2 books should be found
        And Book 1 has the title "Tips for job interviews"
        And Book 2 has the title "Mama look I'm a rock star"
