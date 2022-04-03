// This will be the object our contract expects to be created, regardless of
// which server we get the data, for our app to function, it will always need
// to create an object that has both an image for our joke, and the joke-itself.

class Joke {
  final String joke;
  final String jokeImage;

  const Joke({
    required this.joke,
    required this.jokeImage,
  });
}
