import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:tutorial_app/widgets/error_widget.dart';

void main() {
  late DeviceBuilder builder;

  setUp(() {
    builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ]);
  });

  testGoldens('Error Widget Description Should be Dynamic', (tester) async {
    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: ErrorLoadingWidget(
        errorMessage: 'Dynamic Loading Screen Text',
        buttonText: 'Generic Text',
        onPressed: () {},
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'error_loading_widget_message');
  });

  testGoldens('Error Widget Button Should be Dynamic', (tester) async {
    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: ErrorLoadingWidget(
        errorMessage: 'Generic Text',
        buttonText: 'Dynamic Button Text',
        onPressed: () {},
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'error_loading_widget_button');
  });
}
