import 'package:uuid/uuid.dart';

class Msg {
  final String id = const Uuid().v4();
  final String msg;
  final DateTime time;
  final bool isUser;

  Msg({
    required this.msg,
    DateTime? time,
    this.isUser = true,
  }) : time = time ?? DateTime.now(); // Set time to provided value or DateTime.now() if null
}