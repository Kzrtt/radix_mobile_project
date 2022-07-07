import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/historicTIle.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';

import '../utils/appRoutes.dart';

class HistoricScreen extends StatefulWidget {
  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          'Histórico',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .03),
                HistoricTile(
                  constraints: constraints,
                  title: 'Alfaces Luiz Carlos',
                  subTitle: 'Pacote 30 folhas - R\$ 45',
                  trailingIcon: Icons.add,
                  temporaryString: '',
                ),
                HistoricTile(
                  constraints: constraints,
                  title: 'Daniele Bananas',
                  subTitle: 'Pacote 80 cachos - R\$ 545',
                  trailingIcon: Icons.add,
                  temporaryString: '',
                ),
                HistoricTile(
                  constraints: constraints,
                  title: 'Amoras Ricardinho',
                  subTitle: '40 Amoras fresquinhas - R\$ 80',
                  trailingIcon: Icons.add,
                  temporaryString: '20 Amoras fresquinhas - R\$ 20',
                ),
                SizedBox(height: constraints.maxHeight * .1),
                Provider.of<CartProvider>(context).compras.isEmpty
                    ? const Text('Vazio')
                    : Container(
                        width: constraints.maxWidth * .8,
                        color: Colors.cyan,
                        child: const Text('Deu Certo'),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
