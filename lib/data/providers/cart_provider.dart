import 'package:flutter/material.dart';
import '../../domain/models/cart_item_model.dart';
import '../../domain/models/menu_item_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItemModel> _cartItems = [];
  double _subtotal = 0;
  double _tax = 0.1;
  double _deliveryFee = 5.0;
  String _promoCode = '';
  double _discount = 0;

  List<CartItemModel> get cartItems => _cartItems;
  double get subtotal {
    _calculateSubtotal();
    return _subtotal;
  }

  double get tax => subtotal * _tax;
  double get deliveryFee => _deliveryFee;
  double get discount => _discount;
  double get total => subtotal + tax + deliveryFee - discount;
  String get promoCode => _promoCode;

  void addToCart(MenuItemModel menuItem, int quantity) {
    try {
      final existingItem = _cartItems.firstWhere(
        (item) => item.menuItem.id == menuItem.id,
      );
      existingItem.quantity += quantity;
    } catch (e) {
      _cartItems.add(
        CartItemModel(
          menuItem: menuItem,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.menuItem.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    try {
      final item = _cartItems.firstWhere((item) => item.menuItem.id == itemId);
      if (quantity > 0) {
        item.quantity = quantity;
      } else {
        removeFromCart(itemId);
      }
      notifyListeners();
    } catch (e) {
      // Item not found
    }
  }

  void _calculateSubtotal() {
    _subtotal = 0;
    for (var item in _cartItems) {
      _subtotal += item.menuItem.price * item.quantity;
    }
  }

  void applyCoupon(String code) {
    if (code.toUpperCase() == 'SAVE10') {
      _discount = subtotal * 0.1;
      _promoCode = code;
    } else if (code.toUpperCase() == 'SAVE20') {
      _discount = subtotal * 0.2;
      _promoCode = code;
    } else {
      _discount = 0;
      _promoCode = '';
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _promoCode = '';
    _discount = 0;
    notifyListeners();
  }

  int get cartCount => _cartItems.length;
  int get totalItems {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}