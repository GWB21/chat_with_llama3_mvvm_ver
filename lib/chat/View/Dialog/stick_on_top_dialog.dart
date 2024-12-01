import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/chat_list_view_model.dart';


class StickOnTopDialog extends StatelessWidget {
  final String chatRoomId;
  const StickOnTopDialog({super.key, required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);
    final chatRoomViewModel = chatListViewModel.getChatRoomViewModel(chatRoomId);
    return AlertDialog(
      title: const Text('Stick on top'),
      content: Text("Do you want to put '${chatRoomViewModel.agentName}' on the top of the list?"),
      actions: [
        TextButton(
          onPressed: () {
            chatListViewModel.setSticky(chatRoomViewModel.chatRoom.id);
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
          child: const Text('No'),
        ),

      ],
    );
  }
}
