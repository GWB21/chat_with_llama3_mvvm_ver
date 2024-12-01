import 'package:flutter/material.dart';
import '../../ViewModel/chat_list_view_model.dart';
import '../Screen/ChatRoomScreen/chat_room_view.dart';
import 'package:provider/provider.dart';

class AddNewChatDialog extends StatefulWidget {

  const AddNewChatDialog({super.key});

  @override
  State<AddNewChatDialog> createState() => _AddNewChatDialogState();
}

class _AddNewChatDialogState extends State<AddNewChatDialog> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);
    return AlertDialog(
      title: const Text('Agent Name'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Write down new name',
          ),
          maxLength: 10,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Agent name cannot be empty';
            }
            final regex = RegExp(r'^[a-zA-Z0-9_]+$');
            if (!regex.hasMatch(value)) {
              return 'Only letters, numbers, and underscores are allowed';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final agentName = _controller.text.trim();
              final newChatRoomId = chatListViewModel.addNewChat(agentName);
              Navigator.of(context).pop(); // 다이얼로그 닫기
              // 새 채팅방으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomView(
                    chatRoomId: newChatRoomId,
                  ),
                ),
              );
            }
          },
          child: const Text('Apply'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 다이얼로그 닫기
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
