import 'package:flutter/material.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/ViewModel/chat_room_view_model.dart';

class MessageDialog extends StatelessWidget {
  final String msgId; // 메시지 ID를 전달받음
  final ChatRoomViewModel chatRoomViewModel;

  const MessageDialog({
    super.key,
    required this.msgId,
    required this.chatRoomViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        ListTile(
          title: const Text("Copy"),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Message copied")),
            );
          },
        ),
        ListTile(
          title: const Text("Share..."),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("Delete Message"),
          onTap: () {
            chatRoomViewModel.removeMessageById(msgId); // 메시지 삭제
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text("Stick the Message on Top"),
          onTap: () {
            chatRoomViewModel.setStickyMessage(chatRoomViewModel.getMsgById(msgId)); // 메시지를 상단 고정
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
