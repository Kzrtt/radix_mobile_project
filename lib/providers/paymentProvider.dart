import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/cartao.dart';
import 'package:radix_mobile_project/model/sharedPreferencesModels.dart';
import 'package:radix_mobile_project/utils/sharedPreferencesConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentProvider with ChangeNotifier {
  List<Cartao> _cartoes = [];
  List<Pagamentos> _cartoesSharedPreferences = [];

  List<Cartao> get getCartoes => [..._cartoes];
  List<Pagamentos> getCartoesSharedPreferences() => _cartoesSharedPreferences;

  Future<void> loadCartoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      if (loggedUserInfo.pagamentos != null) {
        _cartoesSharedPreferences = loggedUserInfo.pagamentos!;
      }
    }
  }

  void addCartao(Cartao cartao) async {
    _cartoes.add(cartao);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      Pagamentos pag = Pagamentos(
        idPagamento: cartao.idCartao,
        numeroCartao: cartao.numerosCartao,
        dataValidade: cartao.dataValidade,
        apelidoCartao: cartao.apelidoCartao,
        nomeTitular: cartao.nomeTitular,
        cvv: cartao.cvv,
      );
      _cartoesSharedPreferences.add(pag);
      loggedUserInfo.pagamentos = _cartoesSharedPreferences;
      prefs.setString(SharedPreferencesConstants.loggedUserInfos, json.encode(loggedUserInfo.toJson()));
    }
    notifyListeners();
  }

  void deleteCartao(int id) async {
    _cartoes.removeWhere((cartao) => cartao.idCartao == id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      _cartoesSharedPreferences.removeWhere((element) => element.idPagamento == id);
      loggedUserInfo.pagamentos = _cartoesSharedPreferences;
      prefs.setString(SharedPreferencesConstants.loggedUserInfos, json.encode(loggedUserInfo.toJson()));
    }
    notifyListeners();
  }
}
