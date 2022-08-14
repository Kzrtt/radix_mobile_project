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
  bool _isLoading = true;

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
  void initState() {
    super.initState();
    Provider.of<AdressProvider>(
      context,
      listen: false,
    )
        .loadEnderecos(Provider.of<ClientProvider>(
      context,
      listen: false,
    ).getUser.idCliente)
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Endereco> _enderecos =
        Provider.of<AdressProvider>(context).getEnderecos();

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _enderecos.isEmpty
              ? LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * .15),
                      TextPlusImage(
                        firstText: 'Nenhum endereço cadastrado',
                        imgUrl: 'assets/svg/undraw_my_location.svg',
                        height: constraints.maxWidth * .5,
                        secondText:
                            'Cadastre um endereço para poder fazer compras no app',
                        constraints: constraints,
                      ),
                    ],
                  );
                })
              : LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * .04),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _enderecos.length,
                            itemBuilder: (context, index) {
                              final e = _enderecos[index];
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
                          ),
                        ),
                      ],
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddAdressModalSheet(context),
        backgroundColor: const Color.fromRGBO(108, 168, 129, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
