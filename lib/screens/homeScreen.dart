// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import '../components/button.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget _item(constraints, String texto1, String texto2, String imagem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: constraints.maxWidth * .05),
          height: constraints.maxHeight * .2,
          width: constraints.maxWidth * .3,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 241, 240, 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Image.asset(
            'assets/productsPics/' + imagem,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: constraints.maxHeight * .01),
        Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * .07),
          child: Text(
            texto1,
            style: TextStyle(fontSize: constraints.maxHeight * .025),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * .07),
          child: Text(
            texto2,
            style: TextStyle(fontSize: constraints.maxHeight * .02, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _itemsRow(constraints, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: constraints.maxHeight * .03),
        Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * .04),
          child: Text(
            title,
            style: TextStyle(fontSize: constraints.maxHeight * .035, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: constraints.maxHeight * .02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _item(constraints, 'Banana Nanica', 'Produtor: Luiz Ricardo', 'bananananica.jpg'),
              _item(constraints, 'Pitaya', 'Produtor: Rubão', 'pitaya.jpg'),
              _item(constraints, 'Maça Argentina', 'Produtor: Luiz Carlos Gandra', 'macaargentina.jpg'),
              _item(constraints, 'Alface', 'Produtor: Luiz Carlos Gandra', 'alface.jpg'),
              SizedBox(width: constraints.maxWidth * .05),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemsRow2(constraints, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: constraints.maxHeight * .03),
        Padding(
          padding: EdgeInsets.only(left: constraints.maxWidth * .04),
          child: Text(
            title,
            style: TextStyle(fontSize: constraints.maxHeight * .035, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: constraints.maxHeight * .02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _item(constraints, 'Luiz Ricardo', '', 'fotoricardinho.PNG'),
              _item(constraints, 'Luiz Carlos Gandra', '', 'fotocarlos.PNG'),
              _item(constraints, 'Rubão', '', 'fotorubao.PNG'),
              _item(constraints, 'Yuri Yoshida', '', 'fotoyuri.PNG'),
              SizedBox(width: constraints.maxWidth * .05),
            ],
          ),
        ),
      ],
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

  final appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 4,
    title: const Center(
      child: Text(
        'Home',
        style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: constraints.maxHeight * .02),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * .02),
                height: constraints.maxHeight * .25,
                width: constraints.maxWidth * .94,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(108, 168, 129, .3),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/bannerRadix.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            _itemsRow(constraints, 'Produtos Novos'),
            SizedBox(height: constraints.maxHeight * .05),
            _itemsRow2(constraints, 'Produtores do App'),
            SizedBox(height: constraints.maxHeight * .1),
          ],
        ),
      );
    });
  }
}
