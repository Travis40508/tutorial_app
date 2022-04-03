import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/screens/categories/categories_cubit.dart';
import 'package:tutorial_app/screens/categories/categories_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<CategoriesCubit>(
        create: (_) => CategoriesCubit(),
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoadedState) {
              return Scaffold(
                // This is using the values from the theme object we set in our
                // application file.
                backgroundColor: theme.backgroundColor,
                appBar: AppBar(
                  backgroundColor: theme.primaryColor,
                  title: Text(
                    'Categories',
                    style: theme.textTheme.headline4,
                  ),
                ),
                body: ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    return Card(
                      elevation: 2.0,
                      child: Center(
                        child: Text(category),
                      ),
                    );
                  },
                ),
              );
            } else if (state is CategoriesLoadingState) {
              return Material(
                color: theme.backgroundColor,
                child: Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                ),
              );
            } else {
              return Material(
                child: Column(
                  children: [
                    const Text('Something went wrong. \nPlease try again.'),
                    ElevatedButton(
                      // context.read is just a way for Flutter to look up the
                      // widget tree, to find the cubit we're talking about.
                      onPressed: context.read<CategoriesCubit>().onTryAgain,
                      child: const Text(
                        'Try again',
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
