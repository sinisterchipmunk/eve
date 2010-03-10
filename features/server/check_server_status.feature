Feature: Check server status
  Check server status. Server responds with current time, whether server is open, # of online players, and cache
  duration.

  Scenario: Check server status
    When I request the server status
    Then the result should include "serverOpen"
    And the result should include "onlinePlayers"
