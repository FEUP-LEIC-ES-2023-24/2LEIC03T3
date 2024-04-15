import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenIAmOnTheMapPage() {
  return given1<String, FlutterWorld>(
    'I am on the {string}',
    (route, context) async {
      // Navigate to the MapPage
    },
  );
}

StepDefinitionGeneric WhenThePageIsLoaded() {
  return when1<String, FlutterWorld>(
    'the {string} is loaded',
    (page, context) async {
      // Wait for the page to load
    },
  );
}

StepDefinitionGeneric ThenIShouldSeeAGoogleMapWidget() {
  return then1<String, FlutterWorld>(
    'I should see a {string} widget',
    (widget, context) async {
      // Check that a GoogleMap widget is present
    },
  );
}

StepDefinitionGeneric GivenIHaveAListOfLatLngCoordinates() {
  return given1<String, FlutterWorld>(
    'I have a list of {string} coordinates',
    (coordinates, context) async {
      // Set up a list of LatLng coordinates
    },
  );
}

StepDefinitionGeneric WhenICallTheGenerateMarkersFunctionWithThisList() {
  return when1<String, FlutterWorld>(
    'I call the {string} function with this list',
    (function, context) async {
      // Call the _generateMarkers function with the list of LatLng coordinates
    },
  );
}

StepDefinitionGeneric ThenIShouldGetAListOfMarkerObjectsWithTheSameLengthAsTheInputList() {
  return then1<String, FlutterWorld>(
    'I should get a list of {string} objects with the same length as the input list',
    (objects, context) async {
      // Check that the list of Marker objects has the same length as the input list
    },
  );
}