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
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatRoomViewModel>(
      builder: (context, chatRoomViewModel, child) {
        return Column(
          children: [
            // 고정 메시지를 상단에 겹쳐서 표시
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: chatRoomViewModel.totalMsg,
                    itemBuilder: (context, index) {
                      final msgId = chatRoomViewModel.chatRoom.msgList[index].id;
                      final msg = chatRoomViewModel.getMsgById(msgId);
                      return ChatRoomMsgTile(
                        chatRoomViewModel: chatRoomViewModel,
                        message: msg,
                      );
                    },
                  ),
                  if (chatRoomViewModel.chatRoom.stickyMsg != null)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15,right: 15),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0), // 라운드 처리
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3), // 그림자 위치
                              ),
                            ],
                          ),
                          // color: Colors.white,
                          child: Row(
                            children: [
                              Icon(Icons.campaign_outlined, color: Colors.blue.shade200),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  _isExpanded
                                      ? chatRoomViewModel.chatRoom.stickyMsg!.msg
                                      : "Notice",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                  ),
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
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      // onSubmitted: (messageText) {
                      //   if (messageText.trim().isNotEmpty) {
                      //     _controller.clear();
                      //   }
                      // },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      final messageText = _controller.text.trim();
                      if (messageText.isNotEmpty) {
                        chatRoomViewModel.addUserMessage(_controller.text.trim());
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
