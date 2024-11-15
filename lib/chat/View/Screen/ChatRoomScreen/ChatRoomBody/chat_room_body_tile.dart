import 'package:flutter/material.dart';
import '../../../../Model/msg.dart';
import '../../../../ViewModel/chat_room_view_model.dart';
import '../../../Dialog/message_dialog.dart';

class ChatRoomMsgTile extends StatelessWidget {
  final ChatRoomViewModel chatRoomViewModel;
  final Msg message;
  const ChatRoomMsgTile(
      {super.key, required this.chatRoomViewModel, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 다이얼로그 표시
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => MessageDialog(
            msgId: message.id,
            chatRoomViewModel: chatRoomViewModel,
          ),
        );
      },
      onLongPress: (){chatRoomViewModel.setStickyMessage(message);},
      onHorizontalDragEnd: (details) {
        // 드래그가 왼쪽으로 이루어졌는지 확인
        if (details.velocity.pixelsPerSecond.dx < -300) { // 음수면 왼쪽
          chatRoomViewModel.removeMessageById(message.id);
          // 여기서 필요한 동작 수행
        }
      },
      child: Align(
        alignment:
            message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 10, // 최소 폭
            maxWidth: MediaQuery.of(context).size.width * 0.8, // 최대 폭
          ),
          child: ListTile(
            leading: message.isUser
                ? Text(
                    _formatDateTime(message.time),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey),
                  )
                : Flexible(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                child: chatRoomViewModel.profImg,
              ),
            ),
            title: message.isUser
                ? null
                : Text(
                    chatRoomViewModel.agentName,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                        ),
                  ),
            subtitle: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.yellow.shade600 : Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                message.msg,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
            ),
            trailing: message.isUser
                ? null
                : Text(
                    _formatDateTime(message.time),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
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
