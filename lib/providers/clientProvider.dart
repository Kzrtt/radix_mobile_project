import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/cliente.dart';
import 'package:radix_mobile_project/model/sharedPreferencesModels.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import 'package:radix_mobile_project/utils/sharedPreferencesConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/dummyData.dart';

class ClientProvider with ChangeNotifier {
  List<Cliente> _clientes = DUMMY_CLIENTS;
  List<Vendedor> _vendedoresFavoritos = [];
  List<Favoritos> _vendedoresFav = [];
  Cliente user = Cliente(
    idCliente: 0,
    nomeCliente: 'nomeCliente',
    cpfCliente: 'cpfCliente',
    emailCliente: 'emailCliente',
    senhaCliente: 'senhaCliente',
  );

  List<Cliente> get getClientes => [..._clientes];
  List<Vendedor> get getVendedoresFavoritos => [..._vendedoresFavoritos];
  Cliente get getUser => user;
  List<Favoritos> getVendedoresFav() => _vendedoresFav;

  Future<void> loadVendedoresFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      if (loggedUserInfo.favorito != null) {
        _vendedoresFav = loggedUserInfo.favorito!;
      }
    }
  }

  void changeUser(Cliente newUser) {
    user = newUser;
    notifyListeners();
  }

  void userLogoff() async {
    user = Cliente(
      idCliente: 0,
      nomeCliente: 'nomeCliente',
      cpfCliente: 'cpfCliente',
      emailCliente: 'emailCliente',
      senhaCliente: 'senhaCliente',
    );
    notifyListeners();
  }

  bool isFavorite(Vendedor vendedor) {
    return _vendedoresFav.any((element) => element.idVendedor == vendedor.idVendedor);
  }

  void addToFavorites(Vendedor vendedor) async {
    _vendedoresFavoritos.add(vendedor);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      Favoritos fav = Favoritos(
        idVendedor: vendedor.idVendedor,
        nomeVendedor: vendedor.nomeVendedor,
        cpfCnpjVendedor: vendedor.cpfCnpjVendedor,
        emailVendedor: vendedor.emailVendedor,
        senhaVendedor: vendedor.senhaVendedor,
        urlImagenVendedor: vendedor.urlImagemVendedor,
        enderecoVendedor: vendedor.enderecoVendedor,
        statusContaVendedor: vendedor.statusContaVendedor,
        selo: vendedor.selo,
        hasProducts: vendedor.produtosVendedor.isNotEmpty ? true : false,
      );
      _vendedoresFav.add(fav);
      loggedUserInfo.favorito = _vendedoresFav;
      prefs.setString(SharedPreferencesConstants.loggedUserInfos, json.encode(loggedUserInfo.toJson()));
    }
    notifyListeners();
  }

  void removeFromFavorites(String id) async {
    _vendedoresFavoritos.removeWhere((element) => element.idVendedor.toString() == id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
    if (tempString != null) {
      LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
      _vendedoresFav.removeWhere((element) => element.idVendedor.toString() == id);
      loggedUserInfo.favorito = _vendedoresFav;
      prefs.setString(SharedPreferencesConstants.loggedUserInfos, json.encode(loggedUserInfo.toJson()));
    }
    notifyListeners();
  }
}
