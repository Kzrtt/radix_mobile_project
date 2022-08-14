import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:radix_mobile_project/model/chat.dart';

import '../model/produtos.dart';
import '../model/vendedor.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> getChats() => [..._chats];

  Future<void> loadChats(int id) async {
    _chats.clear();
    var response = await Dio().get('http://localhost:8000/api/getChats/$id');

    response.data['chats'].forEach(
      (e) {
        Chat chat = Chat(
          idChat: e['idConversa'],
          idCliente: e['idCliente'],
          idVendedor: e['idVendedor'],
        );

        if (_chats.any((element) => element.idChat == chat.idChat)) {
          print('_');
        } else {
          _chats.add(chat);
        }
      },
    );
  }
}
