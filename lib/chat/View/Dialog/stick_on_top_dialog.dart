import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/chat_list_view_model.dart';
import '../../ViewModel/chat_room_view_model.dart';


class StickOnTopDialog extends StatelessWidget {

  const StickOnTopDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final chatRoomViewModel = Provider.of<ChatRoomViewModel>(context, listen: false);
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);
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
