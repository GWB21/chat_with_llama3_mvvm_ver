import 'package:chat_with_llama3_mvc_pattern/chat/ViewModel/chat_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_room_body_tile.dart';
import 'chat_room_body_input_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final chatListViewModel =
        Provider.of<ChatListViewModel>(context, listen: true);
    final chatRoomViewModel =
        chatListViewModel.getChatRoomViewModel(widget.chatRoomId);

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
                    chatRoomId: widget.chatRoomId,
                  );
                },
              ),
              if (chatRoomViewModel.chatRoom.stickyMsg != null)
                Container(
                  constraints: BoxConstraints(
                    maxHeight:
                    chatRoomViewModel.isNoticeExpanded ? 100.0 : 50.0,
                  ),
                  // 앱바와 공지 사이 패딩 10
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
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
                      Container(
                        margin: chatRoomViewModel.isNoticeExpanded? const EdgeInsets.only(left: 8.0): const EdgeInsets.only(left: 8.0, top : 5),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListView(
                          children: [
                            SelectableText(
                              chatRoomViewModel.isNoticeExpanded
                                  ? chatRoomViewModel.chatRoom.stickyMsg!.msg
                                  : "Notice",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,  // 버튼 패딩 제거
                        onPressed: chatRoomViewModel.toggleExpanded,
                        icon: Icon(
                          chatRoomViewModel.isNoticeExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        ChatRoomBodyInputField(chatRoomId: widget.chatRoomId),
      ],
    );
  }
}
