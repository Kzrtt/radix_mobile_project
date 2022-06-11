import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/components/addAdressModalSheet.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../components/tTile.dart';

class AdressScreen extends StatefulWidget {
  @override
  State<AdressScreen> createState() => _AdressScreenState();
}

class _AdressScreenState extends State<AdressScreen> {
  void _openAddAdressModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: AddAdressModalSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _adress = context.watch<AdressProvider>().getAdress;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color.fromRGBO(108, 168, 129, 1),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          'Endereço',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: _adress.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .1),
                    TextPlusImage(
                      firstText: 'Nenhum endereço cadastrado',
                      imgUrl: 'assets/images/undraw_location.png',
                      secondText: 'Cadastre um endereço para poder fazer compras no app',
                      constraints: constraints,
                    ),
                  ],
                );
              },
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .04),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _adress.length,
                        itemBuilder: (context, index) {
                          final a = _adress[index];
                          return TTile(
                            constraints: constraints,
                            id: a.idEndereco,
                            title: a.apelidoEndereco,
                            subTitle: a.endereco,
                            leadingIcon: Icons.home,
                            trailingIcon: Icons.delete,
                            color: true,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddAdressModalSheet(context),
        backgroundColor: const Color.fromRGBO(108, 168, 129, 1),
        child: const Icon(Icons.add),
      ),
    );
  }
}
