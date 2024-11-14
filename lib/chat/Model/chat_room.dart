import 'package:flutter/material.dart';
import 'msg.dart';

class ChatRoom with ChangeNotifier {
  final String id;
  final String agentName;
  final Image profImg = Image.asset('lib/asset/IMG_0076.PNG');
  final List<Msg> msgList = [];
  Msg? stickyMsg;
  bool isSticky = false;

  ChatRoom({
    required this.id,
    required this.agentName,
  });
}