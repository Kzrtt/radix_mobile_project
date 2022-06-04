import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/historicTIle.dart';

import '../utils/appRoutes.dart';

class HistoricScreen extends StatefulWidget {
  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
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
          'Histórico',
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
                HistoricTile(
                  constraints: constraints,
                  title: 'Alfaces Luiz Carlos',
                  subTitle: 'Pacote 30 folhas - R\$ 45',
                  trailingIcon: Icons.add,
                  temporaryString: '',
                ),
                HistoricTile(
                  constraints: constraints,
                  title: 'Daniele Bananas',
                  subTitle: 'Pacote 80 cachos - R\$ 545',
                  trailingIcon: Icons.add,
                  temporaryString: '',
                ),
                HistoricTile(
                  constraints: constraints,
                  title: 'Amoras Ricardinho',
                  subTitle: '40 Amoras fresquinhas - R\$ 80',
                  trailingIcon: Icons.add,
                  temporaryString: '20 Amoras fresquinhas - R\$ 20',
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
