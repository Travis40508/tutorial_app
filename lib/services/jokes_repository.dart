import 'package:tutorial_app/models/joke.dart';

// This is our contract for our class that gets jokes. We don't need everything
// a server returns. For example, this server returns an id that we couldn't
// care less about. There's only certain things the app NEEDS. Those things
// will be highlighted in this contract. All the app cares about is that SOME
// class that adheres to this contract is used to fetch the data, and give us
// the data necessary for the app to work properly. That way if we ever needed
// to swap the chuck norris api out for another one, the app would continue to
// work seamlessly.

abstract class JokesRepository {
  Future<Joke> fetchJokeByCategory({required String category});
  Future<List<String>> fetchCategories();
}
