import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';

import '../utils/appRoutes.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int _currentIndex = 3;

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
      resizeToAvoidBottomInset: false,
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
          'Feedbacks',
          style: TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * .06),
                Center(
                  child: SizedBox(
                    height: constraints.maxHeight * .09,
                    width: constraints.maxWidth * .95,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(229, 229, 229, 0.90), width: constraints.maxWidth * .03),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintText: 'Seu nome',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .03),
                SizedBox(
                  height: constraints.maxHeight * .46,
                  width: constraints.maxWidth * .95,
                  child: TextField(
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    expands: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: const Color.fromRGBO(229, 229, 229, 0.90), width: constraints.maxWidth * .03),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Digite sua mensagem',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .08),
                Button(
                  text: 'Enviar Feedback',
                  onTap: () {},
                  height: constraints.maxHeight * .09,
                  width: constraints.maxWidth * .7,
                  color: true,
                ),
                SizedBox(height: constraints.maxHeight * .03),
                Button(
                  text: 'Limpar Campos',
                  onTap: () {},
                  height: constraints.maxHeight * .09,
                  width: constraints.maxWidth * .7,
                  color: false,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
