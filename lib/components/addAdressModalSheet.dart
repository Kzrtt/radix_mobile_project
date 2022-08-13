// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';

class AddAdressModalSheet extends StatefulWidget {
  @override
  State<AddAdressModalSheet> createState() => _AddAdressModalSheetState();
}

class _AddAdressModalSheetState extends State<AddAdressModalSheet> {
  final apelidoEnderecoController = TextEditingController();
  final enderecoController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();

  Widget _textField(double height, double width, BoxConstraints constraints,
      String text, TextEditingController controller) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white, width: constraints.maxWidth * .03),
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
                    'Adicionar novo Endereço',
                    style: TextStyle(
                      fontSize: constraints.maxHeight * .035,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(132, 202, 157, 1),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .08),
                _textField(
                    constraints.maxHeight * .1,
                    constraints.maxWidth * .90,
                    constraints,
                    'Apelido Local',
                    apelidoEnderecoController),
                SizedBox(height: constraints.maxHeight * .02),
                _textField(
                    constraints.maxHeight * .1,
                    constraints.maxWidth * .90,
                    constraints,
                    'Endereço',
                    enderecoController),
                SizedBox(height: constraints.maxHeight * .02),
                Row(
                  children: [
                    SizedBox(width: constraints.maxWidth * .05),
                    _textField(
                        constraints.maxHeight * .1,
                        constraints.maxWidth * .20,
                        constraints,
                        'Número',
                        numeroController),
                    SizedBox(width: constraints.maxWidth * .03),
                    _textField(
                        constraints.maxHeight * .1,
                        constraints.maxWidth * .67,
                        constraints,
                        'Complemento',
                        complementoController),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * .15),
                Button(
                  text: 'Adicionar Endereço',
                  onTap: () {
                    Provider.of<AdressProvider>(context, listen: false)
                        .createAdress(
                      constraints,
                      context,
                      apelidoEnderecoController.text,
                      enderecoController.text,
                      complementoController.text,
                      numeroController.text,
                    );

                    Navigator.of(context).pop();
                  },
                  height: constraints.maxHeight * .1,
                  width: constraints.maxWidth * .75,
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
