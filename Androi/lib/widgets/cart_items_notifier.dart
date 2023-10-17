import 'package:badmintonbuddy/screens/court_list.dart';
import 'package:flutter/material.dart';

class CartItemsNotifier extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

}
