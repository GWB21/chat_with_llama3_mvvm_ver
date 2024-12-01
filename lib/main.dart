import 'package:chat_with_llama3_mvc_pattern/chat/View/Screen/ChatListScreen/chat_list_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat/ViewModel/chat_list_view_model.dart';
import 'chat/Repository/local_data_source.dart';

/*Declare a global instance of LocalDataSource*/
final LocalDataSource globalLocalDataSource = LocalDataSource();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the global LocalDataSource
  await globalLocalDataSource.initialize();

  runApp(const ChattingApp());
}

class ChattingApp extends StatelessWidget {
  const ChattingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatListViewModel(),
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ChatListScreenView(),
        );
      },
    );
  }
}