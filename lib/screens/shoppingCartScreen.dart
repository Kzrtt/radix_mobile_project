import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
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
    List<Endereco> a = context.watch<AdressProvider>().getAdress;
    List<Item> _items = context.watch<CartProvider>().items;
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
                            imgUrl:
                                'assets/images/undraw_shopping_app_flsj.png',
                            secondText:
                                'Adicione produtos a sua sacole depois retorne a essa sessão.',
                            constraints: constraints,
                          ),
                          SizedBox(height: constraints.maxHeight * .05),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.all(constraints.maxHeight * .02),
                              width: constraints.maxWidth * .5,
                              child: Column(
                                children: [
                                  SizedBox(height: constraints.maxHeight * .01),
                                  Text(
                                    'Endereço de Entrega',
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * .035,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Create provider to change isPrimary state to true',
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * .02,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: constraints.maxWidth * .05),
                                child: Text(
                                  'Alterar',
                                  style: TextStyle(
                                    fontSize: constraints.maxHeight * .035,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(108, 168, 129, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color.fromRGBO(132, 202, 157, 1),
                          thickness: constraints.maxWidth * .003,
                          indent: constraints.maxWidth * .1,
                          endIndent: constraints.maxWidth * .1,
                          height: constraints.maxHeight * .1,
                        ),
                        SizedBox(height: constraints.maxHeight * .03),
                        Row(
                          children: [
                            SizedBox(width: constraints.maxWidth * .05),
                            Text(
                              'Seus Produtos:',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * .035,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(108, 168, 129, 1),
                              ),
                            ),
                            SizedBox(width: constraints.maxWidth * .05),
                            Text(
                              '${_items.length}',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * .035,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(108, 168, 129, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * .02),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(220, 245, 236, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.zero,
                          height: constraints.maxHeight * .75,
                          width: constraints.maxWidth * .95,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _items.length,
                            itemBuilder: (context, index) {
                              final i = _items[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 4,
                                margin: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.asset(
                                            'assets/images/amoras.png',
                                            height: constraints.maxHeight * .3,
                                            width: constraints.maxWidth * 1,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.abc,
                                                color: const Color.fromRGBO(
                                                    132, 202, 157, 1),
                                                size:
                                                    constraints.maxHeight * .04,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxHeight * .01,
                                              ),
                                              Text(
                                                i.vendedor.nomeVendedor,
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          .03,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.eco_sharp,
                                                color: const Color.fromRGBO(
                                                    132, 202, 157, 1),
                                                size:
                                                    constraints.maxHeight * .03,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxHeight * .01,
                                              ),
                                              Text(
                                                i.produto.nomeProduto,
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          .03,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: const Color.fromRGBO(
                                                    132, 202, 157, 1),
                                                size:
                                                    constraints.maxHeight * .03,
                                              ),
                                              SizedBox(
                                                width:
                                                    constraints.maxHeight * .01,
                                              ),
                                              Text(
                                                i.produto.preco.toString(),
                                                style: TextStyle(
                                                  fontSize:
                                                      constraints.maxHeight *
                                                          .03,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        color: Color.fromRGBO(132, 202, 157, 1),
                                        thickness: constraints.maxWidth * .001),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: constraints.maxHeight * .01),
                                      height: constraints.maxHeight * .12,
                                      width: constraints.maxWidth * .8,
                                      child: Text(i.produto.detalheProduto),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.remove,
                                                color: Colors.black)),
                                        Text(
                                          i.quantity.toString(),
                                          style: TextStyle(
                                            fontSize:
                                                constraints.maxHeight * .05,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.add,
                                                color: Colors.black)),
                                      ],
                                    ),
                                    SizedBox(
                                        height: constraints.maxHeight * .05),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * .05),
                        Divider(
                          color: Color.fromRGBO(132, 202, 157, 1),
                          thickness: constraints.maxWidth * .005,
                          indent: constraints.maxWidth * .1,
                          endIndent: constraints.maxWidth * .1,
                          height: constraints.maxHeight * .1,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * .1,
                            vertical: constraints.maxHeight * .02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Subtotal',
                              ),
                              Text(
                                  'R\$ ${Provider.of<CartProvider>(context).getTotal()}'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * .1,
                            vertical: constraints.maxHeight * .02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Frete',
                                style: TextStyle(
                                  color: Color.fromRGBO(132, 202, 157, 1),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text('R\$ 10.00'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth * .1,
                            vertical: constraints.maxHeight * .02,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  'R\$ ${Provider.of<CartProvider>(context).getTotal() + 10.00}'),
                            ],
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * .1),
                        Button(
                          text: 'Avançar',
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.FINALIZARCOMPRA,
                            arguments: _items,
                          ),
                          height: constraints.maxHeight * .08,
                          width: constraints.maxWidth * .6,
                          color: true,
                        ),
                        SizedBox(height: constraints.maxHeight * .04),
                        Button(
                          text: 'Limpar Carrinho',
                          onTap: () =>
                              Provider.of<CartProvider>(context).clearCart(),
                          height: constraints.maxHeight * .08,
                          width: constraints.maxWidth * .6,
                          color: false,
                        ),
                        SizedBox(height: constraints.maxHeight * .2),
                      ],
                    ),
            ],
          ),
        );
      }),
    );
  }
}
