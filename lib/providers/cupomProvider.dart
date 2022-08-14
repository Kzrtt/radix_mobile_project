// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:radix_mobile_project/model/cupom.dart';

class CupomProvider with ChangeNotifier {
  final List<Cupom> _cuponsCliente = [];
  List<Cupom> getCuponsCliente() => [..._cuponsCliente];

  Future<void> loadClientCupons(int id) async {
    _cuponsCliente.clear();
    List<Cupom> _allCupons = [];
    var response =
        await Dio().get('http://localhost:8000/api/getClienteCupoms/$id');
    if (response.data['status'] == '200') {
      response.data['allCupons'].forEach(
        (e) {
          Cupom cupom = Cupom(
            detalheCupom: e['detalheCupom'],
            idCupom: e['idCupom'],
            tituloCupom: e['nomeCupom'],
            dtInicio: e['dtInicio'],
            dtFim: e['dtFim'],
          );

          DateTime dtVencimento = DateFormat('yyyy-MM-dd').parse(cupom.dtFim);
          if (dtVencimento.isAfter(DateTime.now())) {
            _allCupons.add(cupom);
          }
        },
      );
      response.data['cupons'].forEach(
        (k, x) {
          _allCupons.forEach(
            (element) {
              if (element.idCupom == x['idCupom'] && x['usado'] == 0) {
                if (_cuponsCliente.any((y) => y.idCupom == x['idCupom'])) {
                  print('_');
                } else {
                  _cuponsCliente.add(element);
                  print(_cuponsCliente[0].tituloCupom);
                }
              }
            },
          );
        },
      );
    } else {
      print(response.data['message'].toString());
    }
    notifyListeners();
  }
}
