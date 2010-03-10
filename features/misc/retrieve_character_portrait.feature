Feature: Retrieve character portrait
  Server responds with a String representing a JPG of the requested character portrait.

  Scenario: Retrieve character portrait
    When I request portrait with character ID "01234567890"
    Then the result should be a String
