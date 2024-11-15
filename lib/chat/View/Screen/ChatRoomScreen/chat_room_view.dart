import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatRoomScreen/chat_room_app_bar.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatRoomScreen/ChatRoomBody/chat_room_body.dart';
import 'package:flutter/material.dart';
import '../../../ViewModel/chat_room_view_model.dart';

class ChatRoomView extends StatelessWidget {
  final ChatRoomViewModel chatRoomViewModel;
  const ChatRoomView({super.key, required this.chatRoomViewModel});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: ChatRoomAppBar(chatRoomViewModel: chatRoomViewModel),
      body: ChatRoomBody(chatRoomViewModel: chatRoomViewModel),backgroundColor:  Colors.blue.shade200, // 메시지 목록을 StatefulWidget으로 분리
      );
  }
}
