import 'package:tutorial_app/services/jokes_service.dart';

// Here is the concrete application of our contract for JokesService. We're
// saying, "this class will uphold our contract, it will do everything we
// expect a server that brings us jokes to do."

class ChuckNorrisJokesService implements JokesService {}
