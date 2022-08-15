// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unrelated_type_equality_checks
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';

import '../providers/salesmanProvider.dart';

class SalesmanScreen extends StatefulWidget {
  @override
  State<SalesmanScreen> createState() => _SalesmanScreen();
}

class _SalesmanScreen extends State<SalesmanScreen> {
  int _currentIndex = 1;
  int _productQuantity = 1;

  void _openProductModalSheet(
      BuildContext context, Produtos produto, Vendedor vendedor) {
    final provider = Provider.of<CartProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .70,
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
                      SizedBox(height: constraints.maxHeight * .06),
                      Text(
                        produto.nomeProduto,
                        style: TextStyle(
                            fontSize: constraints.maxHeight * .05,
                            color: Colors.white),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      SizedBox(
                        height: constraints.maxHeight * .35,
                        width: constraints.maxWidth * .5,
                        child: Image.asset('assets/images/amoras.png'),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () => provider.dec(),
                              icon: Icon(Icons.remove, color: Colors.white)),
                          Text(
                            context.watch<CartProvider>().quantity.toString(),
                            style: TextStyle(
                              fontSize: constraints.maxHeight * .05,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () => provider.inc(),
                              icon: Icon(Icons.add, color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      Button(
                        text: 'Adicionar',
                        onTap: () {
                          Item item = Item(
                            idItem: Random().nextDouble().toString(),
                            produto: produto,
                            vendedor: vendedor,
                            quantity: provider.quantity,
                            total: produto.preco * provider.quantity,
                          );

                          provider.addToCart(item);

                          Navigator.of(context).pop();
                        },
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth * .5,
                        color: false,
                      ),
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * .3,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * .15,
                      width: constraints.maxWidth,
                      child: Image.asset(
                        'assets/images/fazendeiro.png',
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * .15,
                      width: constraints.maxWidth,
                      child: Row(
                        children: [
                          SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth * .5,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(constraints.maxHeight * .015),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendedor.nomeVendedor,
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * .03,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    vendedor.enderecoVendedor,
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * .02,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: constraints.maxHeight * .01),
                                  context
                                      .watch<SalesmanProvider>()
                                      .seloProdutor(vendedor.selo),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth * .5,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(constraints.maxHeight * .015),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                        Provider.of<ClientProvider>(context)
                                                .isFavorite(vendedor)
                                            ? Icons.favorite
                                            : Icons.favorite_outline),
                                    iconSize: constraints.maxHeight * .05,
                                    onPressed: () {
                                      if (Provider.of<ClientProvider>(context,
                                                  listen: false)
                                              .isFavorite(vendedor) ==
                                          true) {
                                        Provider.of<ClientProvider>(context,
                                                listen: false)
                                            .removeFromFavorites(
                                                vendedor.idVendedor.toString());
                                      } else {
                                        Provider.of<ClientProvider>(context,
                                                listen: false)
                                            .addToFavorites(vendedor);
                                      }
                                    },
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: constraints.maxWidth * .001),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: vendedor.produtosVendedor.length,
                  itemBuilder: (context, index) {
                    final p = vendedor.produtosVendedor[index];
                    return InkWell(
                      onTap: () => _openProductModalSheet(context, p, vendedor),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    'assets/images/amoras.png',
                                    height: constraints.maxHeight * .3,
                                    width: constraints.maxWidth * 1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.eco_sharp,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: constraints.maxHeight * .04,
                                      ),
                                      SizedBox(
                                        width: constraints.maxHeight * .01,
                                      ),
                                      Text(
                                        p.nomeProduto,
                                        style: TextStyle(
                                          fontSize: constraints.maxHeight * .03,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: constraints.maxHeight * .04,
                                      ),
                                      SizedBox(
                                        width: constraints.maxHeight * .01,
                                      ),
                                      Text(
                                        p.preco.toString(),
                                        style: TextStyle(
                                          fontSize: constraints.maxHeight * .03,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                color: Theme.of(context).colorScheme.primary,
                                thickness: constraints.maxWidth * .001),
                            Container(
                              margin: EdgeInsets.only(
                                  top: constraints.maxHeight * .01),
                              height: constraints.maxHeight * .12,
                              width: constraints.maxWidth * .8,
                              child: Text(p.detalheProduto),
                            )
                          ],
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
