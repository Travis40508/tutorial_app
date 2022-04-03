import 'package:flutter/material.dart';
import 'package:tutorial_app/screens/categories/categories_screen.dart';
import 'package:tutorial_app/screens/jokes/jokes_screen.dart';

class ChuckNorrisApplication extends StatelessWidget {
  final Widget? home;

  // visibleForTesting means this can only be accessed in a test file, since
  // it's just here to facilitate testing. home is only used so that we can
  // properly draw goldens with the theme of our Application file, see
  // [golden_test_utils.dart].
  const ChuckNorrisApplication({
    Key? key,
    @visibleForTesting this.home,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline4: TextStyle(
            color: Colors.white,
          ),
          headline5: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        // A lot of people here want to use routes like '/home', but this isn't
        // a good practice, as what's considered 'home' can change. It's better
        // to be descriptive about all variable names, including routes.
        '/categories': (_) => const CategoriesScreen(),
        '/jokes': (_) => const JokesScreen(),
      },
      // The first screen our app will launch to.
      // If home isn't null, since we know it's only for testing we should just
      // go there, instead.
      initialRoute: home != null ? null : '/categories',
      home: home,
    );
  }
}
