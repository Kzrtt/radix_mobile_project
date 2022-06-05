import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/favoriteTile.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/data/dummyData.dart';

import '../components/textPlusImage.dart';
import '../model/produtos.dart';
import '../model/vendedor.dart';
import '../utils/appRoutes.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _currentIndex = 3;
  final List<Vendedor> _vendedoresFavoritos = [
    const Vendedor(
      idVendedor: 1,
      nomeVendedor: 'Carlos',
      cpfCnpjVendedor: '123.456.789-01',
      emailVendedor: 'vendedor1@gmail.com',
      senhaVendedor: 'SenhaV123-1',
      urlImagemVendedor: '',
      enderecoVendedor: 'Rua Um, n°11',
      statusContaVendedor: false,
      selo: 5.0,
      produtosVendedor: <Produtos>[
        Produtos(
          idProduto: 1,
          nomeProduto: 'Alface',
          urlFoto: '',
          detalheProduto: 'Alface americano colhido hoje',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 2,
          nomeProduto: 'Morangos',
          urlFoto: '',
          detalheProduto: 'Morangos vermelhos e doces',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 3,
          nomeProduto: 'Amoras',
          urlFoto: '',
          detalheProduto: 'Amoras colhidas hoje',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 4,
          nomeProduto: 'Bananas',
          urlFoto: '',
          detalheProduto: 'Banana nanica madura',
          statusProduto: true,
        ),
      ],
    ),
    const Vendedor(
      idVendedor: 2,
      nomeVendedor: 'João',
      cpfCnpjVendedor: '123.456.789-02',
      emailVendedor: 'vendedor2@gmail.com',
      senhaVendedor: 'SenhaV123-2',
      urlImagemVendedor: '',
      enderecoVendedor: 'Rua Dois, n°12',
      statusContaVendedor: true,
      selo: 2.0,
      produtosVendedor: <Produtos>[
        Produtos(
          idProduto: 1,
          nomeProduto: 'Tomate',
          urlFoto: '',
          detalheProduto: 'Tomate cerejas',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 2,
          nomeProduto: 'Morangos',
          urlFoto: '',
          detalheProduto: 'Morangos vermelhos e doces',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 3,
          nomeProduto: 'Cenouras',
          urlFoto: '',
          detalheProduto: 'Cenoura da terra',
          statusProduto: false,
        ),
        Produtos(
          idProduto: 4,
          nomeProduto: 'Bananas',
          urlFoto: '',
          detalheProduto: 'Banana nanica madura',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 3,
          nomeProduto: 'Amoras',
          urlFoto: '',
          detalheProduto: 'Amoras colhidas hoje',
          statusProduto: true,
        ),
      ],
    ),
    const Vendedor(
      idVendedor: 3,
      nomeVendedor: 'Maria',
      cpfCnpjVendedor: '123.456.789-03',
      emailVendedor: 'vendedor3@gmail.com',
      senhaVendedor: 'SenhaV123-3',
      urlImagemVendedor: '',
      enderecoVendedor: 'Rua Três, n°13',
      statusContaVendedor: false,
      selo: 1.0,
      produtosVendedor: <Produtos>[
        Produtos(
          idProduto: 1,
          nomeProduto: 'Alface',
          urlFoto: '',
          detalheProduto: 'Alface americano colhido hoje',
          statusProduto: false,
        ),
        Produtos(
          idProduto: 2,
          nomeProduto: 'Abacaxi',
          urlFoto: '',
          detalheProduto: 'Abacaxi maduro e doce',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 3,
          nomeProduto: 'Amoras',
          urlFoto: '',
          detalheProduto: 'Amoras colhidas hoje',
          statusProduto: false,
        ),
        Produtos(
          idProduto: 4,
          nomeProduto: 'Maçã',
          urlFoto: '',
          detalheProduto: 'Maçãs fujis',
          statusProduto: true,
        ),
      ],
    ),
    const Vendedor(
      idVendedor: 4,
      nomeVendedor: 'Larissa',
      cpfCnpjVendedor: '123.456.789-04',
      emailVendedor: 'vendedor4@gmail.com',
      senhaVendedor: 'SenhaV123-4',
      urlImagemVendedor: '',
      enderecoVendedor: 'Rua Quatro, n°14',
      statusContaVendedor: true,
      selo: 3.5,
      produtosVendedor: <Produtos>[
        Produtos(
          idProduto: 1,
          nomeProduto: 'Alface',
          urlFoto: '',
          detalheProduto: 'Alface americano colhido hoje',
          statusProduto: false,
        ),
        Produtos(
          idProduto: 2,
          nomeProduto: 'Morangos',
          urlFoto: '',
          detalheProduto: 'Morangos vermelhos e doces',
          statusProduto: true,
        ),
        Produtos(
          idProduto: 3,
          nomeProduto: 'Amoras',
          urlFoto: '',
          detalheProduto: 'Amoras colhidas com muito carinho e dedicação por Luiz Ricardo, e entregues para você em sua casa em cerca de 35 minutos',
          statusProduto: false,
        ),
        Produtos(
          idProduto: 4,
          nomeProduto: 'Bananas',
          urlFoto: '',
          detalheProduto: 'Banana nanica madura',
          statusProduto: false,
        ),
      ],
    ),
  ];

  void _deleteAdress(String id) {
    setState(() {
      _vendedoresFavoritos.removeWhere((v) => v.idVendedor.toString() == id);
    });
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        elevation: 6,
        backgroundColor: const Color.fromRGBO(132, 202, 157, 1),
        selectedItemColor: const Color.fromRGBO(108, 168, 129, 1),
        iconSize: 28,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState((() => _currentIndex = index));
          switch (_currentIndex) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.HOME);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.SEARCH);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.SHOPPINGCART);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, AppRoutes.PROFILE);
              break;
            default:
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Busca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      firstText: 'Faça sua Pesquisa',
                      imgUrl: 'assets/images/undraw_heart.png',
                      secondText: 'Nenhum vendedor favorito adicionado...',
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
                            padding: EdgeInsets.all(constraints.maxHeight * .02),
                            child: SizedBox(
                              height: constraints.maxHeight * .14,
                              child: ListTile(
                                contentPadding: EdgeInsets.fromLTRB(
                                  0,
                                  constraints.maxHeight * .03,
                                  0,
                                  0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                tileColor: const Color.fromRGBO(237, 233, 232, .7),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  radius: 50,
                                  child: Icon(
                                    Icons.eco_rounded,
                                    size: constraints.maxHeight * .06,
                                    color: Colors.green,
                                  ),
                                ),
                                title: Text(
                                  v.nomeVendedor,
                                  style: TextStyle(
                                    fontSize: constraints.maxHeight * .035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(right: constraints.maxWidth * .04),
                                  child: IconButton(
                                    onPressed: () => _deleteAdress(v.idVendedor.toString()),
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
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
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
