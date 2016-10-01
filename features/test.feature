@testing
Feature: Automated Test Posts

  As the CTO of tray
  I want to be able to test the programming code of the Automation QA
  So that I know that I am not hiring a numpty and the candidate knows how to use google

  Scenario Outline: Checking the "get_user" responds correctly, Example of api post call with happy path check
    Given I have testing endpoint "https://edy585mx12.execute-api.eu-west-1.amazonaws.com/prod"
    And I want to test the get_user POST
    And I add the following unique id "test"
    And I build the post body for get_user
    When I make the post
    Then I should get the following <type> and <object>
  Examples:
    |   type    | object      |
    | id        | 1           |
    | name      | Ali Russell |
    | company   | tray.io     |
    | location  | London, UK  |
    | twitter   | https://twitter.com/alirussell |

  Scenario: Checking the Json validation against post,  Example of api post, with schema validation
    Given I have the schema for get_user
    When I have a valid response for get_user
    Then response should be valid compared to the schema

  Scenario Outline: Checking the "is_url" responds correctly, another example of api post
    Given I have testing endpoint "https://edy585mx12.execute-api.eu-west-1.amazonaws.com/prod"
    And I want to test the is_url POST
    And I add the following unique id "test"
    And I add the following value "https://edy585mx12.execute-api.eu-west-1.amazonaws.com"
    And I build the post body for is_url
    When I make the post
    Then I should get the following <type> and <object>
    Examples:
      |   type    | object      |
      | result    | true        |

  Scenario: Checking the Json validation against post, another example of api post, with schema validation
    Given I have the schema for is_url
    When I have a valid response for is_url
    Then response should be valid compared to the schema

  Scenario Outline: Checking all connector posts, as starting to feel sleepy
    Given I have the schema for <connector>
    When I have a valid response for <connector>
    Then response should be valid compared to the schema
  Examples:
    | connector         |
    | is_numeric        |
    | is_generic_domain |
    | is_email          |
    | is_url            |
    | get_user          |
