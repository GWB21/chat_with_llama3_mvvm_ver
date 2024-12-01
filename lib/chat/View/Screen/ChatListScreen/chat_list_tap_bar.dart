import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ViewModel/chat_list_view_model.dart';

class ChatListTabBar extends StatefulWidget {
  const ChatListTabBar({super.key});    

  @override
  State<ChatListTabBar> createState() => _ChatListTabBarState();
}

class _ChatListTabBarState extends State<ChatListTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final int _defaultIndex = -1;  // 마지막으로 누른 탭의 인덱스를 저장
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatListViewModel = Provider.of<ChatListViewModel>(context, listen: false);

    return TabBar(
      controller: _tabController,
      onTap: (index) {
        // 같은 탭을 눌렀을 때도 정렬 실행
        if (index == 0) {
          for (var chatRoomViewModel in chatListViewModel.notStickyChatList) {
            print(chatRoomViewModel.agentName);
          }
          for (var chatRoomViewModel in chatListViewModel.stickyChatList) {
            print(chatRoomViewModel.agentName);
          }
          chatListViewModel.sortByName();
        } else if (index == 1){
          for (var chatRoomViewModel in chatListViewModel.chatRoomViewModels) {
            print(chatRoomViewModel.lastMsg.time);
          }
          chatListViewModel.sortByDate();
        }
        setState(() {
          index = _defaultIndex;
        });
      },
      tabs: const [
        Tab(
          icon: Icon(Icons.person_outline),
          text: 'Sort by Name',
        ),
        Tab(
          icon: Icon(Icons.chat_bubble_outline),
          text: 'Sort by Date',
        ),
      ],
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.black,
    );
  }
}