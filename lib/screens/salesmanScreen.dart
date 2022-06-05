// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/salesmanTile.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import '../data/dummyData.dart';

class SalesmanScreen extends StatefulWidget {
  @override
  State<SalesmanScreen> createState() => _SalesmanScreen();
}

class _SalesmanScreen extends State<SalesmanScreen> {
  int _currentIndex = 1;
  int _productQuantity = 1;

  void _openProductModalSheet(BuildContext context, Produtos produto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .60,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(132, 202, 157, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * .1),
                      Text(
                        produto.nomeProduto,
                        style: TextStyle(fontSize: constraints.maxHeight * .05, color: Colors.white),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        elevation: 6,
        backgroundColor: const Color.fromRGBO(132, 202, 157, 1),
        selectedItemColor: const Color.fromRGBO(108, 168, 129, 1),
        iconSize: 28,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(
          (() {
            Navigator.pop(context);
          }),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Busca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vendedor = ModalRoute.of(context)?.settings.arguments as Vendedor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(vendedor.nomeVendedor),
        backgroundColor: const Color.fromRGBO(132, 202, 157, 1),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: vendedor.produtosVendedor.length,
                  itemBuilder: (context, index) {
                    final p = vendedor.produtosVendedor[index];
                    return InkWell(
                      onTap: () => _openProductModalSheet(context, p),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, constraints.maxHeight * .03, 0, constraints.maxHeight * .02),
                          height: constraints.maxHeight * .3,
                          width: constraints.maxWidth * .9,
                          decoration: BoxDecoration(color: Color.fromRGBO(242, 242, 242, 0.90), borderRadius: BorderRadius.circular(15)),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: constraints.maxWidth * .03),
                                        height: constraints.maxHeight * .7,
                                        width: constraints.maxWidth * .35,
                                        // decoration: BoxDecoration(color: Colors.cyan),
                                        child: Image.asset('assets/images/amoras.png'),
                                      ),
                                      SizedBox(height: constraints.maxHeight * .01),
                                      Text(
                                        'R\$ 40,00',
                                        style: TextStyle(fontSize: constraints.maxHeight * .06, fontWeight: FontWeight.w400, color: Color.fromRGBO(132, 202, 157, 1)),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: constraints.maxWidth * .07),
                                    height: constraints.maxHeight * .9,
                                    width: constraints.maxWidth * .46,
                                    // decoration: BoxDecoration(color: Colors.deepPurple),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: constraints.maxHeight * .12),
                                        Text(
                                          p.nomeProduto,
                                          style: TextStyle(fontSize: constraints.maxHeight * .1, fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: constraints.maxHeight * .03),
                                        Text(
                                          p.detalheProduto,
                                          style: TextStyle(fontSize: constraints.maxHeight * .07, fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
