// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/cliente.dart';
import 'package:radix_mobile_project/screens/profileScreen.dart';
import 'package:radix_mobile_project/screens/searchScreen.dart';
import 'package:radix_mobile_project/screens/shoppingCartScreen.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import '../components/button.dart';
import '../providers/clientProvider.dart';
import '../providers/cupomProvider.dart';
import 'homeScreen.dart';
import '../screens/searchScreen.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeState();
}

class _HomeState extends State<HomeTab> {
  int _currentIndex = 0;
  final senhaFormController = TextEditingController();
  final senhaFormValidationController = TextEditingController();
  final nomeFormController = TextEditingController();
  final emailFormController = TextEditingController();
  final cpfFormController = TextEditingController();

  final List<String> _routes = [
    AppRoutes.HOME,
    AppRoutes.SEARCH,
    AppRoutes.SHOPPINGCART,
    AppRoutes.PROFILE,
  ];

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
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
        onTap: (index) => setState((() => _currentIndex = index)),
        items: [
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

  Widget _textField(double height, double width, BoxConstraints constraints, String text, TextEditingController controller, String initialValue) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller..text = initialValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: constraints.maxWidth * .03),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: constraints.maxHeight * .03,
          ),
        ),
      ),
    );
  }

  void updateCliente(String senha, String validaSenha, String nome, String cpf, String email, constraints) async {
    try {
      if (senhaFormController.text == senhaFormValidationController.text) {
        var response = await Dio().put(
          'http://localhost:8000/api/updateCliente/${Provider.of<ClientProvider>(context, listen: false).getUser.idCliente}',
          data: {
            'nomeCliente': nome,
            'cpfCliente': cpf,
            'emailCliente': email,
            'senhaCliente': senha,
            'statusCliente': '1',
          },
        );
        if (response.data['status'] == '400') {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(response.data['message'], style: TextStyle(fontSize: constraints.maxWidth * .04)),
            ),
          );
        } else {
          print(response.data['message']);
          Cliente cliente = Cliente(
            idCliente: Provider.of<ClientProvider>(context, listen: false).getUser.idCliente,
            nomeCliente: nomeFormController.text,
            cpfCliente: cpfFormController.text,
            emailCliente: emailFormController.text,
            senhaCliente: senhaFormController.text,
          );
          Provider.of<ClientProvider>(context, listen: false).changeUser(cliente);
          Navigator.of(context).pop();
        }
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('As senhas não são iguais', style: TextStyle(fontSize: constraints.maxWidth * .04)),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _openAddClientModalSheet(BuildContext context) {
    Cliente cliente = Provider.of<ClientProvider>(context, listen: false).getUser;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .75,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * .05),
                      Center(
                        child: Text(
                          'Alterar Perfil',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * .035,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu nome', nomeFormController, cliente.nomeCliente),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu email', emailFormController, cliente.emailCliente),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu cpf', cpfFormController, cliente.cpfCliente),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'nova senha', senhaFormController, ''),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'confirmar senha', senhaFormValidationController, ''),
                      SizedBox(height: constraints.maxHeight * .10),
                      Button(
                        text: 'Alterar Dados',
                        onTap: () => updateCliente(
                          senhaFormController.text,
                          senhaFormValidationController.text,
                          nomeFormController.text,
                          cpfFormController.text,
                          emailFormController.text,
                          constraints,
                        ),
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth * .75,
                        color: true,
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
    final List<String> _screensTitle = ['Home', 'Busca', 'Carrinho de Compras', 'Perfil'];

    final appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 4,
      title: Text(
        _screensTitle[_currentIndex],
        style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
      ),
    );

    double appBarHeight = appBar.preferredSize.height;

    final appBarProfile = AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      leading: InkWell(
        onTap: () => _openAddClientModalSheet(context),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: appBarHeight * .15),
            child: Text(
              'Editar',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, appBarHeight * .3, appBarHeight * .3, 0),
          child: InkWell(
            onTap: () {
              Provider.of<ClientProvider>(context, listen: false).userLogoff();
              Navigator.of(context).pushReplacementNamed(AppRoutes.OPENINGSCREEN);
            },
            child: Text(
              'Sair',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
      title: Center(
        child: Text(
          '',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );

    final List<Widget> _screens = [
      HomeScreen(),
      SearchScreen(),
      ShoppingCartScreen(),
      ProfileScreen(),
    ];

    if (_screensTitle[_currentIndex] != 'Perfil') {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: appBar,
        body: _screens[_currentIndex],
        bottomNavigationBar: bottomNavigationBar,
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: appBarProfile,
        body: _screens[_currentIndex],
        bottomNavigationBar: bottomNavigationBar,
      );
    }
  }
}
