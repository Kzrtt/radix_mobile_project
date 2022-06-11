import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/bolas_verdes.png')),
                Image.asset('assets/images/farm_girl.png'),
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
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.WELCOMEBACK);
                  },
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
