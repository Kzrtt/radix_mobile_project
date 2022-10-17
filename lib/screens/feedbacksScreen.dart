import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';
import 'package:radix_mobile_project/components/imageContainer.dart';

import '../utils/appRoutes.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final nomeClienteController = TextEditingController();
  final mensagemClienteController = TextEditingController();

  Future<void> sendFeedback(String nome, String mensagem) async {
    var response = await Dio().post(
      'http://localhost:8000/api/inserirFeedback',
      data: {
        'nome': nome,
        'feedback': mensagem,
      },
    );
    nomeClienteController.text = '';
    mensagemClienteController.text = '';
    print(response.data['message']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                      controller: nomeClienteController,
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
                    controller: mensagemClienteController,
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
                  onTap: () => sendFeedback(
                    nomeClienteController.text,
                    mensagemClienteController.text,
                  ).then((value) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * .90,
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
                                      SizedBox(height: constraints.maxHeight * .05),
                                      Center(
                                        child: Text(
                                          'Obrigado por enviar seu Feedback!',
                                          style: TextStyle(
                                            fontSize: constraints.maxHeight * .035,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: constraints.maxHeight * .12),
                                      ImageContainer(
                                        'assets/svg/undraw_partying.svg',
                                        constraints.maxHeight * .4,
                                      ),
                                      SizedBox(height: constraints.maxHeight * .12),
                                      Button(
                                        text: 'Home',
                                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.HOMETAB),
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
                  }),
                  height: constraints.maxHeight * .09,
                  width: constraints.maxWidth * .7,
                  color: true,
                ),
                SizedBox(height: constraints.maxHeight * .03),
              ],
            ),
          );
        },
      ),
    );
  }
}
