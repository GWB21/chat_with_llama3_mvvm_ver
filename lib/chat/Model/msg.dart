import 'package:uuid/uuid.dart';

class Msg {
  final String id;
  final String msg;
  final DateTime time;
  final bool isUser;

  Msg({
    String? id,
    required this.msg,
    DateTime? time,
    this.isUser = true,
  })  : id = id ?? const Uuid().v4(),
        time = time ?? DateTime.now();

  // Convert Msg object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'msg': msg,
      'time': time.toIso8601String(),
      'isUser': isUser,
    };
  }

  // Create Msg object from JSON
  factory Msg.fromJson(Map<String, dynamic> json) {
    return Msg(
      id: json['id'],
      msg: json['msg'],
      time: DateTime.parse(json['time']),
      isUser: json['isUser'],
    );
  }
}