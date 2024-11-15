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
            // 메시지 리스트와 고정 메시지를 포함한 영역
            Expanded(
              child: Stack(
                children: [
                  // 메시지 리스트
                  ListView.builder(
                    itemCount: chatRoomViewModel.totalMsg,
                    padding: chatRoomViewModel.chatRoom.stickyMsg != null
                        ? const EdgeInsets.only(top: 70.0) // 고정 메시지를 위한 공간 확보
                        : EdgeInsets.zero, // 고정 메시지가 없으면 공간 제거
                    itemBuilder: (context, index) {
                      final msgId = chatRoomViewModel.chatRoom.msgList[index].id;
                      final msg = chatRoomViewModel.getMsgById(msgId);
                      return ChatRoomMsgTile(
                        chatRoomViewModel: chatRoomViewModel,
                        message: msg,
                      );
                    },
                  ),
                  // 고정 메시지
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
            // 입력 필드
            Container(
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 더하기 버튼
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      onPressed: () {
                        // 파일 추가 또는 다른 동작
                      },
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                  // 텍스트 입력창
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
                  // 전송 버튼
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
      },
    );
  }
}
