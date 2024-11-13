import 'package:flutter/material.dart';
import '../../../ViewModel/chat_room_view_model.dart';


class ChatRoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatRoomViewModel chatRoomViewModel;

  const ChatRoomAppBar({super.key, required this.chatRoomViewModel});

  @override
  Widget build(BuildContext context) {
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