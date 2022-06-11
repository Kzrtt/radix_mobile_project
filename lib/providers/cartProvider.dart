import 'package:flutter/material.dart';
import 'package:radix_mobile_project/model/item.dart';

class CartProvider with ChangeNotifier {
  List<Item> _items = [];
  int _quantity = 1;

  List<Item> get items => [..._items];
  int get quantity => _quantity;

  //Métodos referentes ao carrinho
  void inc() {
    _quantity++;
    notifyListeners();
  }

  void dec() {
    _quantity--;
    notifyListeners();
  }

  void addToCart(Item item) {
    _items.add(item);
    _quantity = 1;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
