import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorial_app/chuck_norris_application.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/screens/categories/categories_screen.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

import '../../mocks.dart';

/// Challenge I - Create your own Golden tests. Being sure to follow the
/// documentation here - https://pub.dev/packages/golden_toolkit. Be sure to
/// create your own flutter_test_config.dart file in the test directory.
void main() {
  late JokesRepository jokesRepository;
  late DeviceBuilder builder;

  // setUp is called before every test executes.
  setUp(() {
    builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ]);

    jokesRepository = MockJokesRepository();
    serviceLocator.registerSingleton<JokesRepository>(jokesRepository);
  });

  // tearDown is called after every test executes.
  tearDown(() {
    serviceLocator.reset();
  });

  testGoldens('Should show categories on server success', (tester) async {
    when(() => jokesRepository.fetchCategories()).thenAnswer(
      (_) => Future.value(
        [
          'Beard Jokes',
          'Random Jokes',
        ],
      ),
    );

    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: const ChuckNorrisApplication(
        home: CategoriesScreen(),
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'categories_screen_loaded');
  });

  testGoldens('Should show error on server failure', (tester) async {
    when(() => jokesRepository.fetchCategories()).thenThrow(Error());

    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: const ChuckNorrisApplication(
        home: CategoriesScreen(),
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'categories_screen_error');
  });
}
