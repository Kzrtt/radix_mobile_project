import 'package:flutter/material.dart';
import 'button.dart';

class AddPaymentMethodModalSheet extends StatefulWidget {
  final void Function(String, String) onSubmit;

  AddPaymentMethodModalSheet(this.onSubmit);

  @override
  State<AddPaymentMethodModalSheet> createState() => _AddPaymentMethodModalSheet();
}

class _AddPaymentMethodModalSheet extends State<AddPaymentMethodModalSheet> {
  final numeroController = TextEditingController();
  final apelidoController = TextEditingController();

  _submitForm() {
    final numeroCartao = numeroController.text;
    final apelidoCartao = apelidoController.text;

    widget.onSubmit(apelidoCartao, numeroCartao);
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
                _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'Nome do Titular', numeroController),
                SizedBox(height: constraints.maxHeight * .02),
                _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'Apelido Cartão', apelidoController),
                SizedBox(height: constraints.maxHeight * .02),
                Row(
                  children: [
                    SizedBox(width: constraints.maxWidth * .05),
                    _textField(constraints.maxHeight * .1, constraints.maxWidth * .55, constraints, 'Data de Validade', apelidoController),
                    SizedBox(width: constraints.maxWidth * .03),
                    _textField(constraints.maxHeight * .1, constraints.maxWidth * .32, constraints, 'CVV', apelidoController),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * .10),
                Button(
                  text: 'Adicionar Forma de Pagamento',
                  onTap: _submitForm,
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
