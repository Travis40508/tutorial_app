import 'package:tutorial_app/screens/categories/categories_screen.dart';

import '../golden_test_utils.dart';

void main() {
  testGoldensForPhones(
    description: 'Categories Initial Screen',
    widgetToTest: const CategoriesScreen(),
    fileName: 'categories_screen',
  );
}
