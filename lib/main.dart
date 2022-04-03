import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tutorial_app/chuck_norris_application.dart';
import 'package:tutorial_app/services/chuck_norris_jokes_service.dart';
import 'package:tutorial_app/services/jokes_repository.dart';
import 'package:tutorial_app/services/jokes_repository_impl.dart';
import 'package:tutorial_app/services/jokes_service.dart';

// This will locate our objects for us as-needed.
GetIt serviceLocator = GetIt.instance;

void main() {
  _buildDependencyGraph();
  runApp(const ChuckNorrisApplication());
}

/// Challenge C - Create your own dependency injection graph, and inject the
/// objects you've provided here in various locations of an app and see how
/// they can be used.

// This builds all of our objects at launch so we can just use them in the
// application. A dependency is just what it sounds like, anything an object
// requires in its constructor to be created.
void _buildDependencyGraph() {
  // This is how we're objects will be provided. This way, any time something
  // asks for SOMETHING that upholds the jokes service contract, it will return
  // the ChuckNorrisJokes implementation. So the jokes service that's building
  // the JokesRepoImpl is the ChuckNorrisOne, but the JokesRepoImpl doesn't
  // know this, it just knows it's SOME service that upholds the JokesService
  // contract. This is how you make code scalable. Now, if our chuck norris
  // api ever died, we could literally replace it in this one line, by telling
  // our app that instead of using the ChuckNorrisJokesService, to use another
  // and every thing else in our app would work the same.
  serviceLocator
    ..registerSingleton<JokesService>(ChuckNorrisJokesService())
    ..registerSingleton<JokesRepository>(
      JokesRepositoryImpl(
        jokesService: serviceLocator<JokesService>(),
      ),
    );
}
