import 'package:deli_meals/dummy_data.dart';
import 'package:deli_meals/screens/categories_screen.dart';
import 'package:deli_meals/screens/category_meals_screen.dart';
import 'package:deli_meals/screens/filters_screen.dart';
import 'package:deli_meals/screens/meal_detail_screen.dart';
import 'package:deli_meals/screens/tabs_screen.dart';
import 'package:flutter/material.dart';

import 'models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtersData){
    setState(() {
      _filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree){
            return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),);
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.pink
        ),
        scaffoldBackgroundColor: Colors.white70,
        // primarySwatch: Colors.pink,
        primaryColor: Colors.pink,
        primaryColorDark: Colors.black54,
        primaryColorLight: Colors.orangeAccent,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyLarge: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleMedium: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', // default id '/'
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals: _favoriteMeals,),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(toggleFavorite: _toggleFavorite, isFavorite: _isMealFavorite,),
        FiltersScreen.routeName: (ctx) => FiltersScreen(currentFilter:_filters, saveFilters:_setFilters),
      },
      // onGenerateRoute: (settings){
      //   // print(settings.arguments);
      //   // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      // },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
    );
  }
}
