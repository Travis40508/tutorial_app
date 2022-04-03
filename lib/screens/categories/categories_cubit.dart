import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/main.dart';
import 'package:tutorial_app/screens/categories/categories_state.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

/// Challenge D - Create your own Cubit and implementation of the bloc pattern,
/// making sure to build a widget with a [BlocProvider] in your own widget.
class CategoriesCubit extends Cubit<CategoriesState> {
  // Now, thanks to our serviceLocator setup in main.dart, this will fetch
  // the JokesRepositoryImpl without even knowing it. It just knows it received
  // SOME class that upholds the JokesRepository contract.
  final jokesRepo = serviceLocator<JokesRepository>();

  // We have to pass into the super class with cubit the first state of our
  // screen. Naturally it's going to be loading, while it tries to pull the
  // data.
  CategoriesCubit() : super(CategoriesLoadingState()) {
    _loadCategories();
  }

  void _loadCategories() async {
    // Any time we tell the screen want categories we're going to need to show
    // a spinner. So it makes sense to just put it here while we get the data,
    // instead of every potential place that may call this method to reload
    // the categories.
    emit(CategoriesLoadingState());

    try {
      final categories = await jokesRepo.fetchCategories();
      emit(CategoriesLoadedState(categories: categories));
    } catch (e) {
      emit(CategoriesErrorState());
    }
  }

  void onTryAgain() => _loadCategories();
}
