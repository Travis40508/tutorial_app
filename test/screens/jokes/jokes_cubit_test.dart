import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/models/joke.dart';
import 'package:tutorial_app/screens/jokes/jokes_cubit.dart';
import 'package:tutorial_app/screens/jokes/jokes_state.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

import '../../mocks.dart';

void main() {
  late JokesRepository jokesRepository;

  setUp(() {
    jokesRepository = MockJokesRepository();

    // We create mock versions of our objects, this way we can tell it,
    // "hypothetically, if our object did x, would our code behave the way
    // we'd expect in response?"
    serviceLocator.registerSingleton<JokesRepository>(jokesRepository);
  });

  tearDown(() {
    serviceLocator.reset();
  });

  blocTest<JokesCubit, JokesState>(
    'Should emit a joke on server success',
    setUp: () {
      when(
        () => jokesRepository.fetchJokeByCategory(
          category: any(named: 'category'),
        ),
      ).thenAnswer(
        (_) => Future.value(const Joke(
          jokeDescription:
              'Why did the chicken cross the road? To get to the other side!',
          jokeImage: '',
        )),
      );
    },
    build: () => JokesCubit(category: 'animals'),
    expect: () => [
      isA<JokesLoadedState>()
        ..having(
          (state) => state.jokes,
          'Jokes are as we expect',
          [
            // This test would fail if we were not using Equatable. Because the
            // two jokes would point to different locations in memory and would
            // return false when checking if they were the same (because it
            // bases equality on memory address. Now, thanks to Equatable, it is
            // based off of values of the object.
            const Joke(
              jokeDescription:
                  'Why did the chicken cross the road? To get to the other side!',
              jokeImage: '',
            ),
          ],
        ),
    ],
  );

  // Using a regular test for error scenarios, as blocTest doesn't seem
  // to handle them well.
  test('Should emit error state on server error', () async {
    when(
      () => jokesRepository.fetchJokeByCategory(
        category: any(named: 'category'),
      ),
    ).thenThrow(Error());
    final cubit = JokesCubit(category: 'animals');

    await pumpEventQueue();
    expect(cubit.state, JokesErrorState());
  });

  // This test has an action, where we call the Another! action. It also
  // verifies that the methods we'd expect to be called are called the right
  // amount of times. We called fetchJokeByCategory when we first got to the screen,
  // and when we tapped Another!.
  blocTest<JokesCubit, JokesState>(
    'Should load, then emit another joke after Another is tapped',
    setUp: () {
      when(
        () => jokesRepository.fetchJokeByCategory(
          category: any(named: 'category'),
        ),
      ).thenAnswer(
        (_) => Future.value(const Joke(
          jokeDescription:
              'Why did the chicken cross the road? To get to the other side!',
          jokeImage: '',
        )),
      );
    },
    build: () => JokesCubit(category: 'animals'),
    act: (cubit) => cubit.fetchJokeByCategory(),
    verify: (cubit) => verify(
      () => jokesRepository.fetchJokeByCategory(
        category: any(named: 'category'),
      ),
    ).called(2),
    expect: () => [
      isA<JokesLoadedState>()
        ..having(
          (state) => state.jokes,
          'Multiple Jokes are what we would expect them to be',
          [
            const Joke(
              jokeDescription:
                  'Why did the chicken cross the road? To get to the other side!',
              jokeImage: '',
            ),
            const Joke(
              jokeDescription:
                  'Why did the chicken cross the road? To get to the other side!',
              jokeImage: '',
            )
          ],
        ),
    ],
  );
}
