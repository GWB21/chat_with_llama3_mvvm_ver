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
              // 개별 ChatRoomViewModel을 ChatListBodyTile로 전달
              final chatRoomViewModel = chatListViewModel.chatRoomViewModels[index];
              return ChatListBodyTile(
                chatRoom: chatRoomViewModel,  // ChatRoomViewModel을 직접 전달
                chatList: chatListViewModel,
              );
            },
          );
        },
      ),
    );
  }
}