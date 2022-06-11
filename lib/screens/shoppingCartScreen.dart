import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import '../components/imageContainer.dart';
import '../utils/appRoutes.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
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
    return LayoutBuilder(
      builder: ((context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              context.watch<CartProvider>().items.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: constraints.maxHeight * .07),
                      child: Column(
                        children: [
                          TextPlusImage(
                            firstText: 'Nenhum produto adicionado',
                            imgUrl: 'assets/images/undraw_shopping_app_flsj.png',
                            secondText: 'Adicione produtos a sua sacole depois retorne a essa sessão.',
                            constraints: constraints,
                          ),
                          SizedBox(height: constraints.maxHeight * .05),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: context.watch<CartProvider>().items.length,
                          itemBuilder: (context, index) {
                            Item i = context.watch<CartProvider>().items[index];
                            return ListTile(
                              leading: Text(i.quantity.toString()),
                              title: Text(i.produto.nomeProduto),
                              trailing: Text(i.total.toString()),
                            );
                          },
                        ),
                        SizedBox(height: constraints.maxHeight * .3),
                        Button(
                          text: 'Limpar Carrinho',
                          onTap: () => Provider.of<CartProvider>(context, listen: false).clearCart(),
                          height: constraints.maxHeight * .1,
                          width: constraints.maxWidth * .5,
                          color: true,
                        ),
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
