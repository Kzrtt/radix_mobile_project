import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/model/cliente.dart';
import 'package:radix_mobile_project/model/sharedPreferencesModels.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import 'package:radix_mobile_project/utils/sharedPreferencesConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void isManterLoginTrue() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tempString = prefs.getString(SharedPreferencesConstants.loggedUserInfos);
      if (tempString != null) {
        LoggedUserInfo loggedUserInfo = LoggedUserInfo.fromJson(json.decode(tempString));
        if (loggedUserInfo.continuarLoggado == '1') {
          Cliente user = Cliente(
            idCliente: loggedUserInfo.userInfo!.idCliente as int,
            nomeCliente: loggedUserInfo.userInfo!.nomeCliente as String,
            cpfCliente: loggedUserInfo.userInfo!.cpfCliente as String,
            emailCliente: loggedUserInfo.userInfo!.emailCliente as String,
            senhaCliente: loggedUserInfo.userInfo!.senhaCliente as String,
          );
          Provider.of<ClientProvider>(context, listen: false).changeUser(user);
          Navigator.of(context).pushReplacementNamed(AppRoutes.HOMETAB);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.WELCOMEBACK);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.WELCOMEBACK);
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/bolas_verdes.png')),
                SizedBox(height: constraints.maxHeight * .05),
                SvgPicture.asset(
                  'assets/svg/undraw_farm_girl_dnpe.svg',
                  height: constraints.maxHeight * .3,
                ),
                SizedBox(height: constraints.maxHeight * .03),
                Text(
                  'Faça as coisas com Radix',
                  style: TextStyle(
                    fontSize: constraints.maxHeight * .03,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .02),
                Text(
                  'Tranquilidade e facilidade com o sistema de compra, venda e entrega da Radix.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: constraints.maxHeight * .024,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .07),
                Button(
                  text: 'Iniciar',
                  onTap: () => isManterLoginTrue(),
                  height: constraints.maxHeight * .08,
                  width: constraints.maxWidth * .7,
                  color: true,
                ),
                SizedBox(height: constraints.maxHeight * .1),
              ],
            ),
          );
        },
      ),
    );
  }
}
