import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import '../components/imageContainer.dart';
import '../utils/appRoutes.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  bool shoppingCartStatus = true;
  int _currentIndex = 2;

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        elevation: 6,
        backgroundColor: Color.fromRGBO(132, 202, 157, 1),
        selectedItemColor: Color.fromRGBO(108, 168, 129, 1),
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
        'Carrinho de Compras',
        style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                shoppingCartStatus
                    ? Container(
                        margin:
                            EdgeInsets.only(top: constraints.maxHeight * .07),
                        child: Column(
                          children: [
                            TextPlusImage(
                              firstText: 'Nenhum produto adicionado',
                              imgUrl:
                                  'assets/images/undraw_shopping_app_flsj.png',
                              secondText:
                                  'Adicione produtos a sua sacole depois retorne a essa sessão.',
                              constraints: constraints,
                            ),
                            SizedBox(height: constraints.maxHeight * .05),
                            Button(
                              text: 'Começar a comprar',
                              height: constraints.maxHeight * .1,
                              width: constraints.maxWidth * .75,
                              onTap: () {
                                setState(() {
                                  shoppingCartStatus = !shoppingCartStatus;
                                });
                              },
                              color: true,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(height: constraints.maxHeight * .3),
                            const Text('Esvaziar Carrinho'),
                            SizedBox(height: constraints.maxHeight * .1),
                            Button(
                              text: 'Esvaziar Carrinho',
                              height: constraints.maxHeight * .1,
                              width: constraints.maxWidth * .75,
                              onTap: () {
                                setState(() {
                                  shoppingCartStatus = !shoppingCartStatus;
                                });
                              },
                              color: true,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
