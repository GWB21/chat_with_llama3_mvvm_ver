import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatListScreen/chat_list_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat/ViewModel/chat_list_view_model.dart';

void main() {
  runApp(const ChattingApp());
}

class ChattingApp extends StatelessWidget {
  const ChattingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatListViewModel(),
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);
            return ChatListScreenView(chatListViewModel: chatListViewModel);
          },
        ),
      ),
    );
  }
}