import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/screens/jokes/jokes_cubit.dart';
import 'package:tutorial_app/screens/jokes/jokes_state.dart';
import 'package:tutorial_app/widgets/error_widget.dart';
import 'package:tutorial_app/widgets/loading_widget.dart';

class JokesScreen extends StatelessWidget {
  final JokesCubit? cubit;

  // Here we're passing in a cubit ONLY to help with testing. Hence the prefix.
  // We have no way in a test to actually get the value of a route, so we just
  // pass in a mock cubit with the value hard-coded.
  const JokesScreen({
    Key? key,
    @visibleForTesting this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider<JokesCubit>(
      create: (_) =>
          cubit ??
          JokesCubit(
            category: ModalRoute.of(context)?.settings.arguments as String,
          ),
      child: BlocBuilder<JokesCubit, JokesState>(
        builder: (context, state) {
          if (state is JokesLoadedState) {
            return Scaffold(
              backgroundColor: theme.backgroundColor,
              appBar: AppBar(
                backgroundColor: theme.primaryColor,
                title: Text(
                  state.category,
                  style: theme.textTheme.headline4,
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: context.read<JokesCubit>().fetchJokeByCategory,
                      child: Text(
                        'Another!',
                        style: theme.textTheme.headline5,
                      ),
                    ),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: state.jokes.length,
                itemBuilder: (context, index) {
                  final joke = state.jokes[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 2.0,
                      child: ListTile(
                        // If cubit, which we know we're only using for testing
                        // is not null, it means that this is coming from a test,
                        // CachedNetworkImageProvider makes a network call to load
                        // the image, but you can't make network calls in tests,
                        // or it will fail. So we just show an empty container
                        // for the image if we're coming from a golden test.
                        leading: cubit != null
                            ? Container(
                                height: 50.0,
                                color: theme.primaryColor,
                              )
                            : Image(
                                image:
                                    CachedNetworkImageProvider(joke.jokeImage),
                              ),
                        title: Text(joke.jokeDescription),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is JokesLoadingState) {
            return const LoadingWidget();
          } else {
            return ErrorLoadingWidget(
              onPressed: context.read<JokesCubit>().fetchJokeByCategory,
              errorMessage:
                  'Failed to load.\nLet\'s try starting from scratch!',
              buttonText: 'Try Again',
            );
          }
        },
      ),
    );
  }
}
