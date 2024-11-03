import '../widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen({super.key, required this.availableMeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeal;

  @override
  void initState() {

    super.initState();
  }

  //Checks if any state or data has been changed after filtering, and if it is, it will load them before build method
  @override
  void didChangeDependencies() {
      final routeArgs =
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId){
  //   setState(() {
  //     displayedMeal?.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal![index].id,
            title: displayedMeal![index].title,
            imageUrl: displayedMeal![index].imageUrl,
            duration: displayedMeal![index].duration,
            complexity: displayedMeal![index].complexity,
            affordability: displayedMeal![index].affordability,
          );
        },
        itemCount: displayedMeal!.length,
      ),
    );
  }
}
