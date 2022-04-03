import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/models/joke.dart';
import 'package:tutorial_app/screens/jokes/jokes_state.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

class JokesCubit extends Cubit<JokesState> {
  final jokesRepository = serviceLocator<JokesRepository>();
  final String category;

  JokesCubit({required this.category}) : super(JokesLoadingState()) {
    fetchJokeByCategory();
  }

  void fetchJokeByCategory() async {
    emit(JokesLoadingState());

    try {
      final joke =
          await jokesRepository.fetchJokeByCategory(category: category);
      _addJoke(joke: joke);
    } catch (e) {
      emit(JokesErrorState());
    }
  }

  void _addJoke({required Joke joke}) {
    final jokes = <Joke>[];
    final currentState = state;

    // This way we keep the jokes we've got going on currently on the screen.
    if (currentState is JokesLoadedState) {
      jokes.addAll(currentState.jokes);
    }
    jokes.add(joke);

    emit(
      JokesLoadedState(
        jokes: jokes,
        category: category,
      ),
    );
  }
}
