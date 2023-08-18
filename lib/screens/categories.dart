import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:mealapp/models/category.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/category_grid_item.dart';

class CategoriesScreenn extends StatefulWidget {
  const CategoriesScreenn(
      {super.key,
      // required this.onToggleFavorite,
      required this.availableMeals});

  // final Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreenn> createState() => _CategoriesScreennState();
}

class _CategoriesScreennState extends State<CategoriesScreenn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    super.initState();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          // onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(25),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: availableCategories
            .map((category) => CategoryGridItem(
                  category: category,
                  onSelectCategory: () => _selectCategory(context, category),
                ))
            .toList(),
        // ),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
