Feature: Map Page

  Scenario: GoogleMap widget should be created
    Given I am on the Map Page
    When the page is loaded
    Then I should see a GoogleMap widget

  Scenario: Generate correct number of markers
    Given I have a list of LatLng coordinates
    When I call the _generateMarkers function with this list
    Then I should get a list of Marker objects with the same length as the input list