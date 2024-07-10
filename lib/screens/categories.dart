import 'package:flutter/material.dart';
import 'package:meal_app2/data/dummy_data.dart';
import 'package:meal_app2/screens/meals.dart';
import 'package:meal_app2/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;


  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals, onToggleFavorite:  onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            // Or we can use -> availableCategories.map((category) => CategoryGridItem(category: category,)
            for (final category in availableCategories)
              CategoryGridItem(
                  category: category,
                  onSelectedCategory: () {
                    _selectCategory(context, category);
                  })
          ]),
    );
  }
}
