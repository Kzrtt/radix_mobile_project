import 'package:flutter/material.dart';
import 'package:radix_mobile_project/components/defaultTile.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';

import '../utils/appRoutes.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
          'Chats',
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
                        suffixIcon: GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(108, 168, 129, 1),
                          ),
                        ),
                        hintText: 'Buscar',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * .03),
                TrailingTile(
                  constraints: constraints,
                  id: '0',
                  subTitle: 'Ricardinho',
                  title: 'Amoras do Ricardinho',
                  leadingIcon: Icons.abc,
                  trailingIcon: Icons.more_vert,
                  color: false,
                ),
                TrailingTile(
                  id: '0',
                  constraints: constraints,
                  subTitle: 'Maria',
                  title: 'Batatas da Maria',
                  leadingIcon: Icons.abc,
                  trailingIcon: Icons.more_vert,
                  color: false,
                ),
                TrailingTile(
                  id: '0',
                  constraints: constraints,
                  subTitle: 'Luiz Carlos',
                  title: 'Alfaces do Luiz Carlos',
                  leadingIcon: Icons.abc,
                  trailingIcon: Icons.more_vert,
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
