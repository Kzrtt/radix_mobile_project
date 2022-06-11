import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/components/addAdressModalSheet.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

class AdressScreen extends StatefulWidget {
  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  int _currentIndex = 3;

  void _openAddAdressModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: AddAdressModalSheet(),
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
    final _adress = context.watch<AdressProvider>().getAdress;

    return Scaffold(
      backgroundColor: Colors.white,
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
          'Endereço',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: _adress.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .1),
                    TextPlusImage(
                      firstText: 'Nenhum endereço cadastrado',
                      imgUrl: 'assets/images/undraw_location.png',
                      secondText: 'Cadastre um endereço para poder fazer compras no app',
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
                        itemCount: _adress.length,
                        itemBuilder: (context, index) {
                          final a = _adress[index];
                          return TrailingTile(
                            constraints: constraints,
                            id: a.idEndereco,
                            title: a.apelidoEndereco,
                            subTitle: a.endereco,
                            leadingIcon: Icons.home,
                            trailingIcon: Icons.delete,
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
        onPressed: () => _openAddAdressModalSheet(context),
        backgroundColor: const Color.fromRGBO(108, 168, 129, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
