import 'package:flutter/material.dart';
import '../../../../Model/msg.dart';
import '../../../../ViewModel/chat_room_view_model.dart';
import '../../../Dialog/message_dialog.dart';

class ChatRoomMsgTile extends StatelessWidget {
  final ChatRoomViewModel chatRoomViewModel;
  final Msg message;
  const ChatRoomMsgTile({super.key, required this.chatRoomViewModel, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 다이얼로그 표시
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => MessageDialog(
            msgId: message.id, // 메시지 ID 전달
            chatRoomViewModel: chatRoomViewModel, // ChatRoomViewModel 전달
          ),
        );
      },
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!message.isUser)
              Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: Icon(Icons.person, size: 20, color: Colors.grey.shade700),
              ),
            if (message.isUser) // User가 아닌 경우 시간 표시
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  _formatDateTime(message.time),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.grey),
                ),
              ),
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 30,
                  maxWidth: MediaQuery.of(context).size.width * 0.6,
                ),
                margin: message.isUser? const EdgeInsets.only(top: 10, bottom: 10,right:10): const EdgeInsets.only(top: 10, bottom: 10,left:10),
                padding: const EdgeInsets.only(top:5,bottom: 5,left: 10, right:10),
                decoration: BoxDecoration(
                  color: message.isUser ? Colors.yellow.shade600 : Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  message.msg,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                ),
              ),
            ),
            if (!message.isUser) // User인 경우 시간 표시
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Text(
                  _formatDateTime(message.time),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // DateTime 포맷 메서드
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}

