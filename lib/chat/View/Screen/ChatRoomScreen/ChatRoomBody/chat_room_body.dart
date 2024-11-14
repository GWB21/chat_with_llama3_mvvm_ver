import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../ViewModel/chat_room_view_model.dart';
import 'chat_room_body_tile.dart';

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
    return ChangeNotifierProvider.value(
      value: widget.chatRoomViewModel,
      child: Column(
        children: [
          Expanded(
            child: Consumer<ChatRoomViewModel>(
              builder: (context, chatRoomViewModel, child) {
                return ListView.builder(
                  itemCount: chatRoomViewModel.totalMsg,
                  itemBuilder: (context, index) {
                    final msgId = chatRoomViewModel.chatRoom.msgList[index].id;
                    final msg = chatRoomViewModel.getMsgById(msgId); // ID로 Msg 가져오기
                    return ChatRoomMsgTile(
                      chatRoomViewModel: chatRoomViewModel,
                      message: msg,
                    );
                  },
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
      ),
    );
  }
}
