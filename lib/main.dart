import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/addAdressModalSheet.dart';
import 'package:radix_mobile_project/components/addPaymentMethodModalSheet.dart';
import 'package:radix_mobile_project/model/cliente.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';
import 'package:radix_mobile_project/screens/adressScreen.dart';
import 'package:radix_mobile_project/screens/chatsScreen.dart';
import 'package:radix_mobile_project/screens/cuponsScreen.dart';
import 'package:radix_mobile_project/screens/favoritesScreen.dart';
import 'package:radix_mobile_project/screens/feedbacksScreen.dart';
import 'package:radix_mobile_project/screens/historicScreen.dart';
import 'package:radix_mobile_project/screens/openingScreen.dart';
import 'package:radix_mobile_project/screens/paymentMethodScreen.dart';
import 'package:radix_mobile_project/screens/profileScreen.dart';
import 'package:radix_mobile_project/screens/salesmanScreen.dart';
import 'package:radix_mobile_project/screens/searchScreen.dart';
import 'package:radix_mobile_project/screens/shoppingCartScreen.dart';
import 'package:radix_mobile_project/screens/welcomeBackScreen.dart';
import 'model/endereco.dart';
import 'utils/appRoutes.dart';
import 'screens/homeTab.dart';
import 'screens/homeScreen.dart';
import 'screens/teste.dart';

/// Programador: Felipe Kurt Pohling
/// Instagram: kurtt.kk
/// Projeto Radix
/// Testando se o Commit funciona

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Cliente cliente = Cliente(
    idCliente: 1,
    nomeCliente: 'Cliente teste',
    cpfCliente: '',
    emailCliente: '',
    senhaCliente: '',
    statusContaCliente: true,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdressProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radix',
        theme: ThemeData(
          visualDensity: VisualDensity.comfortable,
        ),
        routes: {
          AppRoutes.OPENINGSCREEN: (ctx) => OpeningScreen(),
          AppRoutes.WELCOMEBACK: (ctx) => WelcomeBackScreen(),
          AppRoutes.HOMETAB: (ctx) => HomeTab(),
          AppRoutes.HOME: (ctx) => HomeScreen(),
          AppRoutes.TESTE: (ctx) => Teste(),
          AppRoutes.SEARCH: (ctx) => SearchScreen(),
          AppRoutes.PAGAMENTOS: (ctx) => PaymentMethodScreen(),
          AppRoutes.CUPONS: (ctx) => CuponScreen(),
          AppRoutes.CHATS: (ctx) => ChatScreen(),
          AppRoutes.FAVORITES: (ctx) => FavoritesScreen(),
          AppRoutes.ADRESS: (ctx) => AdressScreen(),
          AppRoutes.HISTORIC: (ctx) => HistoricScreen(),
          AppRoutes.FEEDBACKS: (ctx) => FeedbackScreen(),
          AppRoutes.SHOPPINGCART: (ctx) => ShoppingCartScreen(),
          AppRoutes.SALESMANPROFILE: (ctx) => SalesmanScreen(),
          AppRoutes.PROFILE: (ctx) => ProfileScreen(),
        },
      ),
    );
  }
}
