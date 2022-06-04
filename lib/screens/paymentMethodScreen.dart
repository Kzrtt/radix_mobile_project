// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/addPaymentMethodModalSheet.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/model/cartao.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../components/trailingTile.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _currentIndex = 3;
  final _cartoes = <Cartao>[];

  void _addCard(String apelido, String numero) {
    final newCard = Cartao(
      idCartao: Random().nextInt(100).toString(),
      apelidoCartao: apelido,
      numerosCartao: numero,
    );

    setState(() {
      _cartoes.add(newCard);
    });

    Navigator.of(context).pop();
  }

  void _deleteCard(String id) {
    setState(() {
      _cartoes.removeWhere((c) => c.idCartao == id);
    });
  }

  void _openAddPaymentMethodModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: AddPaymentMethodModalSheet(_addCard),
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
        onTap: (index) {
          setState((() => _currentIndex = index));
          switch (_currentIndex) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.HOME);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.SEARCH);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.SHOPPINGCART);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, AppRoutes.PROFILE);
              break;
            default:
          }
        },
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color.fromRGBO(108, 168, 129, 1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          'Métodos de Pagamento',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: _cartoes.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .05),
                    TextPlusImage(
                      firstText: 'Adicione uma forma de Pagamento',
                      imgUrl: 'assets/images/undraw_vault.png',
                      secondText:
                          'Adicione uma forma de pagamento para poder realizar compras em nosso app',
                      constraints: constraints,
                    ),
                  ],
                );
              },
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .04),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _cartoes.length,
                        itemBuilder: (context, index) {
                          final c = _cartoes[index];
                          return TrailingTile(
                            constraints: constraints,
                            id: c.idCartao,
                            title: c.apelidoCartao,
                            subTitle: c.numerosCartao,
                            leadingIcon: Icons.account_balance_wallet_outlined,
                            trailingIcon: Icons.delete,
                            deleteFunction: _deleteCard,
                            color: true,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddPaymentMethodModalSheet(context),
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(108, 168, 129, 1),
      ),
    );
  }
}
