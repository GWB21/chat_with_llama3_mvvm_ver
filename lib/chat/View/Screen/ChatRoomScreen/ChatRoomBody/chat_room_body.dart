import 'package:flutter/material.dart';
import '../../../../ViewModel/chat_room_view_model.dart';
import 'chat_room_msg_tile.dart';

class ChatRoomBody extends StatefulWidget {
  final ChatRoomViewModel chatRoomViewModel;

  const ChatRoomBody({super.key, required this.chatRoomViewModel});

  @override
  ChatRoomBodyState createState() => ChatRoomBodyState();
}

class ChatRoomBodyState extends State<ChatRoomBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.chatRoomViewModel.totalMsg,
            itemBuilder: (context, index) {
              final message = widget.chatRoomViewModel.chatRoom.msgList[index];
              return ChatRoomMsgTile(
                chatRoomViewModel: widget.chatRoomViewModel,
                message: message,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(onPressed:(){}, icon: const Icon(Icons.add)),
              Expanded(
                //텍스트필드 기능 구현해야함. 20자이상 뭐... 이렇게
                child: TextField(
                  controller: _controller,
                  onSubmitted: (messageText) {
                    if (messageText.trim().isNotEmpty) {
                      widget.chatRoomViewModel.addMessage(messageText.trim());
                      _controller.clear(); // 입력 후 텍스트 필드 초기화
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final messageText = _controller.text.trim();
                  if (messageText.isNotEmpty) {
                    widget.chatRoomViewModel.addMessage(messageText);
                    _controller.clear(); // 전송 후 텍스트 필드 초기화
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}