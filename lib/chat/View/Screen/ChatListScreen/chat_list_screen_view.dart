import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatRoomScreen/chat_room_view.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/ViewModel/chat_room_view_model.dart';
import 'package:flutter/material.dart';
import '../../../ViewModel/chat_list_view_model.dart';
import 'chat_list_app_bar.dart';

class ChatListScreenView extends StatelessWidget {
  final ChatListViewModel chatListViewModel;
  final ChatRoomViewModel chatRoomViewModel;

  const ChatListScreenView({super.key, required this.chatListViewModel,required this.chatRoomViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ChatListAppBar(chatListViewModel: chatListViewModel), // 전달받은 chatListViewModel 그대로 전달
      ),
      body: ListView.builder(
        itemCount: chatListViewModel.chatTileList.allChatTileList.length,
        itemBuilder: (context, index) {
          final chatTile = chatListViewModel.chatTileList.allChatTileList[index];
          return ListTile(
            leading: chatTile.profImg, // 채팅방 이미지
            title: Text(
              chatTile.agentName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              chatTile.lastMsg.msg.isNotEmpty
                  ? chatTile.lastMsg.msg // 마지막 메시지의 내용 표시
                  : "No conversation",
            ),
            trailing: chatTile.lastMsg.msg.isNotEmpty
                ? Text(
              _formatDateTime(chatTile.lastMsgDateTime),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
            )
                : null,
            onTap: () {
              // 채팅방으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomView(
                    chatRoomViewModel: ChatRoomViewModel(chatRoom: chatTile.chatRoom),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // DateTime 포맷 메서드
  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}