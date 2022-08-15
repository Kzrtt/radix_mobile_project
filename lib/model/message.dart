class Message {
  final int idMessage;
  final String message;
  final DateTime date;
  final bool isSentFromMe;

  Message({
    required this.idMessage,
    required this.message,
    required this.date,
    required this.isSentFromMe,
  });
}
