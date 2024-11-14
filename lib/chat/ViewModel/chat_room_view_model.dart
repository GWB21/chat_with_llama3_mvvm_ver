import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_room.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/Model/msg.dart';
import 'package:flutter/material.dart';

import 'chat_list_view_model.dart';

//챗 룸 뷰 모델
class ChatRoomViewModel with ChangeNotifier {
  final ChatRoom chatRoom;
  final ChatListViewModel parentViewModel; // 상위 ViewModel 참조
  // 생성자를 통해 ChatRoom 인스턴스를 주입받아 초기화
  ChatRoomViewModel({required this.chatRoom, required this.parentViewModel});

  // 메시지 추가
  void addMessage(String messageText, {bool isUser = true}) {
    final newMessage = Msg(msg: messageText, isUser: isUser);
    chatRoom.msgList.add(newMessage);
    notifyListeners(); // 메시지 추가 후 상태 알림
    notifyParent();
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

  // ID로 Msg 찾기
  Msg getMsgById(String msgId) {
    return chatRoom.msgList.singleWhere((msg) => msg.id == msgId);
  }

  // 상위 ViewModel에 알리는 메서드
  void notifyParent() {
    parentViewModel.notifyListeners();
  }

  // agentName에 대한 Getter 추가
  String get agentName => chatRoom.agentName;
  int get totalMsg => chatRoom.msgList.length;
  Image get profImg => chatRoom.profImg;
  bool get isSticky => chatRoom.isSticky;
  // 마지막 메시지 안전하게 처리
  Msg get lastMsg => chatRoom.msgList.isNotEmpty
      ? chatRoom.msgList.last
      : Msg(msg: 'no conversation', time: DateTime.fromMillisecondsSinceEpoch(0,isUtc: true));  // 기본 메시지 표시
}
