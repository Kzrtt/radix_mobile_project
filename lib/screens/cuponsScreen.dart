import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/model/cupom.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/cupomProvider.dart';
import '../components/defaultTile.dart';
import '../components/textPlusImage.dart';

class CuponScreen extends StatefulWidget {
  @override
  State<CuponScreen> createState() => _CuponScreenState();
}

class _CuponScreenState extends State<CuponScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<CupomProvider>(context, listen: false)
        .loadClientCupons(
      Provider.of<ClientProvider>(context, listen: false).getUser.idCliente,
    )
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Cupom> _cupons =
        Provider.of<CupomProvider>(context).getCuponsCliente();

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _cupons.isEmpty
              ? LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * .15),
                      TextPlusImage(
                        firstText: 'Você não possui nenhum cupom',
                        imgUrl: 'assets/svg/undraw_feeling_blue.svg',
                        height: constraints.maxWidth * .5,
                        secondText:
                            'Cupons de desconto aparecem no mínimo 1 vez por mês',
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
                            itemCount: _cupons.length,
                            itemBuilder: (context, index) {
                              final e = _cupons[index];
                              return Column(
                                children: [
                                  SizedBox(height: constraints.maxHeight * .02),
                                  DefaultTile(
                                    leadingIcon:
                                        Icons.local_attraction_outlined,
                                    constraints: constraints,
                                    subTitle: e.detalheCupom,
                                    title: e.tituloCupom,
                                  ),
                                  SizedBox(
                                      height: constraints.maxHeight * .001),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: constraints.maxWidth * .6),
                                      Text(
                                        'Vencimento: ${e.dtFim}',
                                        style: TextStyle(
                                          fontSize: constraints.maxHeight * .02,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}
