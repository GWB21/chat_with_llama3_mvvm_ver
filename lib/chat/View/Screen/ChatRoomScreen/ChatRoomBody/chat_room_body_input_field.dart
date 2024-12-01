import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../ViewModel/chat_list_view_model.dart';


class ChatRoomBodyInputField extends StatefulWidget {
  final String chatRoomId;

  const ChatRoomBodyInputField({
    super.key,
    required this.chatRoomId,
  });

  @override
  State<ChatRoomBodyInputField> createState() => _ChatRoomBodyInputFieldState();
}

class _ChatRoomBodyInputFieldState extends State<ChatRoomBodyInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatRoomViewModel = Provider.of<ChatListViewModel>(context, listen: false)
        .getChatRoomViewModel(widget.chatRoomId);

    return Container(
      color: Colors.white,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Plus 버튼
            IconButton(
              onPressed: () {
                // 파일 추가 또는 다른 동작
              },
              icon: const Icon(Icons.add, color: Colors.black),
              padding: EdgeInsets.zero,
            ),
            // 입력 필드
            Expanded(
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: "Type your message...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 12.0,
                  ),
                ),
              ),
            ),
            // Send 버튼
            Material(
              color: Colors.yellow,
              child: InkWell(
                onTap: () {
                  final messageText = _controller.text.trim();
                  if (messageText.isNotEmpty && messageText.length >= 20) {
                    chatRoomViewModel.addUserMessage(messageText);
                    _controller.clear();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Icon(Icons.send, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
