import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/components/chatTile.dart';
import 'package:radix_mobile_project/components/defaultTile.dart';
import 'package:radix_mobile_project/components/textPlusImage.dart';
import 'package:radix_mobile_project/components/trailingTile.dart';
import 'package:radix_mobile_project/model/vendedor.dart';
import 'package:radix_mobile_project/providers/chatProvider.dart';
import 'package:radix_mobile_project/providers/clientProvider.dart';
import 'package:radix_mobile_project/providers/salesmanProvider.dart';
import 'package:radix_mobile_project/utils/appRoutes.dart';

import '../model/chat.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).loadChats(
      Provider.of<ClientProvider>(context, listen: false).getUser.idCliente,
    );
    Provider.of<SalesmanProvider>(context, listen: false)
        .loadVendedores()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Chat> _chats = Provider.of<ChatProvider>(context).getChats();
    List<Vendedor> _vendedores =
        Provider.of<SalesmanProvider>(context).getVendedores();

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
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _chats.isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: constraints.maxHeight * .05),
                              TextPlusImage(
                                firstText: 'Você não possui nenhuma conversa',
                                imgUrl: 'assets/svg/undraw_not_found.svg',
                                height: constraints.maxWidth * .5,
                                secondText:
                                    'Converse com os vendedores caso tenha alguma duvida',
                                constraints: constraints,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: constraints.maxHeight * .01),
                              SizedBox(
                                height: 1000,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: _chats.length,
                                  itemBuilder: (context, index) {
                                    Chat c = _chats[index];
                                    Vendedor v = _vendedores.firstWhere(
                                        (element) =>
                                            element.idVendedor == c.idVendedor);
                                    return InkWell(
                                      onTap: () {
                                        Provider.of<ChatProvider>(context,
                                                listen: false)
                                            .setIdConversa(c.idChat);
                                        Navigator.of(context).pushNamed(
                                          AppRoutes.INSIDECHAT,
                                          arguments: v,
                                        );
                                      },
                                      child: ChatTile(
                                        id: c.idChat,
                                        title: v.nomeVendedor,
                                        subTitle:
                                            'Colocar ultima mensagem enviada',
                                        leadingIcon: Icons.abc,
                                        trailingIcon: Icons.more_vert,
                                        color: false,
                                        constraints: constraints,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
              ],
            ),
          );
        },
      ),
    );
  }
}
