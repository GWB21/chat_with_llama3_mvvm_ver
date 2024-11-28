import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatListScreen/chat_list_body_tile.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatListScreen/chat_list_tap_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/chat_list_view_model.dart';
import 'chat_list_app_bar.dart';

class ChatListScreenView extends StatelessWidget {

  const ChatListScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ChatListAppBar(),
      ),
      body: Consumer<ChatListViewModel>(
        builder: (context, chatListViewModel, child) {
          return ListView.builder(
            itemCount: chatListViewModel.chatRoomViewModels.length,
            itemBuilder: (context, index) {
              final chatRoomId = chatListViewModel.chatRoomViewModels[index].chatRoom.id;
              return ChatListBodyTile(chatRoomId: chatRoomId);
            },
          );
        },
      ),
      bottomNavigationBar: const ChatListTabBar(),
    );
  }
}