import 'package:flutter/material.dart';
import '../../../../Model/msg.dart';
import '../../../../ViewModel/chat_room_view_model.dart';

class ChatRoomMsgTile extends StatelessWidget {
  final ChatRoomViewModel chatRoomViewModel;
  final Msg message;
  const ChatRoomMsgTile({super.key, required this.chatRoomViewModel, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // showdialog작업 필요..
      onLongPress: () {
        chatRoomViewModel.setStickyMessage(message);
      },
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          leading: message.isUser
              ? null
              : chatRoomViewModel.chatRoom.profImg, // 시스템 메시지 프로필 이미지
          title: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: message.isUser ? Colors.yellow.shade600 : Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              message.msg,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          subtitle: !message.isUser
              ? Text(
            chatRoomViewModel.chatRoom.agentName, // agentName 표시
            style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.black),
          )
              : null,
          trailing: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              _formatDateTime(message.time),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  // DateTime 포맷 메서드
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

