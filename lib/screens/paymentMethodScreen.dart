// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/addPaymentMethodModalSheet.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';
import 'package:radix_mobile_project/utils/sharedPreferencesConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/trailingTile.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<PaymentProvider>(context, listen: false).loadCartoes().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _openAddPaymentMethodModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: AddPaymentMethodModalSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _cartoes = Provider.of<PaymentProvider>(context).getCartoesSharedPreferences();

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
          'Métodos de Pagamento',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cartoes.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * .15),
                        TextPlusImage(
                          firstText: 'Adicione uma forma de Pagamento',
                          imgUrl: 'assets/svg/undraw_vault.svg',
                          height: constraints.maxHeight * .22,
                          secondText: 'Adicione uma forma de pagamento para poder realizar compras em nosso app',
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
                            itemCount: _cartoes.length,
                            itemBuilder: (context, index) {
                              final c = _cartoes[index];
                              return TrailingTile(
                                constraints: constraints,
                                id: c.idPagamento as int,
                                title: c.apelidoCartao as String,
                                subTitle: c.numeroCartao as String,
                                leadingIcon: Icons.account_balance_wallet_outlined,
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
        onPressed: () => _openAddPaymentMethodModalSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
