import 'package:flutter/foundation.dart';
import 'package:radix_mobile_project/model/chat.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> _chats = [];
}
