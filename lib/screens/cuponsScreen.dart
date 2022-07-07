import 'package:flutter/material.dart';
import '../components/defaultTile.dart';
import '../utils/appRoutes.dart';

class CuponScreen extends StatefulWidget {
  @override
  State<CuponScreen> createState() => _CuponScreenState();
}

class _CuponScreenState extends State<CuponScreen> {
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
          'Cupons',
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
                DefaultTile(
                  leadingIcon: Icons.local_attraction_outlined,
                  constraints: constraints,
                  subTitle: '50% de descontos em compras no app',
                  title: '50% off',
                ),
                DefaultTile(
                  leadingIcon: Icons.local_attraction_outlined,
                  constraints: constraints,
                  subTitle: 'Frete grátis para compras acima de 50 reais',
                  title: 'Frete Grátis',
                ),
                DefaultTile(
                  constraints: constraints,
                  subTitle: '10% de descontos em compras no app',
                  title: '10% off',
                  leadingIcon: Icons.local_attraction_outlined,
                ),
                DefaultTile(
                  constraints: constraints,
                  leadingIcon: Icons.local_attraction_outlined,
                  subTitle: '30% de descontos em compras no app',
                  title: '30% off',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
