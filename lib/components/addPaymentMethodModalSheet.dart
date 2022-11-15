import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';
import '../model/cartao.dart';
import 'button.dart';

class AddPaymentMethodModalSheet extends StatefulWidget {
  @override
  State<AddPaymentMethodModalSheet> createState() => _AddPaymentMethodModalSheet();
}

class _AddPaymentMethodModalSheet extends State<AddPaymentMethodModalSheet> {
  final numeroController = TextEditingController();
  final apelidoController = TextEditingController();
  final nomeTitularController = TextEditingController();
  final dataValidadeController = TextEditingController();
  final cvvController = TextEditingController();

  Cartao _x(String numeroCartao, String apelidoCartao, String nomeTitular, String dataValidade, String cvv) {
    Cartao cartao = Cartao(
      idCartao: Random().nextInt(100),
      apelidoCartao: apelidoCartao,
      numerosCartao: numeroCartao,
      cvv: cvv,
      dataValidade: dataValidade,
      nomeTitular: nomeTitular,
    );

    Navigator.of(context).pop();

    return cartao;
  }

  Widget _textField(double height, double width, BoxConstraints constraints, String text, TextEditingController controller) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: constraints.maxWidth * .03),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: constraints.maxHeight * .02,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(238, 238, 238, 1),
            ),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .05),
                Center(
                  child: Text(
                    'Adicionar nova Forma de Pagamento',
                    style: TextStyle(
                      fontSize: constraints.maxHeight * .028,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(132, 202, 157, 1),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .08),
                _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'Números do Cartão', numeroController),
                SizedBox(height: constraints.maxHeight * .02),
                _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'Nome do Titular', nomeTitularController),
                SizedBox(height: constraints.maxHeight * .02),
                _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'Apelido Cartão', apelidoController),
                SizedBox(height: constraints.maxHeight * .02),
                Row(
                  children: [
                    SizedBox(width: constraints.maxWidth * .05),
                    _textField(constraints.maxHeight * .1, constraints.maxWidth * .55, constraints, 'Data de Validade', dataValidadeController),
                    SizedBox(width: constraints.maxWidth * .03),
                    _textField(constraints.maxHeight * .1, constraints.maxWidth * .32, constraints, 'CVV', cvvController),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * .10),
                Button(
                  text: 'Adicionar Forma de Pagamento',
                  onTap: () => Provider.of<PaymentProvider>(context, listen: false).addCartao(
                    _x(
                      numeroController.text,
                      apelidoController.text,
                      nomeTitularController.text,
                      dataValidadeController.text,
                      cvvController.text,
                    ),
                  ),
                  height: constraints.maxHeight * .1,
                  width: constraints.maxWidth * .85,
                  color: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
