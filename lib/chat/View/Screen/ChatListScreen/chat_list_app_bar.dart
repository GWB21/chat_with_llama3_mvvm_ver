import 'package:flutter/material.dart';
import '../../../ViewModel/chat_list_view_model.dart';
import '../../Dialog/add_new_chat_dialog.dart';

class ChatListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatListViewModel chatListViewModel;

  const ChatListAppBar({super.key, required this.chatListViewModel});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Chatting"),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // 검색 기능 구현
          },
        ),
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline),
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AddNewChatDialog(chatList: chatListViewModel),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            // 세팅 기능 구현
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}