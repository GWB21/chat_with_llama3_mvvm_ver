import 'package:chat_with_llama3_mvc_pattern/chat/ViewModel/chat_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatRoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String chatRoomId;

  const ChatRoomAppBar({super.key, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final chatRoomViewModel = Provider.of<ChatListViewModel>(context, listen:true).getChatRoomViewModel(chatRoomId);
    return AppBar(
      backgroundColor: Colors.blue.shade200,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context); // 뒤로가기 버튼
        },
      ),
      title: Text(chatRoomViewModel.agentName,), // 중앙에 agentName 표시
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // 검색 기능 구현
          },
        ),
        IconButton(
          icon: const Icon(Icons.menu), // 햄버거 메뉴 아이콘
          onPressed: () {
            // 메뉴 기능 구현
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}