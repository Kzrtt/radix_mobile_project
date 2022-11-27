import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:radix_mobile_project/model/chat.dart';
import 'package:radix_mobile_project/model/message.dart';

import '../model/produtos.dart';
import '../model/vendedor.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> _chats = [];
  List<Message> _messages = [];
  int idConversa = 1;
  List<Chat> getChats() => [..._chats];
  List<Message> getMessages() => [..._messages];

  int getIdConversa() => idConversa;
  void setIdConversa(int id) {
    idConversa = id;
  }

  Future<void> loadChats(int id) async {
    _chats.clear();
    var response = await Dio().get('http://10.0.2.2:8000/api/getChats/$id');

    if (response.data['status'] == '201') {
      response.data['chat'].forEach(
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
    } else {
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

    notifyListeners();
  }

  Future<void> loadAllMessages(int id) async {
    _messages.clear();
    var response = await Dio().get('http://10.0.2.2:8000/api/getAllMessages/$id');

    if (response.data['status'] == '200') {
      response.data['msgCliente'].forEach(
        (e) {
          DateTime date = DateFormat('yyyy-MM-dd').parse(e['data']);
          Message mensagem = Message(
            idMessage: e['idMsgCliente'],
            message: e['mensagem'],
            date: date,
            isSentFromMe: true,
          );
          _messages.add(mensagem);
        },
      );
      response.data['msgVendedor'].forEach(
        (e) {
          DateTime date = DateFormat('yyyy-MM-dd').parse(e['data']);
          Message mensagem = Message(
            idMessage: e['idMsgVendedor'],
            message: e['mensagem'],
            date: date,
            isSentFromMe: false,
          );
          _messages.add(mensagem);
        },
      );
    } else if (response.data['status'] == '201') {
      response.data['msgVendedor'].forEach(
        (k, e) {
          DateTime date = DateFormat('yyyy-MM-dd').parse(e['data']);
          Message mensagem = Message(
            idMessage: e['idMsgVendedor'],
            message: e['mensagem'],
            date: date,
            isSentFromMe: false,
          );
          _messages.add(mensagem);
        },
      );
    } else if (response.data['status'] == '202') {
      response.data['msgCliente'].forEach(
        (k, e) {
          DateTime date = DateFormat('yyyy-MM-dd').parse(e['data']);
          Message mensagem = Message(
            idMessage: e['idMsgCliente'],
            message: e['mensagem'],
            date: date,
            isSentFromMe: true,
          );
          _messages.add(mensagem);
        },
      );
    } else {
      print(response.data['message'].toString());
    }
    notifyListeners();
  }

  Future<void> sendMessage(String message, int idConversa, context, constraints) async {
    var response = await Dio().post(
      'http://10.0.2.2:8000/api/sendMessage',
      data: {
        'mensagem': message,
        'data': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'idConversa': idConversa,
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
      loadAllMessages(idConversa);
      notifyListeners();
    }
  }

  String getLastMessage(int idConversa) {
    if (_messages.isEmpty) {
      return 'a conversa está vazia';
    }
    Message latest = _messages[0];
    for (var element in _messages) {
      if (element.date.isAfter(latest.date)) {
        latest = element;
      }
    }
    return latest.message;
  }
}
