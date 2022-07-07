import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/button.dart';

import '../utils/appRoutes.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(229, 229, 229, 0.90),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(229, 229, 229, 0.90),
                              width: constraints.maxWidth * .03),
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
                        borderSide: BorderSide(
                            color: const Color.fromRGBO(229, 229, 229, 0.90),
                            width: constraints.maxWidth * .03),
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
    );
  }
}
