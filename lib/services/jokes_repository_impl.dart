import 'package:tutorial_app/models/joke.dart';
import 'package:tutorial_app/services/jokes_repository.dart';
import 'package:tutorial_app/services/jokes_service.dart';

class JokesRepositoryImpl implements JokesRepository {
  final JokesService jokesService;

  const JokesRepositoryImpl({
    required this.jokesService,
  });

  @override
  Future<List<String>> fetchCategories() async {
    return await jokesService.fetchCategories();
  }

  @override
  Future<Joke> fetchJokeByCategory({required String category}) {
    // TODO: implement fetchJokeByCategory
    throw UnimplementedError();
  }
}
