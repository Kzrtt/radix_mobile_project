import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/model/iten.dart';

import '../model/pedido.dart';

class PedidoProvider with ChangeNotifier {
  List<Pedido> _pedidos = [];
  List<Iten> _items = [];
  List<Pedido> getPedidos() => [..._pedidos];
  List<Iten> getItems() => [..._items];

  Future<List<Iten>> loadItems(int idPedido) async {
    _items.clear();
    var response = await Dio().get('http://localhost:8000/api/getAllItems/$idPedido');

    if (response.data['status'] == '200') {
      response.data['items'].forEach((k, i) {
        Iten item = Iten(
          idItem: i['idItem'],
          qntdItem: i['qntdItem'],
          idPedido: i['idPedido'],
          idProduto: i['idProduto'],
        );

        if (_items.any((element) => element.idItem == item.idItem)) {
          print('_');
        } else {
          _items.add(item);
        }
      });
    } else {
      print(response.data['message'].toString());
    }
    notifyListeners();
    return _items;
  }

  Future<void> loadPedidos(int idCliente) async {
    _pedidos.clear();
    var response = await Dio().get('http://localhost:8000/api/getAllPedidos/$idCliente');

    if (response.data['status'] == '200') {
      response.data['pedidos'].forEach(
        (p) {
          Pedido pedido = Pedido(
            idPedido: p['idPedido'],
            data: p['dataPedido'],
            frete: p['frete'],
            idCliente: p['idCliente'],
            idVendedor: p['idVendedor'],
            idCupomCliente: p['idCupomCliente'],
            idEntregador: p['idEntregador'],
          );

          if (_pedidos.any((element) => element.idPedido == pedido.idPedido)) {
            print('_');
          } else {
            _pedidos.add(pedido);
          }
        },
      );
    } else {
      print(response.data['message'].toString());
    }
    notifyListeners();
  }

  Future<void> loadPedidosItems() async {
    if (_pedidos.isNotEmpty) {
      for (var item in _pedidos) {
        var response = await Dio().get('http://localhost:8000/api/getAllItems/${item.idPedido}');

        if (response.data['200']) {
          response.data['items'].forEach(
            (k, e) {
              Iten item = Iten(
                idItem: e['idItem'],
                qntdItem: e['qntdItem'],
                idPedido: e['idPedido'],
                idProduto: e['idProduto'],
              );

              if (_items.any((element) => element.idItem == item.idItem)) {
                print('_');
              } else {
                _items.add(item);
              }
            },
          );
        } else {
          print(response.data['message'].toString());
        }
      }
    }
  }
}
