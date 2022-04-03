import 'package:tutorial_app/models/joke.dart';

// This is the contract we expect our server to uphold. No matter where we get
// our data, it needs to fulfill the responsibilities outlined here.

abstract class JokesService {
  Future<List<String>> fetchCategories();
  Future<Joke> fetchJokeByCategory({required String category});
}
