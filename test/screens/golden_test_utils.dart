import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tutorial_app/chuck_norris_application.dart';

/// Challenge B:
/// To run golden tests you have to type flutter test --update-goldens
/// Add the flutter_golden_toolkit package to an app.
/// Setup your flutter_test_config.dart file the way I did.
/// Play along with the documentation here:
/// https://pub.dev/packages/golden_toolkit and see if you can get golden tests
/// to generate (they'll be in a goldens folder).
testGoldensForPhones({
  required String description,
  required Widget widgetToTest,
  required String fileName,
}) {
  testGoldens(description, (tester) async {
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ])
      ..addScenario(
        // We want to wrap the widget we're testing with our application file
        // so that it is able to grab the theme we setup for it there.
        // Otherwise it'll have to use default values, i.e. blue.
        widget: ChuckNorrisApplication(
          home: widgetToTest,
        ),
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, fileName);
  });
}
