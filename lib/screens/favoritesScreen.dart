import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/favoriteTile.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/data/dummyData.dart';

import '../model/vendedor.dart';
import '../utils/appRoutes.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentIndex = 3;

  final List<Vendedor> _vendedoresFavoritos = DUMMY_SALESMAN;

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
          'Favoritos',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .03),
                FavoriteTile(
                  constraints: constraints,
                  title: 'Ricardinho Amoras',
                  leadingIcon: Icons.eco_rounded,
                  trailingIcon: Icons.delete,
                  color: const Color.fromRGBO(108, 168, 129, 1),
                ),
                FavoriteTile(
                  constraints: constraints,
                  title: 'Daniele Bananas',
                  leadingIcon: Icons.eco_rounded,
                  trailingIcon: Icons.delete,
                  color: const Color.fromRGBO(108, 168, 129, 1),
                ),
                FavoriteTile(
                  constraints: constraints,
                  title: 'Morangos do Pedro',
                  leadingIcon: Icons.eco_rounded,
                  trailingIcon: Icons.delete,
                  color: const Color.fromARGB(240, 240, 223, 72),
                ),
                FavoriteTile(
                  constraints: constraints,
                  title: 'Alfaces Luiz Carlos',
                  leadingIcon: Icons.eco_rounded,
                  trailingIcon: Icons.delete,
                  color: Colors.red,
                ),
                FavoriteTile(
                  constraints: constraints,
                  title: 'Marlene Legumes',
                  leadingIcon: Icons.eco_rounded,
                  trailingIcon: Icons.delete,
                  color: const Color.fromRGBO(108, 168, 129, 1),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
