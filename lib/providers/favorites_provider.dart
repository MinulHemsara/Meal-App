import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
