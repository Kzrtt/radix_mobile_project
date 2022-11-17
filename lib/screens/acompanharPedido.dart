import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

class AcompanharPedido extends StatefulWidget {
  const AcompanharPedido({Key? key}) : super(key: key);

  @override
  State<AcompanharPedido> createState() => _AcompanharPedidoState();
}

class _AcompanharPedidoState extends State<AcompanharPedido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Acompanhar Pedido',
          style: TextStyle(
            color: Color.fromRGBO(132, 202, 157, 1),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Button(
        text: 'ir pra home',
        onTap: () {
          Navigator.of(context).popAndPushNamed(AppRoutes.HOMETAB);
        },
        height: 50,
        width: 200,
        color: true,
      ),
    );
  }
}
