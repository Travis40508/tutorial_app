import 'package:equatable/equatable.dart';
import 'package:tutorial_app/models/joke.dart';

abstract class JokesState extends Equatable {}

class JokesLoadedState extends JokesState {
  final String category;
  final List<Joke> jokes;

  JokesLoadedState({
    required this.category,
    required this.jokes,
  });

  @override
  List<Object?> get props => [
        category,
        jokes,
      ];
}

class JokesLoadingState extends JokesState {
  @override
  List<Object?> get props => [];
}

class JokesErrorState extends JokesState {
  @override
  List<Object?> get props => [];
}
