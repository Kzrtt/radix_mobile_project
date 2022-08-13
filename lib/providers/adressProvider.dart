import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/endereco.dart';

import 'clientProvider.dart';

class AdressProvider with ChangeNotifier {
  List<Endereco> _enderecos = [];
  List<Endereco> getEnderecos() => _enderecos;

  Future<void> loadEnderecos() async {
    var response =
        await Dio().get('http://localhost:8000/api/getAllEnderecos/1');
    response.data['enderecos'].forEach(
      (k, e) {
        Endereco endereco = Endereco(
          idEndereco: e['idEndereco'],
          apelidoEndereco: e['apelidoEndereco'],
          endereco: e['endereco'],
          complemento: e['complemento'],
          numero: e['numero'],
          statusEndereco: e['statusEndereco'],
        );
        if (endereco.statusEndereco == 1) {
          if (_enderecos
              .any((element) => element.idEndereco == endereco.idEndereco)) {
            print('_');
          } else {
            _enderecos.add(endereco);
          }
        }
      },
    );
  }

  Future<void> deleteAdress(int id) async {
    var response =
        await Dio().put('http://localhost:8000/api/deleteEndereco/$id');
    print(response.data.toString());

    _enderecos.removeWhere((element) => element.idEndereco == id);
    notifyListeners();
  }

  void createAdress(constraints, context, String apelido, String endereco,
      String complemento, String numero) async {
    try {
      var response = await Dio().post(
        'http://localhost:8000/api/inserirEndereco',
        data: {
          'apelidoEndereco': apelido,
          'endereco': endereco,
          'complemento': complemento,
          'numero': numero,
          'statusEndereco': 1,
          'idCliente': Provider.of<ClientProvider>(context, listen: false)
              .getUser
              .idCliente,
        },
      );
      if (response.data['status'] == '400') {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(response.data['message'],
                style: TextStyle(fontSize: constraints.maxWidth * .04)),
          ),
        );
      } else {
        print(response.data['message']);
        Endereco _endereco = Endereco(
          idEndereco: response.data['endereco']['idEndereco'] as int,
          apelidoEndereco: response.data['endereco']['apelidoEndereco'],
          endereco: response.data['endereco']['endereco'],
          complemento: response.data['endereco']['complemento'],
          numero: response.data['endereco']['numero'],
          statusEndereco: response.data['endereco']['statusEndereco'] as int,
        );
        _enderecos.add(_endereco);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
