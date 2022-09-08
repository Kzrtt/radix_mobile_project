// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import '../components/profileButton.dart';
import '../data/fruitList.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;
  int randomFruit = 0;
  List<String> fruits = FRUITS;

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

  void _goToPaymentScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.PAGAMENTOS,
    );
  }

  void _goToCuponScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.CUPONS,
    );
  }

  void _goToChatScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.CHATS,
    );
  }

  void _goToFavoritesScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.FAVORITES,
    );
  }

  void _goToAdressScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.ADRESS,
    );
  }

  void _goToHistoricScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.HISTORIC,
    );
  }

  void _goToFeedbacksScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.FEEDBACKS,
    );
  }

  @override
  void initState() {
    super.initState();
    randomFruit = Random().nextInt(12);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      title: Center(
        child: Text(
          '',
          style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
        ),
      ),
    );
    return LayoutBuilder(
      builder: ((context, constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    height: constraints.maxHeight * .15,
                    width: constraints.maxWidth,
                  ),
                  Center(
                    child: CircleAvatar(
                      maxRadius: 100,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/images/fotoKurt.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 230, top: 140),
                    child: InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: constraints.maxHeight * .02),
              Text(
                context.watch<ClientProvider>().getUser.nomeCliente,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: constraints.maxHeight * .04),
              ProfileButton(
                title: 'Pagamentos',
                subTitle: 'Formas de pagamento',
                constraints: constraints,
                leading: Icons.account_balance_wallet_outlined,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToPaymentScreen,
              ),
              ProfileButton(
                title: 'Chats',
                subTitle: 'Conversas com vendedores',
                constraints: constraints,
                leading: Icons.chat_bubble_outline_outlined,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToChatScreen,
              ),
              ProfileButton(
                title: 'Cupons',
                subTitle: 'Cupons de desconto',
                constraints: constraints,
                leading: Icons.local_attraction_outlined,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToCuponScreen,
              ),
              ProfileButton(
                title: 'Favoritos',
                subTitle: 'Vendedores favoritos',
                constraints: constraints,
                leading: Icons.favorite_border_outlined,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToFavoritesScreen,
              ),
              ProfileButton(
                title: 'Endereços',
                subTitle: 'Endereços para entrega',
                constraints: constraints,
                leading: Icons.location_on_outlined,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToAdressScreen,
              ),
              ProfileButton(
                title: 'Histórico',
                subTitle: 'Confira suas últimas compras',
                constraints: constraints,
                leading: Icons.history_sharp,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToHistoricScreen,
              ),
              ProfileButton(
                title: 'Feedbacks',
                subTitle: 'Envie um feedback para equipe Radix',
                constraints: constraints,
                leading: Icons.eco_sharp,
                traicing: Icons.arrow_forward_ios_outlined,
                route: _goToFeedbacksScreen,
              ),
              SizedBox(
                height: constraints.maxHeight * .1,
              )
            ],
          ),
        );
      }),
    );
  }
}
