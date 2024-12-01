import 'package:flutter/material.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatRoomScreen/chat_room_view.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/chat_list_view_model.dart';
import '../../Dialog/stick_on_top_dialog.dart';

class ChatListBodyTile extends StatelessWidget {
  final String chatRoomId; // chatRoomId만 전달받음

  const ChatListBodyTile({
    super.key,
    required this.chatRoomId,
  });

  @override
  Widget build(BuildContext context) {
    final chatListViewModel =
        Provider.of<ChatListViewModel>(context, listen: true);
    final chatRoomViewModel =
        chatListViewModel.getChatRoomViewModel(chatRoomId);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomView(
              chatRoomId: chatRoomId
            ),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StickOnTopDialog(chatRoomId: chatRoomId),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Leading (프로필 이미지)
            SizedBox(
              width: 40,
              height: 40,
              child: chatRoomViewModel.profImg,
            ),
            const SizedBox(width: 16),
            // Title과 Subtitle을 포함하는 중앙 영역
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        chatRoomViewModel.agentName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (chatRoomViewModel.isSticky)
                        const Icon(Icons.push_pin, size: 16, color: Colors.grey),
                    ],
                  ),
                  Text(
                    chatRoomViewModel.lastMsg.msg,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Trailing (시간과 메시지 수)
            SizedBox(
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatDateTime(chatRoomViewModel.lastMsg.time),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${chatRoomViewModel.chatRoom.msgList.length}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    // 오늘 날짜인 경우이거나 1970.01.01 초기화시에는 00:00만 표현
    if (messageDate == today || dateTime == DateTime.fromMillisecondsSinceEpoch(0,isUtc: true)) {
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    }
    // 오늘이 아닌 경우
    else {
      return "${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}";
    }
  }
}
