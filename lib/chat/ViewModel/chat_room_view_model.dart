import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_room.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/Model/msg.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../DataSource/llama3_data_source.dart';
import 'chat_list_view_model.dart';

//챗 룸 뷰 모델
class ChatRoomViewModel{
  final ChatListViewModel chatListViewModel;
  final ChatRoom chatRoom;

  ChatRoomViewModel({
    required this.chatListViewModel,
    required this.chatRoom,
  }) {
    _initialize();
  }

  // 초기화 메서드
  Future<void> _initialize() async {
    await loadData();
  }

  // 데이터 로드 메서드
  Future<void> loadData() async {
    try {
      // LocalDataSource를 통해 채팅방 메시지들을 로드
      await globalLocalDataSource.loadChatRoomMessages(chatRoom);
    } catch (e) {
      print('Error loading chat room data: $e');
      // 에러 처리 로직 추가 가능
    }
  }

// 메시지 추가
  void addMessage(String messageText, {bool isUser = true}) {
    final newMessage = Msg(msg: messageText, isUser: isUser);
    chatRoom.msgList.add(newMessage);
    chatListViewModel.update();
    globalLocalDataSource.saveChatRoomMessages(chatRoom);
  }

  // 사용자 메시지 추가 및 응답 처리
  Future<void> addUserMessage(String messageText) async {
    // 사용자 메시지 추가
    addMessage(messageText, isUser: true);
    try {
      final dataSourceFile = DataSourceFile();
      // API 호출로 응답 메시지 가져오기
      final reply = await dataSourceFile.sendMessage(messageText);
      addMessage(reply, isUser: false); // 응답 메시지 추가
    } catch (error) {
      addMessage('Failed to fetch reply. Please try again later.', isUser: false); // 에러 메시지 추가
    }
  }


  // 특정 ID로 메시지 삭제
  void removeMessageById(String messageId) {
    chatRoom.msgList.removeWhere((message) => message.id == messageId);
    chatListViewModel.update();
    globalLocalDataSource.saveChatRoomMessages(chatRoom);
  }
  //중간에 있는 메시지를 삭제할때는 어떻게 할까요? => 전체를 리빌드해야하나요? 아니요..
  //AnimatedList를 사용하면 전체 리빌드 필요 없습니다.
  //하지만 과제에서 요구하고 있는것은 listview이기 때문에 listview 버전과 animated version
  //둘 다 만들어볼게요

  // 고정 메시지 설정
  void setStickyMessage(Msg message) {
    chatRoom.stickyMsg = message;
    chatListViewModel.update();
    globalLocalDataSource.saveChatRoomMessages(chatRoom);
  }

  // ID로 Msg 찾기
  Msg getMsgById(String msgId) {
    return chatRoom.msgList.singleWhere((msg) => msg.id == msgId);
  }

  void toggleExpanded() {
    chatRoom.isNoticeExpanded = !chatRoom.isNoticeExpanded;
    chatListViewModel.update();
  }

  // agentName에 대한 Getter 추가
  String get agentName => chatRoom.agentName;
  int get totalMsg => chatRoom.msgList.length;
  Image get profImg => chatRoom.profImg;
  bool get isSticky => chatRoom.isSticky;
  bool get isNoticeExpanded => chatRoom.isNoticeExpanded;
  // 마지막 메시지 안전하게 처리
  Msg get lastMsg => chatRoom.msgList.isNotEmpty
      ? chatRoom.msgList.last
      : Msg(msg: 'no conversation', time: DateTime.fromMillisecondsSinceEpoch(0,isUtc: true));  // 기본 메시지 표시
}
