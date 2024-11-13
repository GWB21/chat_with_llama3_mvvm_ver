import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_tile.dart';
import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_tile_list.dart';
import 'package:uuid/uuid.dart';
import '../Model/chat_room.dart';
import 'package:flutter/material.dart';

//챗 리스트 뷰 모델
class ChatListViewModel with ChangeNotifier{
  final ChatTileList chatTileList = ChatTileList(); // ChatTileList 싱글톤 인스턴스

  // 새로운 ChatRoom 및 ChatTile 생성 후 notStickyChatTileList에 추가
  void addNewChat(String agentName, {bool isSticky = false}) {

    final chatRoom = ChatRoom(  // 새로운 ChatRoom 생성 및 ID 부여
      id: const Uuid().v4(), // 직접 ID 생성해서 할당
      agentName: agentName,
    );

    final newChatTile = ChatTile(chatRoom: chatRoom); // 생성한 ChatRoom을 기반으로 새로운 ChatTile 생성
    chatTileList.notStickyChatTileList.add(newChatTile); // ChatTileList에 ChatTile 추가
    notifyListeners(); //상태변경알림 필수
  }

  // 특정 ChatTile에 연결된 ChatRoom 가져오기
  ChatRoom getChatRoomForTile(ChatTile chatTile) {
    return chatTile.chatRoom;
  }
  //message가 추가 될때마다 chatlistview한테 상태 알려줘서 리빌드?
  //비효율적입니다. await을 사용해서 채팅이 끝나면 프로바이더가 알려줘서 리빌드하면 되고
  //데이터 유실같은 경우에는 chat room 자체에서 file I/O로 처리하면 됩니다.

  //sort같은 경우 view에서 실행합니다.
  //sort는 진짜 chatlist 객체를 건들인다기 보다 그렇게 보여주는것이기 때문에..
  // view에서 sort하면 더 데이터 무결성을 유지할 수 있지 않을까요?
  //우리가 성형하지 않고 화장을 하거나. 긴머리를 보여주고 싶어서 가발을 쓰는거랑 비슷한거겠죠
  //우리의 신체를 바꾸지 않잖아요 어떻게 보여주고 싶다고해서
  //물론 성형 할 수 있겠지만...
}