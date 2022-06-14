import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';

class CartProvider with ChangeNotifier {
  List<Item> _items = [];
  int _quantity = 1;
  List<Endereco> _enderecos = [];

  //getters
  List<Item> get items => [..._items];
  int get quantity => _quantity;

  //Métodos para criar um endereço principal
  /*
  void toggleEnderecoPrincipal(List<Endereco> _e, Endereco _e1) {
    if (_e.any((element) => element.isEnderecoPrincipal == true)) {
      Endereco temp = _e.where((element) => element.isEnderecoPrincipal == true)
          as Endereco;
      temp.isEnderecoPrincipal == false;
      _e1.isEnderecoPrincipal == true;
      notifyListeners();
    } else {
      _e1.isEnderecoPrincipal == true;
      notifyListeners();
    }
  }

  Endereco getEnderecoPrincipal(List<Endereco> enderecos) {
    return enderecos
        .singleWhere((element) => element.isEnderecoPrincipal == true);
  }

  bool isPrimaryAdress(Endereco e) {
    return e.isEnderecoPrincipal;
  }
  */

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
}
