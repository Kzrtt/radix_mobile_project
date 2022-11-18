import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/cupom.dart';
import 'package:radix_mobile_project/model/endereco.dart';
import 'package:radix_mobile_project/model/item.dart';
import 'package:radix_mobile_project/model/sharedPreferencesModels.dart';
import 'package:radix_mobile_project/providers/adressProvider.dart';
import 'package:radix_mobile_project/providers/cartProvider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/cupomProvider.dart';
import 'package:radix_mobile_project/providers/paymentProvider.dart';
import 'package:radix_mobile_project/providers/pedidoProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../components/button.dart';

class FinalizarCompra extends StatefulWidget {
  const FinalizarCompra({Key? key}) : super(key: key);

  @override
  State<FinalizarCompra> createState() => _FinalizarCompraState();
}

class _FinalizarCompraState extends State<FinalizarCompra> {
  final pagamentoController = TextEditingController();
  final enderecoController = TextEditingController();
  final cuponController = TextEditingController();
  String? selectedPagamento = '';
  String? selectedEndereco = '';
  String? selectedCupom = '';
  bool _isLoading = true;
  String _pagamentoValue = 'Dinheiro';

  @override
  void initState() {
    super.initState();
    Provider.of<PaymentProvider>(context, listen: false).loadCartoes();
    Provider.of<CupomProvider>(context, listen: false).loadClientCupons(Provider.of<ClientProvider>(context, listen: false).getUser.idCliente);
    Provider.of<AdressProvider>(context, listen: false).loadEnderecos(Provider.of<ClientProvider>(context, listen: false).getUser.idCliente).then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _openSucessoModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .80,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(132, 202, 157, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: constraints.maxHeight * .06),
                      Text(
                        'Pedido Finalizado!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: constraints.maxHeight * .065,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      SvgPicture.asset('assets/svg/undraw_partying.svg', height: constraints.maxHeight * .40),
                      SizedBox(height: constraints.maxHeight * .06),
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth * .03),
                        child: Text(
                          'Obrigado pela preferência!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: constraints.maxHeight * .040,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .12),
                      Button(
                        text: 'Ir para Home',
                        onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOMETAB),
                        height: constraints.maxHeight * .08,
                        width: constraints.maxWidth * .6,
                        color: false,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _listaDeItems = ModalRoute.of(context)?.settings.arguments as List<Item>;
    List<dynamic> _pagamentos = Provider.of<PaymentProvider>(context).getCartoesSharedPreferences();
    List<Endereco> _enderecos = Provider.of<AdressProvider>(context).getEnderecos();
    List<Cupom> _cupons = Provider.of<CupomProvider>(context).getCuponsCliente();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Finalizar Compra',
          style: TextStyle(
            color: Color.fromRGBO(132, 202, 157, 1),
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * .05),
                      //Método de Pagamentos
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth * .05),
                        child: Text(
                          'Método de Pagamento',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * .03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .03),
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxHeight * .03),
                        child: SizedBox(
                          width: constraints.maxWidth * .9,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'Dinheiro',
                                    groupValue: _pagamentoValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _pagamentoValue = value as String;
                                      });
                                    },
                                    activeColor: Theme.of(context).colorScheme.primary,
                                  ),
                                  Text('Dinheiro'),
                                  Radio(
                                    value: 'Cartão',
                                    groupValue: _pagamentoValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _pagamentoValue = value as String;
                                      });
                                    },
                                    activeColor: Theme.of(context).colorScheme.primary,
                                  ),
                                  Text('Cartão'),
                                ],
                              ),
                              _pagamentoValue == 'Dinheiro'
                                  ? Center()
                                  : Column(
                                      children: [
                                        SizedBox(height: constraints.maxHeight * .02),
                                        DropdownButtonFormField(
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: constraints.maxWidth * .03),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                          hint: Text(_pagamentos.isEmpty ? 'Você não possui cartões' : 'Cartões'),
                                          items: _pagamentos
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  child: Text(e.apelidoCartao as String),
                                                  value: e.apelidoCartao as String,
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (item) {
                                            setState(() {
                                              selectedPagamento = item as String?;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .04),
                      //Endereco
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth * .05),
                        child: Text(
                          'Endereço',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * .03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .03),
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxHeight * .03),
                        child: SizedBox(
                          width: constraints.maxWidth * .9,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: constraints.maxWidth * .03),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            hint: Text('Endereço'),
                            items: _enderecos
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.apelidoEndereco),
                                    value: e.apelidoEndereco,
                                  ),
                                )
                                .toList(),
                            onChanged: (item) {
                              setState(() {
                                selectedPagamento = item as String?;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .04),
                      //Cupom
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxWidth * .05),
                        child: Text(
                          'Cupom',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * .03,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .03),
                      Padding(
                        padding: EdgeInsets.only(left: constraints.maxHeight * .03),
                        child: SizedBox(
                          width: constraints.maxWidth * .9,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: constraints.maxWidth * .03),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            hint: Text(_cupons.isEmpty ? 'Você não possui cupons' : 'Cupom'),
                            items: _cupons
                                .map(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.tituloCupom),
                                    value: e.tituloCupom,
                                  ),
                                )
                                .toList(),
                            onChanged: (item) {
                              setState(() {
                                selectedPagamento = item as String?;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .04),
                      SizedBox(height: constraints.maxHeight * .02),
                      Divider(
                        height: 12,
                        color: Theme.of(context).colorScheme.primary,
                        indent: 40,
                        endIndent: 40,
                      ),
                      SizedBox(height: constraints.maxHeight * .03),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * .1,
                          vertical: constraints.maxHeight * .02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Subtotal',
                            ),
                            Text('R\$ ${Provider.of<CartProvider>(context).getTotal()}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * .1,
                          vertical: constraints.maxHeight * .02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Frete',
                              style: TextStyle(
                                color: Color.fromRGBO(132, 202, 157, 1),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('R\$ 10.00'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * .1,
                          vertical: constraints.maxHeight * .02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text('R\$ ${Provider.of<CartProvider>(context).getTotal() + 10.00}'),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .05),
                      Center(
                        child: Button(
                          text: 'Finalizar Compra',
                          onTap: () {
                            Provider.of<PedidoProvider>(context, listen: false).addPedido(context, DateTime.now(), Provider.of<ClientProvider>(context, listen: false).user.idCliente, _listaDeItems[0].vendedor.idVendedor);
                            _openSucessoModalSheet(context);
                          },
                          height: constraints.maxHeight * .08,
                          width: constraints.maxWidth * .6,
                          color: true,
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .1),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
