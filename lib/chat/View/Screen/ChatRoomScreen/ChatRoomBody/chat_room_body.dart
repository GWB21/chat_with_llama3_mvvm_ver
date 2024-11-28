import 'package:chat_with_llama3_mvc_pattern/chat/ViewModel/chat_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../ViewModel/chat_room_view_model.dart';
import 'chat_room_body_tile.dart';

class ChatRoomBody extends StatefulWidget {
  final String chatRoomId;

  const ChatRoomBody({
    super.key,
    required this.chatRoomId,
  });

  @override
  ChatRoomBodyState createState() => ChatRoomBodyState();
}

class ChatRoomBodyState extends State<ChatRoomBody> {
  final TextEditingController _controller = TextEditingController();
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: true);
    final chatRoomViewModel = chatListViewModel.getChatRoomViewModel(widget.chatRoomId);
    
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ListView.builder(
                itemCount: chatRoomViewModel.totalMsg,
                padding: chatRoomViewModel.chatRoom.stickyMsg != null
                    ? const EdgeInsets.only(top: 70.0)
                    : EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final msgId = chatRoomViewModel.chatRoom.msgList[index].id;
                  final msg = chatRoomViewModel.getMsgById(msgId);
                  return ChatRoomMsgTile(
                    message: msg,
                  );
                },
              ),
              if (chatRoomViewModel.chatRoom.stickyMsg != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top:10, left: 5, right: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.campaign_outlined,
                          color: Colors.blue.shade200,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            _isExpanded
                                ? chatRoomViewModel.chatRoom.stickyMsg!.msg
                                : "Notice",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                            maxLines: _isExpanded ? null : 1,
                          ),
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    // 파일 추가 또는 다른 동작
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Type your message...",
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade600,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () {
                    final messageText = _controller.text.trim();
                    if (messageText.isNotEmpty && messageText.length >= 20) {
                      chatRoomViewModel.addUserMessage(messageText);
                      _controller.clear();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
