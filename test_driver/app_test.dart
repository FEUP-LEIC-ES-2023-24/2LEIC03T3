import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';
import 'navigation_step_definitions.dart';
import 'map_step_definitions.dart';

void main() {
  final config = FlutterTestConfiguration()
    ..features = ['test_driver/**/*.feature']
    ..reporters = [
      ProgressReporter(),
      TestRunSummaryReporter(),
      JsonReporter(path: './report.json'),
    ]
    ..stepDefinitions = [
      GivenIAmOnTheDefaultWaterReportScreen(),
      WhenITapTheBackButton(),
      ThenIShouldBeTakenBackToTheMapPage(),
      GivenIAmOnTheMapPage(),
      WhenThePageIsLoaded(),
      ThenIShouldSeeAGoogleMapWidget(),
      GivenIHaveAListOfLatLngCoordinates(),
      WhenICallTheGenerateMarkersFunctionWithThisList(),
      ThenIShouldGetAListOfMarkerObjectsWithTheSameLengthAsTheInputList()
    ] // Include your step definitions
    ..restartAppBetweenScenarios = true
    ..targetAppPath = "test_driver/app.dart";

  Future<void> main() {
    return GherkinRunner().execute(config);
  }
}