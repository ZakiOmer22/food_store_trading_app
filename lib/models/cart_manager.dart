import 'package:flutter/material.dart';

/// Singleton class to manage shopping cart state.
class CartManager extends ChangeNotifier {
  // ---- Singleton Setup ----
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  // ---- Cart Items ----
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  // ---- Core Methods ----
  void addItem(
    Map map, {
    required String id,
    required String name,
    required String image,
    required double price,
  }) {
    final index = _items.indexWhere((item) => item['id'] == id);
    if (index >= 0) {
      _items[index]['quantity'] += 1;
    } else {
      _items.add({
        'id': id,
        'name': name,
        'image': image,
        'price': price,
        'quantity': 1,
      });
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item['id'] == productId);
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    final index = _items.indexWhere((item) => item['id'] == productId);
    if (index >= 0) {
      if (_items[index]['quantity'] > 1) {
        _items[index]['quantity'] -= 1;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ---- Getters ----
  int get totalItems =>
      _items.fold(0, (sum, item) => sum + (item['quantity'] as int));

  double get totalPrice => _items.fold(
    0.0,
    (sum, item) =>
        sum + ((item['price'] as double) * (item['quantity'] as int)),
  );

  get savings => null;
}
