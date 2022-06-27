// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';
import 'package:radix_mobile_project/providers/salesmanProvider.dart';
import 'package:radix_mobile_project/screens/adressScreen.dart';
import 'package:radix_mobile_project/screens/chatsScreen.dart';
import 'package:radix_mobile_project/screens/cuponsScreen.dart';
import 'package:radix_mobile_project/screens/favoritesScreen.dart';
import 'package:radix_mobile_project/screens/feedbacksScreen.dart';
import 'package:radix_mobile_project/screens/finalizarCompra.dart';
import 'package:radix_mobile_project/screens/historicScreen.dart';
import 'package:radix_mobile_project/screens/openingScreen.dart';
import 'package:radix_mobile_project/screens/paymentMethodScreen.dart';
import 'package:radix_mobile_project/screens/profileScreen.dart';
import 'package:radix_mobile_project/screens/salesmanScreen.dart';
import 'package:radix_mobile_project/screens/searchScreen.dart';
import 'package:radix_mobile_project/screens/shoppingCartScreen.dart';
import 'package:radix_mobile_project/screens/welcomeBackScreen.dart';
import 'package:radix_mobile_project/utils/customMaterialColor.dart';
import 'utils/appRoutes.dart';
import 'screens/homeTab.dart';
import 'screens/homeScreen.dart';
import 'screens/teste.dart';

/// Programador: Felipe Kurt Pohling
/// Instagram: kurtt.kk
/// Projeto Radix
/// teste

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AdressProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SalesmanProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Radix',
        theme: ThemeData(
          visualDensity: VisualDensity.comfortable,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: CustomMaterialColor(132, 202, 157).mdColor).copyWith(
            secondary: Color.fromRGBO(108, 168, 129, 1),
          ),
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
          AppRoutes.FINALIZARCOMPRA: (ctx) => FinalizarCompra(),
        },
      ),
    );
  }
}
