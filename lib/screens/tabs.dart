import 'package:flutter/material.dart';
import 'package:mealapp/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/filters_provider.dart';
import 'package:mealapp/providers/meals_providers.dart';
import 'package:mealapp/screens/categories.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/main_drawer.dart';

const KIntialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filter, bool> _selectedFilters = KIntialFilters;

  // void _showInfoMessage(String message) {

  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer Favourite');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage("Marked as favorite");
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
      // setState(() {
      //   _selectedFilters = result ?? KIntialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealsref = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filtereddMealsProvider);

    Widget activePage = CategoriesScreenn(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favourite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourite'),
        ],
      ),
    );
  }
}
