import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:tutorial_app/models/joke.dart';
import 'package:tutorial_app/services/jokes_service.dart';

// Here is the concrete application of our contract for JokesService. We're
// saying, "this class will uphold our contract, it will do everything we
// expect a server that brings us jokes to do."

class ChuckNorrisJokesService implements JokesService {
  final client = Client();
  final baseUrl = 'https://api.chucknorris.io/jokes';

  @override
  Future<List<String>> fetchCategories() async {
    final url = '$baseUrl/categories';
    final response = await client.get(Uri.parse(url));

    final responseAsJson = jsonDecode(response.body);

    // You can see the data that's returned from this URL if you just go to
    // your browser and paste https://api.chucknorris.io/jokes/categories
    // As you can see, it's a list of Strings, so I told it to expect it
    // would be. This is ugly as hell, but the server returns an array of
    // strings, and the code doesn't believe me, so I'm just like, 'fine,
    // take the thing you do get, and wrap it in a string'. It's already a
    // string, but it makes the app shut up.
    return (responseAsJson as List).map((category) => '$category').toList(
          growable: false,
        );
  }

  @override
  Future<Joke> fetchJokeByCategory({required String category}) async {
    return const Joke(jokeDescription: 'hi', jokeImage: 'hi');
  }
}
