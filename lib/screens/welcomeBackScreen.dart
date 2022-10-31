import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/data/dummyData.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../model/cliente.dart';

class WelcomeBackScreen extends StatefulWidget {
  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final senhaFormController = TextEditingController();
  final senhaFormValidationController = TextEditingController();
  final nomeFormController = TextEditingController();
  final emailFormController = TextEditingController();
  final cpfFormController = TextEditingController();
  bool showPassword = false;

  Future<void> getLoginInfo(String email, String senha, constraints) async {
    try {
      var response = await Dio().get('http://localhost:8000/api/loginCliente/$email/$senha');

      String loginResult = response.data['loginResult'];
      print(response.data);

      if (loginResult == '1') {
        Navigator.pushReplacementNamed(context, AppRoutes.HOMETAB);
        Cliente user = Cliente(
          idCliente: response.data['user']['idCliente'],
          nomeCliente: response.data['user']['nomeCliente'],
          cpfCliente: response.data['user']['cpfCliente'],
          emailCliente: response.data['user']['emailCliente'],
          senhaCliente: response.data['user']['senhaCliente'],
        );
        Provider.of<ClientProvider>(context, listen: false).changeUser(user);
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(loginResult, style: TextStyle(fontSize: constraints.maxWidth * .04)),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void createClient(String senha, String validaSenha, String nome, String cpf, String email, constraints) async {
    try {
      if (senhaFormController.text == senhaFormValidationController.text) {
        var response = await Dio().post(
          'http://localhost:8000/api/inserirCliente',
          data: {
            'nomeCliente': nome,
            'cpfCliente': cpf,
            'emailCliente': email,
            'senhaCliente': senha,
            'statusCliente': '1',
          },
        );
        if (response.data['status'] == '400') {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(response.data['message'], style: TextStyle(fontSize: constraints.maxWidth * .04)),
            ),
          );
        } else {
          print(response.data['message']);
          Navigator.of(context).pop();
        }
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('As senhas não são iguais', style: TextStyle(fontSize: constraints.maxWidth * .04)),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _textField(double height, double width, BoxConstraints constraints, String text, TextEditingController controller, bool obscure) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        obscureText: obscure,
        obscuringCharacter: '*',
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: constraints.maxWidth * .03),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: constraints.maxHeight * .02,
          ),
        ),
      ),
    );
  }

  Widget _textField2(double height, double width, BoxConstraints constraints, String text, TextEditingController controller, bool obscure) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        obscureText: showPassword ? !obscure : obscure,
        obscuringCharacter: '*',
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: constraints.maxWidth * .03),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            child: Icon(
              showPassword ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          hintText: text,
          hintStyle: TextStyle(
            fontSize: constraints.maxHeight * .02,
          ),
        ),
      ),
    );
  }

  void _openAdClientModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .75,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * .05),
                      Center(
                        child: Text(
                          'Bem-Vindo a bordo!',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * .035,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * .08),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu nome', nomeFormController, false),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu email', emailFormController, false),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'seu cpf', cpfFormController, false),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'senha', senhaFormController, false),
                      SizedBox(height: constraints.maxHeight * .02),
                      _textField(constraints.maxHeight * .1, constraints.maxWidth * .90, constraints, 'confirme sua senha', senhaFormValidationController, false),
                      SizedBox(height: constraints.maxHeight * .02),
                      SizedBox(height: constraints.maxHeight * .10),
                      Button(
                        text: 'Registrar-se',
                        onTap: () => createClient(
                          senhaFormController.text,
                          senhaFormValidationController.text,
                          nomeFormController.text,
                          cpfFormController.text,
                          emailFormController.text,
                          constraints,
                        ),
                        height: constraints.maxHeight * .1,
                        width: constraints.maxWidth * .75,
                        color: true,
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/bolas_verdes.png')),
                SizedBox(height: constraints.maxHeight * .001),
                Text(
                  'Bem-vindo de volta!',
                  style: TextStyle(
                    fontSize: constraints.maxHeight * .03,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .03),
                SvgPicture.asset(
                  'assets/svg/undraw_login.svg',
                  height: constraints.maxHeight * .25,
                ),
                SizedBox(height: constraints.maxHeight * .04),
                _textField(constraints.maxHeight * .08, constraints.maxWidth * .90, constraints, 'Email', emailController, false),
                SizedBox(height: constraints.maxHeight * .01),
                _textField2(constraints.maxHeight * .08, constraints.maxWidth * .90, constraints, 'Senha', senhaController, true),
                SizedBox(height: constraints.maxHeight * .03),
                Button(
                  text: 'Entrar',
                  onTap: () => getLoginInfo(
                    emailController.text,
                    senhaController.text,
                    constraints,
                  ),
                  height: constraints.maxHeight * .07,
                  width: constraints.maxWidth * .7,
                  color: true,
                ),
                SizedBox(height: constraints.maxHeight * .03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ainda não tem uma conta ?',
                      style: TextStyle(fontSize: constraints.maxHeight * .02, color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                    InkWell(
                      onTap: () => _openAdClientModalSheet(context),
                      child: Text(
                        '   Clique aqui',
                        style: TextStyle(
                          fontSize: constraints.maxHeight * .02,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * .01),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                      fontSize: constraints.maxHeight * .02,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
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
