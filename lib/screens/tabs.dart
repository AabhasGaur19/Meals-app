import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/favorite_provider.dart';
import 'package:mealsapp/providers/filter_provider.dart';
import 'package:mealsapp/providers/meals_provider.dart';
import 'package:mealsapp/screens/categories_screen.dart';
import 'package:mealsapp/screens/filter_screen.dart';
import 'package:mealsapp/screens/meals_screen.dart';
import 'package:mealsapp/widgets/drawer_main.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedpageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String indentifier) async {
    if (indentifier == 'filters') {
      Navigator.of(context).pop();
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen()));
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider); 
    final activeFilters = ref.watch(filtersProvider);

    final avaliableMeals = meals.where((item) {
      if(activeFilters[Filter.glutenFree]! && !item.isGlutenFree){
        return false;
      }
      if(activeFilters[Filter.lactoseFree]! && !item.isLactoseFree){
        return false;
      }
      if(activeFilters[Filter.vegan]! && !item.isVegan){
        return false;
      }
      if(activeFilters[Filter.vegetarian]! && !item.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(avaliableMeals: avaliableMeals);
    var activePageTitle = 'Categories';

    if (_selectedpageIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        title: '',
        meals: favMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedpageIndex,
        elevation: 7,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
