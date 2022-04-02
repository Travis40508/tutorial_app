import 'package:flutter/material.dart';
import 'package:tutorial_app/chuck_norris_application.dart';

void main() {
  _buildDependencyGraph();
  runApp(const ChuckNorrisApplication());
}

// This builds all of our objects at launch so we can just use them in the
// application. A dependency is just what it sounds like, anything an object
// requires in its constructor to be created.
void _buildDependencyGraph() {}
