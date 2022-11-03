import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/iten.dart';
import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/pedidoProvider.dart';
import 'package:radix_mobile_project/providers/salesmanProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/textPlusImage.dart';
import '../model/pedido.dart';
import '../model/vendedor.dart';
import 'dart:math' as math;

class HistoricScreen extends StatefulWidget {
  @override
  State<HistoricScreen> createState() => _HistoricScreenState();
}

class _HistoricScreenState extends State<HistoricScreen> {
  bool _isLoading = true;
  Map<int, List<Iten>> _itemsPedidos = {};
  Widget icon = Icon(Icons.expand_more);
  int valorTotal = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<PedidoProvider>(context, listen: false).loadAllProdutos();
    Provider.of<PedidoProvider>(context, listen: false)
        .loadPedidos(
      Provider.of<ClientProvider>(context, listen: false).getUser.idCliente,
    )
        .then((value) {
      for (var pedido in value) {
        int _x = pedido.idPedido;
        List<Iten> _items = [];
        Provider.of<PedidoProvider>(context, listen: false).loadPedidosItems(_x).then((value) {
          _items = value;
          _itemsPedidos[pedido.idPedido] = _items;
        });
      }
    });

    Provider.of<SalesmanProvider>(context, listen: false).loadVendedores().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void chamar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('teste'));
  }

  @override
  Widget build(BuildContext context) {
    List<Pedido> _pedidos = Provider.of<PedidoProvider>(context).getPedidos();
    List<Vendedor> _vendedores = Provider.of<SalesmanProvider>(context).getVendedores();
    List<Produtos> _produtos = Provider.of<PedidoProvider>(context).getProdutos();

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _pedidos.isEmpty
              ? LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        SizedBox(height: constraints.maxHeight * .15),
                        TextPlusImage(
                          firstText: 'Nenhum pedido realizado',
                          imgUrl: 'assets/svg/undraw_feeling_blue.svg',
                          height: constraints.maxWidth * .5,
                          secondText: 'As compras feitas no app irão aparecer aqui quando finalizadas',
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
                            itemCount: _pedidos.length,
                            itemBuilder: (context, index) {
                              Pedido p = _pedidos[index];
                              Vendedor v = _vendedores.singleWhere((element) => element.idVendedor == p.idVendedor);
                              List<Iten> itens = _itemsPedidos[p.idPedido] as List<Iten>;
                              return Column(
                                children: [
                                  Container(
                                    width: constraints.maxWidth * .95,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Color.fromRGBO(237, 233, 232, .7),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: ExpansionTile(
                                        backgroundColor: const Color.fromRGBO(237, 233, 232, .7),
                                        title: Text(
                                          v.nomeVendedor,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: constraints.maxHeight * .03,
                                          ),
                                        ),
                                        subtitle: Text(
                                          'data: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(p.data))}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: constraints.maxHeight * .025,
                                          ),
                                        ),
                                        tilePadding: EdgeInsets.all(constraints.maxHeight * .022),
                                        children: [
                                          SizedBox(
                                            height: constraints.maxHeight * .035 * itens.length,
                                            width: constraints.maxWidth,
                                            child: ListView.builder(
                                              itemCount: itens.length,
                                              itemBuilder: (context, index) {
                                                Iten i = itens[index];
                                                Produtos z = _produtos.singleWhere((element) => element.idProduto == i.idProduto);
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'nome: ',
                                                      style: TextStyle(fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '${z.nomeProduto}, ',
                                                    ),
                                                    const Text(
                                                      ' preço: ',
                                                      style: TextStyle(fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '${z.preco}, ',
                                                    ),
                                                    const Text(
                                                      ' quantidade: ',
                                                      style: TextStyle(fontWeight: FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '${i.qntdItem} ',
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: constraints.maxHeight * .03),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: constraints.maxWidth * .75,
                                              bottom: constraints.maxHeight * .02,
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor: Theme.of(context).colorScheme.primary,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: constraints.maxHeight * .02),
                                ],
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),
    );
  }
}
