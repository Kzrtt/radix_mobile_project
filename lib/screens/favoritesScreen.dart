import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/salesmanProvider.dart';
import '../components/textPlusImage.dart';
import '../model/vendedor.dart';
import '../utils/appRoutes.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Vendedor> _vendedoresFavoritos =
        context.watch<ClientProvider>().getVendedoresFavoritos;

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
          'Favoritos',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: _vendedoresFavoritos.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: constraints.maxHeight * .1),
                    TextPlusImage(
                      firstText: 'Marque um vendedor como favorito',
                      imgUrl: 'assets/svg/undraw_appreciation.svg',
                      height: constraints.maxHeight * .3,
                      secondText:
                          'Adicione os vendedores que voçê compra com mais frequencia',
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
                    SizedBox(height: constraints.maxHeight * .03),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _vendedoresFavoritos.length,
                        itemBuilder: (context, index) {
                          final v = _vendedoresFavoritos[index];
                          return Padding(
                            padding:
                                EdgeInsets.all(constraints.maxHeight * .02),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.SALESMANPROFILE,
                                    arguments: v);
                              },
                              child: SizedBox(
                                height: constraints.maxHeight * .14,
                                child: ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(
                                    0,
                                    constraints.maxHeight * .0,
                                    0,
                                    0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  tileColor:
                                      const Color.fromRGBO(237, 233, 232, .7),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    radius: 50,
                                    child: context
                                        .watch<SalesmanProvider>()
                                        .iconSeloProdutor(v.selo, constraints),
                                  ),
                                  title: Text(
                                    v.nomeVendedor,
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * .035,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(
                                        right: constraints.maxWidth * .04),
                                    child: IconButton(
                                      onPressed: () =>
                                          Provider.of<ClientProvider>(context,
                                                  listen: false)
                                              .removeFromFavorites(
                                                  v.idVendedor.toString()),
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
