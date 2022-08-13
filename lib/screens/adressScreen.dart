import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/components/addAdressModalSheet.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../components/tTile.dart';
import '../providers/clientProvider.dart';

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
    Future<List<Endereco>> getData() async {
      List<Endereco> enderecos = [];
      var response = await Dio().get(
          'http://localhost:8000/api/getAllEnderecos/${Provider.of<ClientProvider>(context, listen: false).getUser.idCliente}');
      response.data['enderecos'].forEach(
        (k, e) {
          Endereco endereco = Endereco(
            idEndereco: e['idEndereco'],
            apelidoEndereco: e['apelidoEndereco'],
            endereco: e['endereco'],
            complemento: e['complemento'],
            numero: e['numero'],
            statusEndereco: e['statusEndereco'],
          );
          if (endereco.statusEndereco == 1) {
            enderecos.add(endereco);
          }
        },
      );
      Provider.of<AdressProvider>(context, listen: false)
          .setEnderecos(enderecos);
      return enderecos;
    }

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(height: constraints.maxHeight * .04),
              Expanded(
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    List<Endereco> enderecos =
                        Provider.of<AdressProvider>(context).getEnderecos();
                    if (snapshot.hasData && enderecos.isNotEmpty) {
                      return ListView.builder(
                        itemCount: enderecos.length,
                        itemBuilder: (context, index) {
                          final e = enderecos[index];
                          return TTile(
                            constraints: constraints,
                            id: e.idEndereco,
                            title: e.apelidoEndereco,
                            subTitle: e.endereco,
                            leadingIcon: Icons.home,
                            trailingIcon: Icons.delete,
                            color: true,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (enderecos.isEmpty) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return Column(
                          children: [
                            SizedBox(height: constraints.maxHeight * .15),
                            TextPlusImage(
                              firstText: 'Nenhum endereço cadastrado',
                              imgUrl: 'assets/svg/undraw_my_location.svg',
                              height: constraints.maxHeight * .3,
                              secondText:
                                  'Cadastre um endereço para poder fazer compras no app',
                              constraints: constraints,
                            ),
                          ],
                        );
                      });
                    } else {
                      return const CircularProgressIndicator();
                    }
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
