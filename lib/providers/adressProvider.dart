import 'package:flutter/material.dart';
import 'package:radix_mobile_project/model/endereco.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/endereco.dart';

import 'clientProvider.dart';

class AdressProvider with ChangeNotifier {
  List<Endereco> _enderecos = [];

  void setEnderecos(List<Endereco> newEnderecos) {
    _enderecos = newEnderecos;
    notifyListeners();
  }

  List<Endereco> getEnderecos() => _enderecos;
}
