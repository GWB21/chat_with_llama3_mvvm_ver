import 'package:chat_with_llama3_mvc_pattern/main.dart';
import 'package:flutter/material.dart';
import 'msg.dart';

class ChatRoom{
  final String id;
  final String agentName;
  final Image profImg = Image.asset('lib/asset/IMG_0076.PNG');
  final List<Msg> msgList = [];
  Msg? stickyMsg;
  late bool isSticky;
  bool isNoticeExpanded = false;  // expanded 상태 추가

  ChatRoom({
    required this.id,
    required this.agentName,
    required this.isSticky,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'agentName': agentName,
      'isSticky': isSticky,
      // Add other fields as necessary
    };
  }

  static Future<ChatRoom> fromJson(Map<String, dynamic> json) async {
    final chatRoom = ChatRoom(
      id: json['id'],
      agentName: json['agentName'],
      isSticky: json['isSticky'], // Default to false if not present
    );

    // Load messages and stickyMsg from the log file
    await globalLocalDataSource.loadChatRoomMessages(chatRoom);

    return chatRoom;
  }
}