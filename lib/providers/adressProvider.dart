import 'package:flutter/material.dart';
import 'package:radix_mobile_project/model/endereco.dart';

class AdressProvider with ChangeNotifier {
  List<Endereco> _adress = [];

  List<Endereco> get getAdress => [..._adress];

  void addAdress(Endereco endereco) {
    _adress.add(endereco);
    notifyListeners();
  }

  void deleteAdress(String id) {
    _adress.removeWhere((adress) => adress.idEndereco == id);
    notifyListeners();
  }
}
