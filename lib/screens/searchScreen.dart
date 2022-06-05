// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/salesmanTile.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/model/produtos.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';
import '../data/dummyData.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool searchStatus = true;
  final searchController = TextEditingController();
  int _currentIndex = 1;

  List<Vendedor> _salesmanList = [];

  List<Vendedor> _onSearched(List<Vendedor> list, String product) {
    List<Vendedor> v = [];

    setState(() {
      _salesmanList.clear();
    });

    for (var i = 0; i < list.length; i++) {
      for (var j = 0; j < list[i].produtosVendedor.length; j++) {
        if (list[i].produtosVendedor[j].nomeProduto.toUpperCase() == product.toUpperCase()) {
          if (list[i].statusContaVendedor == false) {
            break;
          } else {
            v.add(list[i]);
          }

          // v.add(list[i]);
        }
      }
    }

    return v;
  }

  Row _seloProdutos(double seloValue) {
    Row row = Row(
      children: [
        Text(
          seloValue.toString(),
          style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
        ),
        Icon(Icons.eco_sharp, color: Colors.cyan),
      ],
    );

    if (0 < seloValue && seloValue <= 1) {
      row = Row(
        children: [
          Text(
            seloValue.toString(),
            style: TextStyle(color: Colors.red),
          ),
          Icon(Icons.eco_sharp, color: Colors.red),
        ],
      );
    } else if (1 < seloValue && seloValue <= 2) {
      row = Row(
        children: [
          Text(
            seloValue.toString(),
            style: TextStyle(color: Colors.orange),
          ),
          Icon(Icons.eco_sharp, color: Colors.orange),
        ],
      );
    } else if (2 < seloValue && seloValue <= 3) {
      row = Row(
        children: [
          Text(
            seloValue.toString(),
            style: TextStyle(color: Colors.yellow),
          ),
          Icon(Icons.eco_sharp, color: Colors.yellow),
        ],
      );
    } else if (3 < seloValue && seloValue <= 4) {
      row = Row(
        children: [
          Text(
            seloValue.toString(),
            style: TextStyle(color: Colors.green),
          ),
          Icon(Icons.eco_sharp, color: Colors.green),
        ],
      );
    } else if (4 < seloValue && seloValue <= 5) {
      row = Row(
        children: [
          Text(
            seloValue.toString(),
            style: TextStyle(color: Colors.cyan),
          ),
          Icon(Icons.eco_sharp, color: Colors.cyan),
        ],
      );
    }

    return row;
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        topLeft: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        elevation: 6,
        backgroundColor: Color.fromRGBO(132, 202, 157, 1),
        selectedItemColor: Color.fromRGBO(108, 168, 129, 1),
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

  final appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 4,
    title: const Center(
      child: Text(
        'Busca',
        style: TextStyle(color: Color.fromRGBO(108, 168, 129, 1)),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .04),
                Center(
                  child: SizedBox(
                    height: constraints.maxHeight * .12,
                    width: constraints.maxWidth * .95,
                    child: TextField(
                      onChanged: ((value) => _salesmanList = _onSearched(DUMMY_SALESMAN, value)),
                      controller: searchController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 0.90), width: constraints.maxWidth * .03),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () => _salesmanList = _onSearched(DUMMY_SALESMAN, searchController.text),
                          child: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(108, 168, 129, 1),
                          ),
                        ),
                        hintText: 'Pesquisar vendedores ou produtos',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                _salesmanList.isEmpty
                    ? Column(
                        children: [
                          TextPlusImage(
                            firstText: 'Faça sua Pesquisa',
                            imgUrl: 'assets/images/undraw_Searching_re_3ra9.png',
                            secondText: 'Procure produtos para compra e vendedores para contato',
                            constraints: constraints,
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: SizedBox(
                          width: constraints.maxWidth * 1,
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _salesmanList.length,
                                itemBuilder: (context, index) {
                                  final v = _salesmanList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.SALESMANPROFILE,
                                        arguments: v,
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(constraints.maxHeight * .02),
                                      child: SizedBox(
                                        height: constraints.maxHeight * .14,
                                        child: ListTile(
                                          contentPadding: EdgeInsets.fromLTRB(constraints.maxWidth * .001, constraints.maxHeight * .010, 0, 0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          tileColor: const Color.fromRGBO(237, 233, 232, .7),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.black12,
                                            radius: 50,
                                            child: Icon(
                                              Icons.abc,
                                              size: constraints.maxHeight * .06,
                                              color: const Color.fromRGBO(108, 168, 129, 1),
                                            ),
                                          ),
                                          title: Text(
                                            v.nomeVendedor,
                                            style: TextStyle(
                                              fontSize: constraints.maxHeight * .035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            v.enderecoVendedor,
                                            style: TextStyle(
                                              fontSize: constraints.maxHeight * .025,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          trailing: Padding(
                                            padding: EdgeInsets.fromLTRB(0, constraints.maxHeight * .020, 0, constraints.maxWidth * .01),
                                            child: SizedBox(
                                              width: constraints.maxWidth * .14,
                                              child: Column(
                                                children: [
                                                  _seloProdutos(v.selo),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                SizedBox(height: constraints.maxHeight * .25),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
