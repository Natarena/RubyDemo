#Author: nathalia.c.rodrigues
@tag
Feature: search something in google

  @gmail @search_data
  Scenario Outline: doing search
    Given the user open the browser in access the "<site>"
    And set value for the search "<data_search>"
    And verify the return of the search  "<data_search>"

    Examples: 
      | site                 | data_search |
      | http://google.com.br | Recife      |
