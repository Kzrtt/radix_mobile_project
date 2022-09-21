import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:radix_mobile_project/providers/chatProvider.dart';

import '../model/message.dart';
import '../model/vendedor.dart';

class InsideChatScreen extends StatefulWidget {
  const InsideChatScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<InsideChatScreen> createState() => _InsideChatScreenState();
}

class _InsideChatScreenState extends State<InsideChatScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false)
        .loadAllMessages(
            Provider.of<ChatProvider>(context, listen: false).getIdConversa())
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
    Timer.periodic(const Duration(seconds: 50), (timer) {
      Provider.of<ChatProvider>(context, listen: false).loadAllMessages(
          Provider.of<ChatProvider>(context, listen: false).getIdConversa());
    });
  }

  @override
  Widget build(BuildContext context) {
    final vendedor = ModalRoute.of(context)?.settings.arguments as Vendedor;
    List<Message> _messages = Provider.of<ChatProvider>(context).getMessages();
    final mensagemController = TextEditingController();
    final borderSide = BorderSide(color: Colors.white, width: 2);

    Widget _clienteMessageBox(Message message, constraints) {
      return Padding(
        padding: EdgeInsets.only(right: constraints.maxWidth * .01),
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          elevation: 8,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          )),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              message.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    Widget _vendedorMessageBox(Message message, constraints) {
      return Padding(
        padding: EdgeInsets.only(right: constraints.maxWidth * .01),
        child: Card(
          color: Colors.white,
          elevation: 8,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              message.message,
              style: const TextStyle(),
            ),
          ),
        ),
      );
    }

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
        title: Text(
          vendedor.nomeVendedor,
          style: const TextStyle(
            color: Color.fromRGBO(108, 168, 129, 1),
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Container(
                        color: const Color.fromARGB(20, 0, 0, 0),
                        height: constraints.maxHeight * .87,
                        width: double.infinity,
                        child: GroupedListView<Message, DateTime>(
                          elements: _messages,
                          groupBy: (message) => DateTime(
                            message.date.year,
                            message.date.month,
                            message.date.day,
                          ),
                          groupHeaderBuilder: (Message message) => SizedBox(
                            height: constraints.maxHeight * .1,
                            child: Center(
                              child: Card(
                                color: Theme.of(context).colorScheme.secondary,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    DateFormat.yMMMd().format(message.date),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          itemBuilder: (context, Message message) => Align(
                            alignment: message.isSentFromMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: message.isSentFromMe
                                ? _clienteMessageBox(message, constraints)
                                : _vendedorMessageBox(message, constraints),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: constraints.maxHeight * .13,
              width: double.infinity,
              child: Row(
                children: [
                  SizedBox(width: constraints.maxWidth * .02),
                  SizedBox(
                    height: constraints.maxHeight * .09,
                    width: constraints.maxWidth * .85,
                    child: TextField(
                      controller: mensagemController,
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
                        hintText: 'Mensagem',
                        hintStyle: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: constraints.maxWidth * .02),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      onPressed: () {
                        Provider.of<ChatProvider>(context, listen: false)
                            .sendMessage(
                          mensagemController.text,
                          Provider.of<ChatProvider>(
                            context,
                            listen: false,
                          ).getIdConversa(),
                          context,
                          constraints,
                        );
                      },
                      icon: const Icon(Icons.arrow_upward_sharp),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
