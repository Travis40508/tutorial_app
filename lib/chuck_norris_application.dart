import 'package:flutter/material.dart';
import 'package:tutorial_app/screens/categories/categories_screen.dart';
import 'package:tutorial_app/screens/jokes/jokes_screen.dart';

class ChuckNorrisApplication extends StatelessWidget {
  const ChuckNorrisApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green,
        backgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline4: TextStyle(
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
      initialRoute: '/categories',
    );
  }
}
