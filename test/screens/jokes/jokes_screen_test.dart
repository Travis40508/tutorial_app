import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorial_app/chuck_norris_application.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/models/joke.dart';
import 'package:tutorial_app/screens/jokes/jokes_cubit.dart';
import 'package:tutorial_app/screens/jokes/jokes_screen.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

import '../../mocks.dart';

void main() {
  late JokesRepository jokesRepository;
  late DeviceBuilder builder;

  setUp(() {
    builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
      ]);

    jokesRepository = MockJokesRepository();
    serviceLocator.registerSingleton<JokesRepository>(jokesRepository);
  });

  tearDown(() {
    serviceLocator.reset(dispose: true);
  });

  testGoldens('Should show joke on server success', (tester) async {
    // 'any' just means, "we don't care, we just want you to respond accordingly
    // so that we know our UI looks appropriate given the potential perspective.
    when(
      () => jokesRepository.fetchJokeByCategory(
        category: any(named: 'category'),
      ),
    ).thenAnswer(
      (_) => Future.value(
        const Joke(
          jokeDescription:
              'Why did the chicken cross the road? To get to the other side!',
          jokeImage: '',
        ),
      ),
    );

    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: ChuckNorrisApplication(
        home: JokesScreen(
          cubit: JokesCubit(category: 'animals'),
        ),
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'joke_screen_loaded');
  });

  testGoldens('Should show joke error on server failure', (tester) async {
    when(
      () => jokesRepository.fetchJokeByCategory(
        category: any(named: 'category'),
      ),
    ).thenThrow(
      Error(),
    );

    builder.addScenario(
      // We want to wrap the widget we're testing with our application file
      // so that it is able to grab the theme we setup for it there.
      // Otherwise it'll have to use default values, i.e. blue.
      widget: ChuckNorrisApplication(
        home: JokesScreen(
          cubit: JokesCubit(category: 'cowboys'),
        ),
      ),
    );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'jokes_screen_error');
  });
}
