import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/cartao.dart';

class PaymentProvider with ChangeNotifier {
  List<Cartao> _cartoes = [];

  List<Cartao> get getCartoes => [..._cartoes];

  void addCartao(Cartao cartao) {
    _cartoes.add(cartao);
    notifyListeners();
  }

  void deleteCartao(String id) {
    _cartoes.removeWhere((cartao) => cartao.idCartao == id);
    notifyListeners();
  }
}
