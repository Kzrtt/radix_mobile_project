// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/screens/profileScreen.dart';
import 'package:radix_mobile_project/screens/searchScreen.dart';
import 'package:radix_mobile_project/screens/shoppingCartScreen.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import '../providers/cupomProvider.dart';
import 'homeScreen.dart';
import '../screens/searchScreen.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeState();
}

class _HomeState extends State<HomeTab> {
  int _currentIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final List<String> _screensTitle = [
      'Home',
      'Busca',
      'Carrinho de Compras',
      'Perfil'
    ];

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
      leading: Padding(
        padding:
            EdgeInsets.fromLTRB(appBarHeight * .2, appBarHeight * .3, 0, 0),
        child: Text(
          'Editar',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        Padding(
          padding:
              EdgeInsets.fromLTRB(0, appBarHeight * .3, appBarHeight * .3, 0),
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.OPENINGSCREEN);
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
          'Perfil',
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
