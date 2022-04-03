import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/screens/categories/categories_cubit.dart';
import 'package:tutorial_app/screens/categories/categories_state.dart';
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

  blocTest<CategoriesCubit, CategoriesState>(
    'Should emit a list of categories on server success',
    setUp: () {
      when(() => jokesRepository.fetchCategories()).thenAnswer(
        (_) => Future.value(
          [
            'Beard Jokes',
            'Random Jokes',
          ],
        ),
      );
    },
    build: () => CategoriesCubit(),
    expect: () => [
      isA<CategoriesLoadedState>()
        ..having(
          (state) => state.categories,
          'Categories are what we expect them to be',
          [
            'Beard Jokes',
            'Random Jokes',
          ],
        ),
    ],
  );

  // Using a regular test for error scenarios, as blocTest doesn't seem
  // to handle them well.
  test('Should emit error state on server error', () async {
    when(() => jokesRepository.fetchCategories()).thenThrow(Error());
    final cubit = CategoriesCubit();

    await pumpEventQueue();
    expect(cubit.state, CategoriesErrorState());
  });

  // This test has an action, where we call the tryAgain action. It also
  // verifies that the methods we'd expect to be called are called the right
  // amount of times. We called fetchCategories when we first got to the screen,
  // and when we tapped tryAgain.
  blocTest<CategoriesCubit, CategoriesState>(
    'Should load, then emit a list of categories when try again is tapped',
    setUp: () {
      when(() => jokesRepository.fetchCategories()).thenAnswer(
        (_) => Future.value(
          [
            'Beard Jokes',
            'Random Jokes',
          ],
        ),
      );
    },
    build: () => CategoriesCubit(),
    act: (cubit) => cubit.onTryAgain(),
    verify: (cubit) => verify(jokesRepository.fetchCategories).called(2),
    expect: () => [
      isA<CategoriesLoadedState>()
        ..having(
          (state) => state.categories,
          'Categories are what we expect them to be',
          [
            'Beard Jokes',
            'Random Jokes',
          ],
        ),
    ],
  );
}
