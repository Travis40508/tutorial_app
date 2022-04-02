import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // This is using the values from the theme object we set in our
      // application file.
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'Test',
          style: theme.textTheme.headline4,
        ),
      ),
    );
  }
}
