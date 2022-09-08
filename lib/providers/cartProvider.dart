import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';

class CartProvider with ChangeNotifier {
  List<Item> _items = [];
  List<Endereco> _enderecos = [];
  List<List<Item>> _pedidosFinalizados = [];
  int _quantity = 1;

  //getters
  List<Item> get items => [..._items];
  List<List<Item>> get compras => [..._pedidosFinalizados];

  int get quantity => _quantity;

  //Métodos referentes a finalização da compra
  void finalizarCompra(List<Item> _is) {
    _pedidosFinalizados.add(_is);
    _items.clear();
    notifyListeners();
  }

  //Métodos referentes ao carrinho
  void inc() {
    _quantity++;
    notifyListeners();
  }

  void dec() {
    if (_quantity > 0) {
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart(Item item) {
    if (_quantity >= 1) {
      _items.add(item);
      _quantity = 1;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double getTotal() {
    double tot = 0;
    _items.forEach((element) {
      tot += element.total;
    });
    return tot;
  }
}
