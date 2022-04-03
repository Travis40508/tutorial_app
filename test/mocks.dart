import 'package:mocktail/mocktail.dart';
import 'package:tutorial_app/services/jokes_repository.dart';

/// Challenge F - Create your own mocks and see if you can use them to mock
/// behavior in a unit test to return the results you need them to return
/// to see if your code behaves the way you'd expect it to.

// This allows us to create mock versions of objects so we can create mock
// behavior for our tests. "When this is called, return this. Now let's see
// if my code works the way I think it should when this happens."
class MockJokesRepository extends Mock implements JokesRepository {}
