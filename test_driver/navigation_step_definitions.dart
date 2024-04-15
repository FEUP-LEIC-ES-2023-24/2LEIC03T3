import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric GivenIAmOnTheDefaultWaterReportScreen() {
  return given1<String, FlutterWorld>(
    'I am on the {string}',
    (route, context) async {
      // Navigate to the DefaultWaterReportScreen
    },
  );
}

StepDefinitionGeneric WhenITapTheBackButton() {
  return when1<String, FlutterWorld>(
    'I tap the {string}',
    (button, context) async {
      // Tap the back button
    },
  );
}

StepDefinitionGeneric ThenIShouldBeTakenBackToTheMapPage() {
  return then1<String, FlutterWorld>(
    'I should be taken back to the {string}',
    (route, context) async {
      // Check that we're on the MapPage
    },
  );
}