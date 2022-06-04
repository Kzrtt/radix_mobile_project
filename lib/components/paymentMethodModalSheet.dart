import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';

class PaymentMethodModalSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(108, 168, 129, 1),
            ),
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .18),
                Button(
                  height: constraints.maxHeight * .15,
                  width: constraints.maxWidth * .75,
                  text: 'Cartão de Crédito',
                  onTap: () {},
                  color: false,
                ),
                SizedBox(height: constraints.maxHeight * .05),
                Button(
                  height: constraints.maxHeight * .15,
                  width: constraints.maxWidth * .75,
                  text: 'Cartão de Débito',
                  onTap: () {},
                  color: false,
                ),
                SizedBox(height: constraints.maxHeight * .05),
                Button(
                  height: constraints.maxHeight * .15,
                  width: constraints.maxWidth * .75,
                  text: 'Ticket Alimentação',
                  onTap: () {},
                  color: false,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
