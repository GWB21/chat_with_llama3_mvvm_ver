import 'package:chat_with_llama3_mvc_pattern/chat/Model/msg.dart';
import 'package:flutter/material.dart';
import 'chat_room.dart';

class ChatTile {
  final String id;
  final String agentName;
  final Image profImg;
  Msg lastMsg = Msg(msg: 'no conversation'); // 기본 메시지로 초기화
  DateTime lastMsgDateTime = DateTime.now(); // 가장 이른 날짜로 초기화
  int totalMsg = 0; // 메시지 수 초기화
  bool isSticky = false;

  ChatTile({
    required ChatRoom chatRoom,
  })  : id = chatRoom.id,
        agentName = chatRoom.agentName,
        profImg = chatRoom.profImg;
}
