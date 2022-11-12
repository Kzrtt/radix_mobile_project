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

  void _openProductModalSheet(BuildContext context, Produtos produto, Vendedor vendedor) {
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * .06),
                      Text(
                        produto.nomeProduto,
                        style: TextStyle(fontSize: constraints.maxHeight * .05, color: Colors.white),
                      ),
                      SizedBox(height: constraints.maxHeight * .03),
                      SizedBox(
                        height: constraints.maxHeight * .35,
                        width: constraints.maxWidth * .5,
                        child: Image.asset('assets/images/amoras.png'),
                      ),
                      SizedBox(height: constraints.maxHeight * .05),
                      SizedBox(
                        child: Text(
                          produto.detalheProduto,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constraints.maxHeight * .04,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: () => provider.dec(), icon: Icon(Icons.remove, color: Colors.white)),
                          Text(
                            context.watch<CartProvider>().quantity.toString(),
                            style: TextStyle(
                              fontSize: constraints.maxHeight * .05,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(onPressed: () => provider.inc(), icon: Icon(Icons.add, color: Colors.white)),
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
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: constraints.maxHeight * .32,
                width: constraints.maxWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * .15,
                      width: constraints.maxWidth,
                      child: Image.asset(
                        'assets/images/bannerRadix.png',
                        height: constraints.maxHeight * .12,
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
                              padding: EdgeInsets.all(constraints.maxHeight * .015),
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
                                  context.watch<SalesmanProvider>().seloProdutor(vendedor.selo),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth * .5,
                            child: Padding(
                              padding: EdgeInsets.all(constraints.maxHeight * .015),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.chat_bubble_outline),
                                        iconSize: constraints.maxHeight * .045,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                      IconButton(
                                        icon: Icon(Provider.of<ClientProvider>(context).isFavorite(vendedor) ? Icons.favorite : Icons.favorite_outline),
                                        iconSize: constraints.maxHeight * .05,
                                        onPressed: () {
                                          if (Provider.of<ClientProvider>(context, listen: false).isFavorite(vendedor) == true) {
                                            Provider.of<ClientProvider>(context, listen: false).removeFromFavorites(vendedor.idVendedor.toString());
                                          } else {
                                            Provider.of<ClientProvider>(context, listen: false).addToFavorites(vendedor);
                                          }
                                        },
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ],
                                  )
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
              Divider(color: Theme.of(context).colorScheme.primary, thickness: constraints.maxWidth * .001),
              SizedBox(height: constraints.maxHeight * .01),
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
                        child: Container(
                          height: constraints.maxHeight * .62,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: constraints.maxHeight * .02),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey,
                                ),
                                height: constraints.maxHeight * .40,
                                width: constraints.maxWidth * .85,
                                child: Center(child: Text(p.urlFoto)),
                              ),
                              SizedBox(height: constraints.maxHeight * .03),
                              SizedBox(
                                height: constraints.maxHeight * .15,
                                width: constraints.maxWidth * .85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Produtor: ${vendedor.nomeVendedor}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                        fontSize: constraints.maxHeight * .022,
                                      ),
                                    ),
                                    SizedBox(height: constraints.maxHeight * .01),
                                    Text(
                                      p.nomeProduto,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: constraints.maxHeight * .022,
                                      ),
                                    ),
                                    SizedBox(height: constraints.maxHeight * .01),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'R\$${p.preco.toString()}',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.primary,
                                            fontSize: constraints.maxHeight * .022,
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          child: IconButton(
                                            onPressed: () => _openProductModalSheet(context, p, vendedor),
                                            icon: Icon(Icons.shopping_cart, color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
