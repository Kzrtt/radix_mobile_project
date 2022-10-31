import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/model/iten.dart';
import 'package:radix_mobile_project/model/produtos.dart';

import '../model/pedido.dart';

class PedidoProvider with ChangeNotifier {
  List<Pedido> _pedidos = [];
  List<Iten> _items = [];
  List<Produtos> _produtos = [];
  List<Pedido> getPedidos() => [..._pedidos];
  List<Iten> getItems() => [..._items];
  List<Produtos> getProdutos() => [..._produtos];

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

  Future<List<Pedido>> loadPedidos(int idCliente) async {
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
    return _pedidos;
  }

  Future<List<Iten>> loadPedidosItems(int idPedido) async {
    List<Iten> _x = [];
    var response = await Dio().get('http://localhost:8000/api/getAllItems/$idPedido');

    if (response.data['status'] == '200') {
      response.data['items'].forEach(
        (e) {
          Iten item = Iten(
            idItem: e['idItem'],
            qntdItem: e['qntdItem'],
            idPedido: e['idPedido'],
            idProduto: e['idProduto'],
          );

          if (_x.any((element) => element.idItem == item.idItem)) {
            print('_');
          } else {
            _x.add(item);
          }
        },
      );
    } else {
      print(response.data['message'].toString());
    }
    return _x;
  }

  Future<void> loadAllProdutos() async {
    var response = await Dio().get('http://localhost:8000/api/getEveryProduct');

    response.data['products'].forEach((e) {
      Produtos produto = Produtos(
        idProduto: e['idProduto'],
        nomeProduto: e['nomeProduto'],
        urlFoto: e['imagemProduto'],
        detalheProduto: e['detalheProduto'],
        preco: e['preco'],
        statusProduto: e['statusProduto'],
        idVendedor: e['idVendedor'],
      );

      if (_produtos.any((element) => element.idProduto == produto.idProduto)) {
        print('_');
      } else {
        _produtos.add(produto);
      }
    });
    notifyListeners();
  }

  Future<Produtos> loadProduto(int idProduto) async {
    var response = await Dio().get('http://localhost:8000/api/getProduto/$idProduto');

    Produtos produto = Produtos(
      idProduto: response.data['produto']['idProduto'],
      nomeProduto: response.data['produto']['nomeProduto'],
      urlFoto: response.data['produto']['imagemProduto'],
      detalheProduto: response.data['produto']['detalheProduto'],
      preco: response.data['produto']['preco'],
      statusProduto: response.data['produto']['statusProduto'],
      idVendedor: response.data['produto']['idVendedor'],
    );

    return produto;
  }
}
