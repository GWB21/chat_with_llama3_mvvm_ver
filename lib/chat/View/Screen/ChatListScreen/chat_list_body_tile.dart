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
    // ChatListViewModel을 통해 ChatRoomViewModel 가져오기
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);
    final chatRoomViewModel = chatListViewModel.getChatRoomViewModel(chatRoomId);

    return ListTile(
      leading: chatRoomViewModel.profImg,
      title: Row(
        children: [
          Text(
            chatRoomViewModel.agentName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (chatRoomViewModel.chatRoom.isSticky)
            const Icon(Icons.push_pin, size: 16, color: Colors.grey),
        ],
      ),
      subtitle: Text(
        chatRoomViewModel.lastMsg.msg,
      ),
      trailing: SizedBox(
        width: 50, // 원하는 너비로 설정
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatDateTime(chatRoomViewModel.lastMsg.time),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              child: Align(
                alignment: Alignment.center, // 텍스트를 중앙에 배치
                child: Text(
                  '${chatRoomViewModel.chatRoom.msgList.length}', // 메시지 수 표시
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10, // 글자 크기
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider.value(
              value: chatRoomViewModel,
              child: ChatRoomView(chatRoomViewModel: chatRoomViewModel),
            ),
          ),
        );
      },
      onLongPress: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => StickOnTopDialog(chatRoomViewModel: chatRoomViewModel),
        );
      },
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}