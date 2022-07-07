import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../components/button.dart';

class FinalizarCompra extends StatelessWidget {
  const FinalizarCompra({Key? key}) : super(key: key);

  void _openSucessoModalSheet(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        text: 'Deu Certo',
                        onTap: () =>
                            Navigator.of(context).pushNamed(AppRoutes.HOMETAB),
                        height: constraints.maxHeight * .08,
                        width: constraints.maxWidth * .6,
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

  @override
  Widget build(BuildContext context) {
    final _listaDeItems =
        ModalRoute.of(context)?.settings.arguments as List<Item>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Finalizar Compra',
          style: TextStyle(
            color: Color.fromRGBO(132, 202, 157, 1),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Button(
              text: 'Finalizar Compra',
              onTap: () {
                Provider.of<CartProvider>(context, listen: false)
                    .finalizarCompra(_listaDeItems);
                _openSucessoModalSheet(context);
              },
              height: constraints.maxHeight * .08,
              width: constraints.maxWidth * .6,
              color: true,
            ),
          );
        },
      ),
    );
  }
}
