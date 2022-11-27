// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/model/vendedor.dart';

class SalesmanProvider with ChangeNotifier {
  List<Vendedor> _vendedores = [];
  List<Vendedor> getVendedores() => [..._vendedores];

  Future<void> loadVendedores() async {
    _vendedores.clear();
    var response = await Dio().get('http://10.0.2.2:8000/api/getAllVendedores');

    var response2 = await Dio().get('http://10.0.2.2:8000/api/getEveryProduct');

    response.data['vendedores'].forEach(
      (e) {
        List<Produtos> _produtos = [];
        response2.data['products'].forEach(
          (p) {
            if (p['idVendedor'] == e['idVendedor']) {
              Produtos produto = Produtos(
                idProduto: p['idProduto'],
                nomeProduto: p['nomeProduto'],
                urlFoto: p['imagemProduto'],
                detalheProduto: p['detalheProduto'],
                preco: p['preco'],
                statusProduto: p['statusProduto'],
                idVendedor: p['idVendedor'],
              );
              if (produto.statusProduto == 1) {
                if (_produtos.any((element) => element.idProduto == produto.idProduto)) {
                  print('_');
                } else {
                  _produtos.add(produto);
                }
              }
            }
          },
        );

        Vendedor vendedor = Vendedor(
          idVendedor: e['idVendedor'],
          nomeVendedor: e['nomeVendedor'],
          cpfCnpjVendedor: e['cpfCnpj'],
          emailVendedor: e['emailVendedor'],
          senhaVendedor: e['senhaVendedor'],
          urlImagemVendedor: e['fotoPerfil'],
          enderecoVendedor: e['enderecoVendedor'],
          statusContaVendedor: e['statusConta'],
          selo: e['selo'],
          produtosVendedor: _produtos,
        );
        if (vendedor.statusContaVendedor == 1) {
          if (_vendedores.any((element) => element.idVendedor == vendedor.idVendedor)) {
            print('_');
          } else {
            _vendedores.add(vendedor);
          }
        }
      },
    );
    notifyListeners();
  }

  Future<Vendedor> getVendedor(int id) async {
    var response = await Dio().get('http://10.0.2.2:8000/api/getVendedor/$id');

    List<Produtos> _p = [];
    var response2 = await Dio().get('http://10.0.2.2:8000/api/getAllProdutos/$id');

    if (response2.data['status'] == '200') {
      response2.data['produtos'].forEach(
        (p) {
          Produtos produto = Produtos(
            idProduto: p['idProduto'],
            nomeProduto: p['nomeProduto'],
            urlFoto: p['imagemProduto'],
            detalheProduto: p['detalheProduto'],
            preco: p['preco'],
            statusProduto: p['statusProduto'],
            idVendedor: p['idVendedor'],
          );
          if (produto.statusProduto == 1) {
            if (_p.any((element) => element.idProduto == produto.idProduto)) {
              print('_');
            } else {
              _p.add(produto);
            }
          }
        },
      );
    }

    Vendedor vendedor = Vendedor(
      idVendedor: response.data['vendedor'][0]['idVendedor'],
      nomeVendedor: response.data['vendedor'][0]['nomeVendedor'],
      cpfCnpjVendedor: response.data['vendedor'][0]['cpfCnpj'],
      emailVendedor: response.data['vendedor'][0]['emailVendedor'],
      senhaVendedor: response.data['vendedor'][0]['senhaVendedor'],
      urlImagemVendedor: response.data['vendedor'][0]['fotoPerfil'],
      enderecoVendedor: response.data['vendedor'][0]['enderecoVendedor'],
      statusContaVendedor: response.data['vendedor'][0]['statusConta'],
      selo: response.data['vendedor'][0]['selo'],
      produtosVendedor: _p,
    );

    return vendedor;
  }

  Row seloProdutor(dynamic selo, BoxConstraints constraints, List<Produtos> _p) {
    Row row = Row(
      children: [
        Text(
          selo.toString(),
          style: const TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
        ),
        const Icon(Icons.eco_sharp, color: Colors.cyan),
      ],
    );

    if (_p.isEmpty) {
      row = Row(
        children: [
          Text(
            'novo produtor ',
            style: TextStyle(color: Colors.cyan, fontSize: constraints.maxHeight * .025),
          ),
          Image.asset('assets/images/semente.png', width: constraints.maxWidth * .05),
        ],
      );
    } else {
      if (0 < selo && selo <= 1) {
        row = Row(
          children: [
            Text(
              selo.toString(),
              style: TextStyle(color: Colors.red, fontSize: constraints.maxHeight * .025),
            ),
            Image.asset('assets/images/arvore-morta.png', width: constraints.maxWidth * .085),
          ],
        );
      } else if (1 < selo && selo <= 2) {
        row = Row(
          children: [
            Text(
              selo.toString(),
              style: TextStyle(color: Colors.yellow, fontSize: constraints.maxHeight * .025),
            ),
            Image.asset('assets/images/flor-morta.png', width: constraints.maxWidth * .1),
          ],
        );
      } else if (2 < selo && selo <= 3) {
        row = Row(
          children: [
            Text(
              selo.toString(),
              style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1), fontSize: constraints.maxHeight * .025),
            ),
            Image.asset('assets/images/folha.png', width: constraints.maxWidth * .1),
          ],
        );
      } else if (3 < selo && selo <= 4) {
        row = Row(
          children: [
            Text(
              selo.toString(),
              style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1), fontSize: constraints.maxHeight * .025),
            ),
            Image.asset('assets/images/tulip.png', width: constraints.maxWidth * .08),
          ],
        );
      } else if (4 < selo && selo <= 5) {
        row = Row(
          children: [
            Text(
              selo.toString(),
              style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1), fontSize: constraints.maxHeight * .025),
            ),
            Image.asset('assets/images/tree.png', width: constraints.maxWidth * .065),
          ],
        );
      }
    }

    return row;
  }

  Image iconSeloProdutor(dynamic selo, BoxConstraints constraints, bool x) {
    Image img = Image.asset('assets/images/tree.png', width: constraints.maxWidth * .08);

    if (x) {
      if (0 < selo && selo <= 1) {
        img = Image.asset('assets/images/arvore-morta.png', width: constraints.maxWidth * .08);
      } else if (1 < selo && selo <= 2) {
        img = Image.asset('assets/images/flor-morta.png', width: constraints.maxWidth * .08);
      } else if (2 < selo && selo <= 3) {
        img = Image.asset('assets/images/folha.png', width: constraints.maxWidth * .08);
      } else if (3 < selo && selo <= 4) {
        img = Image.asset('assets/images/tulip.png', width: constraints.maxWidth * .08);
      } else if (4 < selo && selo <= 5) {
        img = Image.asset('assets/images/tree.png', width: constraints.maxWidth * .05);
      }
    } else {
      img = Image.asset('assets/images/semente.png', width: constraints.maxWidth * .08);
    }

    return img;
  }
}
