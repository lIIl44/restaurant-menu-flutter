import 'package:flutter/material.dart';
import '../../domain/models/menu_item_model.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuItemModel> _menuItems = [];
  List<MenuItemModel> _filteredMenuItems = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  List<MenuItemModel> _favorites = [];

  List<MenuItemModel> get menuItems => _filteredMenuItems;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  List<MenuItemModel> get favorites => _favorites;

  MenuProvider() {
    _initializeMenuItems();
    _loadCategories();
  }

  void _initializeMenuItems() {
    _menuItems = [
      MenuItemModel(
        id: '1',
        name: 'Grilled Salmon',
        description: 'Fresh Atlantic salmon with lemon and herbs',
        price: 24.99,
        category: 'Main Course',
        imageUrl: 'https://via.placeholder.com/300x200?text=Salmon',
        rating: 4.8,
        reviews: 152,
        isVegan: false,
        prepTime: '20 mins',
      ),
      MenuItemModel(
        id: '2',
        name: 'Caesar Salad',
        description: 'Crisp romaine lettuce with parmesan and croutons',
        price: 12.99,
        category: 'Salads',
        imageUrl: 'https://via.placeholder.com/300x200?text=Caesar+Salad',
        rating: 4.5,
        reviews: 98,
        isVegan: false,
        prepTime: '10 mins',
      ),
      MenuItemModel(
        id: '3',
        name: 'Margherita Pizza',
        description: 'Classic pizza with fresh basil, mozzarella, and tomato',
        price: 16.99,
        category: 'Pizza',
        imageUrl: 'https://via.placeholder.com/300x200?text=Margherita+Pizza',
        rating: 4.7,
        reviews: 210,
        isVegan: true,
        prepTime: '15 mins',
      ),
      MenuItemModel(
        id: '4',
        name: 'Chocolate Cake',
        description: 'Rich dark chocolate cake with cream frosting',
        price: 8.99,
        category: 'Desserts',
        imageUrl: 'https://via.placeholder.com/300x200?text=Chocolate+Cake',
        rating: 4.9,
        reviews: 340,
        isVegan: false,
        prepTime: '5 mins',
      ),
      MenuItemModel(
        id: '5',
        name: 'Fresh Orange Juice',
        description: 'Freshly squeezed orange juice',
        price: 5.99,
        category: 'Beverages',
        imageUrl: 'https://via.placeholder.com/300x200?text=Orange+Juice',
        rating: 4.6,
        reviews: 125,
        isVegan: true,
        prepTime: '2 mins',
      ),
      MenuItemModel(
        id: '6',
        name: 'Ribeye Steak',
        description: 'Prime cut ribeye steak with garlic butter',
        price: 32.99,
        category: 'Main Course',
        imageUrl: 'https://via.placeholder.com/300x200?text=Ribeye+Steak',
        rating: 4.9,
        reviews: 280,
        isVegan: false,
        prepTime: '25 mins',
      ),
    ];
    _applyFilters();
  }

  void _loadCategories() {
    _categories = ['All'];
    for (var item in _menuItems) {
      if (!_categories.contains(item.category)) {
        _categories.add(item.category);
      }
    }
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredMenuItems = _menuItems.where((item) {
      bool categoryMatch =
          _selectedCategory == 'All' || item.category == _selectedCategory;
      bool searchMatch = _searchQuery.isEmpty ||
          item.name.toLowerCase().contains(_searchQuery) ||
          item.description.toLowerCase().contains(_searchQuery);
      return categoryMatch && searchMatch;
    }).toList();
  }

  void toggleFavorite(MenuItemModel item) {
    if (_favorites.contains(item)) {
      _favorites.remove(item);
    } else {
      _favorites.add(item);
    }
    notifyListeners();
  }

  bool isFavorite(MenuItemModel item) {
    return _favorites.contains(item);
  }
}