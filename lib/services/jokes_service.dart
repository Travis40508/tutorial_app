import 'package:tutorial_app/models/joke.dart';

// This is the contract we expect our server to uphold. No matter where we get
// our data, it needs to fulfill the responsibilities outlined here. See
// [chuck_norris_jokes_service.dart] to see how it fulfills the service in its
// own way.
abstract class JokesService {
  Future<List<String>> fetchCategories();
  Future<Joke> fetchJokeByCategory({required String category});
}
