Feature: Automatic discounts for premium customers
    Premium customers should automatically get a
    discount of 10% on purchases over $100.
 
    Scenario: Purchase over $100
        Given a premium customer
        And an order containing
            | item   | amount | price |
            | pencil | 100    | 1     |
            | paper  | 1      | 35    |
        When the customer checks out
        Then the total price should be 121.5
        