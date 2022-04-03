# tutorial_app
An app for teaching basic Flutter. This app tasks the dev to take on various challenges to practice their Flutter skills. It should be noted that _EACH_ of these challenges, no matter how seemingly trivial they may be,_MUST_ be created in their own separate project application. If there are 10 challenges, there should be 10 applications. Not 1 application thta does all 10. With programming repetition and practice is key so that the concepts begin to stick.

## Getting Started
For starters, run the application and get used to it, so that you may better understand the code that orders its various functions. Afterwards read the comments that attempt to explain the concepts that are going on and why the code was written the way it was.

### Challenge A (chuck_norris_jokes_service.dart)
Find an open API on the Internet. It doesn't matter which one, and make a Flutter app that hits that API and pulls data down and displays it in any manner.

### Challenge B (jokes_repository.dart)
Create your own interface, make at least two different classes implement its contract in different concrete ways. Make a stateless Widget expect an instance of your interface in its constructor, then play around with passing in both concrete implementations you made to see how the UI stays the same (or doesn't).

### Challenge C (main.dart)
Create your own dependency injection graph, and inject the objects you've provided here in various locations of an app and see how they can be used.

### Challenge D (categories_cubit.dart)
Create your own Cubit and implementation of the bloc pattern, making sure to build a widget with a [BlocProvider] in your own widget.

### Challenge E (categories_cubit_test.dart)
Write your own unit tests. Both with the [blocTest] library, and with what comes right out of the box in Flutter/Dart.

### Challenge F (mocks.dart)
Create your own mocks and see if you can use them to mock behavior in a unit test to return the results you need them to return to see if your code behaves the way you'd expect it to.

### Challenge G (chuck_norris_application.dart)
Create your own theme! It's fun.

### Challenge H (categories_state.dart)
Create your own objects, make them extend [Equatable], fill in their props, and then make 2 instances of that object and print if they are equal to one another, both with them extending [Equatable], and not.

### Challenge I (categories_screen_test.dart)
Create your own Golden tests. Being sure to follow the documentation here - https://pub.dev/packages/golden_toolkit. Be sure to create your own flutter_test_config.dart file in the test directory.
