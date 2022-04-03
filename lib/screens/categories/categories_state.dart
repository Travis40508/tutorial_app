import 'package:equatable/equatable.dart';

// This is abstract because it isn't concrete. We just want all other
// states to know that they're SOME form of CategoriesState.
// Equatable is a library that changes how we view equality. For example, if
// we had an object final brenna1 = Human('Brenna');, and final brenna2 =
// Human('Brenna');, and then printed print(brenna1 == brenna2); it'd print
// 'false', because it bases their equality on their memory addresses, and they
// are not the same. With equatable, it bases the equality off of their values,
// so since brenna1 and brenna2 have the same values, print(brenna1 == brenna2)
// will print 'true'.
abstract class CategoriesState extends Equatable {}

class CategoriesLoadingState extends CategoriesState {
  @override
  // props are the properties of the objects you need to be the same for
  // the objects to be considered the same if they're equal to one another.
  // Since this is an empty object we don't care.
  List<Object?> get props => [];
}

class CategoriesLoadedState extends CategoriesState {
  final List<String> categories;

  CategoriesLoadedState({
    required this.categories,
  });

  @override
  List<Object?> get props => [
        // Now two instances of CategoriesLoadedState will be considered equal to
        // one another, so long as they have the same categories. Irrespective to
        // their addresses in memory.
        categories
      ];
}

class CategoriesErrorState extends CategoriesState {
  @override
  List<Object?> get props => [];
}
