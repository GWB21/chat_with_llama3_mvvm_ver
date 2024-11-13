import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/chat_list_view_model.dart';

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
            Provider.of<ChatListViewModel>(context, listen: false).addNewChat("New Agent");
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