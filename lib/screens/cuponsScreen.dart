import 'package:flutter/material.dart';
import '../components/defaultTile.dart';
import '../utils/appRoutes.dart';

class CuponScreen extends StatefulWidget {
  @override
  State<CuponScreen> createState() => _CuponScreenState();
}

class _CuponScreenState extends State<CuponScreen> {
  int _currentIndex = 3;

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
          'Cupons',
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
                DefaultTile(
                  leadingIcon: Icons.local_attraction_outlined,
                  constraints: constraints,
                  subTitle: '50% de descontos em compras no app',
                  title: '50% off',
                ),
                DefaultTile(
                  leadingIcon: Icons.local_attraction_outlined,
                  constraints: constraints,
                  subTitle: 'Frete grátis para compras acima de 50 reais',
                  title: 'Frete Grátis',
                ),
                DefaultTile(
                  constraints: constraints,
                  subTitle: '10% de descontos em compras no app',
                  title: '10% off',
                  leadingIcon: Icons.local_attraction_outlined,
                ),
                DefaultTile(
                  constraints: constraints,
                  leadingIcon: Icons.local_attraction_outlined,
                  subTitle: '30% de descontos em compras no app',
                  title: '30% off',
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
