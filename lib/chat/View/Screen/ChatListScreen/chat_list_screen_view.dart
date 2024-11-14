import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatListScreen/chat_list_body_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/chat_list_view_model.dart';
import 'chat_list_app_bar.dart';

class ChatListScreenView extends StatelessWidget {
  final ChatListViewModel chatListViewModel;

  const ChatListScreenView({super.key, required this.chatListViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ChatListAppBar(chatListViewModel: chatListViewModel),
      ),
      body: Consumer<ChatListViewModel>(
        builder: (context, chatListViewModel, child) {
          return ListView.builder(
            itemCount: chatListViewModel.chatRoomViewModels.length,
            itemBuilder: (context, index) {
              // ID를 통해 ChatRoomViewModel 가져오기
              final chatRoomId = chatListViewModel.chatRoomViewModels[index].chatRoom.id;
              return ChatListBodyTile(chatRoomId: chatRoomId,);
            },
          );
        },
      ),
    );
  }
}