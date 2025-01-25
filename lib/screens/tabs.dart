// import 'package:flutter/material.dart';
// import 'package:mealsapp/data/dummy_data.dart';
// import 'package:mealsapp/models/meal.dart';
// import 'package:mealsapp/screens/categories_screen.dart';
// import 'package:mealsapp/screens/filter_screen.dart';
// import 'package:mealsapp/screens/meals_screen.dart';
// import 'package:mealsapp/widgets/drawer_main.dart';

// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegan: false,
//   Filter.vegetarian: false,
// };

// class TabsScreen extends StatefulWidget {
//   const TabsScreen({super.key});

//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   int _selectedpageIndex = 0;
//   void _selectPage(int index) {
//     setState(() {
//       _selectedpageIndex = index;
//     });
//   }

//   Map<Filter, bool> _selectedFilters = {
//     Filter.glutenFree: false,
//     Filter.lactoseFree: false,
//     Filter.vegan: false,
//     Filter.vegetarian: false,
//   };

//   void _setScreen(String indentifier) async {
//     if (indentifier == 'filters') {
//       Navigator.of(context).pop();
//       final result = await Navigator.of(context).push<Map<Filter, bool>>(
//           MaterialPageRoute(builder: (ctx) => FilterScreen(currentFilter: _selectedFilters)));
//       setState(() {
//         _selectedFilters = result ?? kInitialFilters;
//       });
//     } else {
//       Navigator.of(context).pop();
//     }
//   }

//   final List<Meal> _favoriteMeals = [];
//   void _toggleMealFavoriteStatus(Meal meal) {
//     final isExisting = _favoriteMeals.contains(meal);

//     if (isExisting) {
//       setState(() {
//         _favoriteMeals.remove(meal);
//       });
//       _showinfoMsg('Meal is no longer favorite!');
//     } else {
//       setState(() {
//         _favoriteMeals.add(meal);
//       });
//       _showinfoMsg('Added to favorite');
//     }
//   }

//   void _showinfoMsg(String msg) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final avaliableMeals = dummyMeals.where((item) {
//       if(_selectedFilters[Filter.glutenFree]! && !item.isGlutenFree){
//         return false;
//       }
//       if(_selectedFilters[Filter.lactoseFree]! && !item.isLactoseFree){
//         return false;
//       }
//       if(_selectedFilters[Filter.vegan]! && !item.isVegan){
//         return false;
//       }
//       if(_selectedFilters[Filter.vegetarian]! && !item.isVegetarian){
//         return false;
//       }
//       return true;
//     }).toList();

//     Widget activePage = CategoriesScreen(onToogleFavorite: _toggleMealFavoriteStatus,avaliableMeals: avaliableMeals);
//     var activePageTitle = 'Categories';

//     if (_selectedpageIndex == 1) {
//       activePage = MealsScreen(
//         title: '',
//         meals: _favoriteMeals,
//         onToogleFavorite: _toggleMealFavoriteStatus,
//       );
//       activePageTitle = 'Your Favorites';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(activePageTitle),
//       ),
//       drawer: MainDrawer(onSelectScreen: _setScreen),
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selectPage,
//         currentIndex: _selectedpageIndex,
//         elevation: 7,
//         items: [
//           const BottomNavigationBarItem(
//               icon: Icon(Icons.set_meal), label: 'Categories'),
//           const BottomNavigationBarItem(
//               icon: Icon(Icons.star), label: 'Favorites'),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/data/dummy_data.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/providers/meals_provider.dart';
import 'package:mealsapp/screens/categories_screen.dart';
import 'package:mealsapp/screens/filter_screen.dart';
import 'package:mealsapp/screens/meals_screen.dart';
import 'package:mealsapp/widgets/drawer_main.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

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

  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegan: false,
    Filter.vegetarian: false,
  };

  void _setScreen(String indentifier) async {
    if (indentifier == 'filters') {
      Navigator.of(context).pop();
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen(currentFilter: _selectedFilters)));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  final List<Meal> _favoriteMeals = [];
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showinfoMsg('Meal is no longer favorite!');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showinfoMsg('Added to favorite');
    }
  }

  void _showinfoMsg(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avaliableMeals = dummyMeals.where((item) {
      if(_selectedFilters[Filter.glutenFree]! && !item.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !item.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !item.isVegan){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !item.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(onToogleFavorite: _toggleMealFavoriteStatus,avaliableMeals: avaliableMeals);
    var activePageTitle = 'Categories';

    if (_selectedpageIndex == 1) {
      activePage = MealsScreen(
        title: '',
        meals: _favoriteMeals,
        onToogleFavorite: _toggleMealFavoriteStatus,
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
