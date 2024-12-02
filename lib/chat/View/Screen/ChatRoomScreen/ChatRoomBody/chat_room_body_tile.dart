import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Model/msg.dart';
import '../../../../ViewModel/chat_list_view_model.dart';
import '../../../Dialog/message_dialog.dart';

class ChatRoomMsgTile extends StatelessWidget {
  final Msg message;
  final String chatRoomId;
  const ChatRoomMsgTile(
      {super.key, required this.message, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final chatRoomViewModel = Provider.of<ChatListViewModel>(context, listen: false).getChatRoomViewModel(chatRoomId);
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => MessageDialog(
            msgId: message.id,
            chatRoomId: chatRoomId,
          ),
        );
      },
      onLongPress: () {
        chatRoomViewModel.setStickyMessage(message);
      },
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < -300) {
          chatRoomViewModel.removeMessageById(message.id);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: message.isUser 
            ? _buildUserMessage(context, message)
            : _buildAgentMessage(context, message, chatRoomViewModel),
      ),
    );
  }

  // 사용자 메시지 위젯
  Widget _buildUserMessage(BuildContext context, Msg message) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,  // 시간을 아래에 정렬
          children: [
            Text(
              _formatDateTime(message.time),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  message.msg,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 에이전트 메시지 위젯
  Widget _buildAgentMessage(BuildContext context, Msg message, chatRoomViewModel) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,  // 프로필 이미지를 위에 정렬
          children: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8.0,top: 5),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: chatRoomViewModel.profImg,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatRoomViewModel.agentName
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            message.msg,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        _formatDateTime(message.time),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
