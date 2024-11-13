import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_room.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/Model/msg.dart';
import 'package:flutter/material.dart';

//챗 룸 뷰 모델
class ChatRoomViewModel with ChangeNotifier {
  final ChatRoom chatRoom;

  // 생성자를 통해 ChatRoom 인스턴스를 주입받아 초기화
  ChatRoomViewModel({required this.chatRoom});

  // 메시지 추가
  void addMessage(String messageText, {bool isUser = true}) {
    final newMessage = Msg(msg: messageText, isUser: isUser);
    chatRoom.msgList.add(newMessage);
    notifyListeners(); // 메시지 추가 후 상태 알림
  }

  // 특정 ID로 메시지 삭제
  void removeMessageById(String messageId) {
    chatRoom.msgList.removeWhere((message) => message.id == messageId);
    notifyListeners(); // 메시지 삭제 후 상태 알림
  }
  //중간에 있는 메시지를 삭제할때는 어떻게 할까요? => 전체를 리빌드해야하나요? 아니요..
  //AnimatedList를 사용하면 전체 리빌드 필요 없습니다.
  //하지만 과제에서 요구하고 있는것은 listview이기 때문에 listview 버전과 animated version
  //둘 다 만들어볼게요

  // 고정 메시지 설정
  void setStickyMessage(Msg message) {
    chatRoom.stickyMsg = message;
    notifyListeners(); // 고정 메시지 설정 후 상태 알림
  }

  // agentName에 대한 Getter 추가
  String get agentName => chatRoom.agentName;
  int get totalMsg => chatRoom.msgList.length;
  //
  // // ID로 메시지 가져오기
  // Msg Function(String messageId) get messageById => (String messageId) => chatRoom.msgList.singleWhere((message) => message.id == messageId);
  //
  // // 인덱스로 메시지 가져오기
  // Msg Function(int index) get messageByIndex => (int index) => chatRoom.msgList[index];
  //
  // // 다른 필요한 getter도 추가 가능
  // String get lastMsg => chatRoom.msgList.isNotEmpty ? chatRoom.msgList.last.msg : '';
  // DateTime? get lastMsgTime => chatRoom.msgList.isNotEmpty ? chatRoom.msgList.last.time : null;
  //
}
