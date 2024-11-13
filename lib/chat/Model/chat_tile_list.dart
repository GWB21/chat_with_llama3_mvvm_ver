import 'package:chat_with_llama3_mvc_pattern/chat/Model/chat_tile.dart';

class ChatTileList {
  // 싱글톤 인스턴스
  static final ChatTileList _instance = ChatTileList._internal();

  // 공개되는 싱글톤 인스턴스를 반환하는 factory 생성자
  factory ChatTileList() {
    return _instance;
  }

  // private 생성자
  ChatTileList._internal();

  List<ChatTile> stickyChatTileList = [];
  List<ChatTile> notStickyChatTileList = [];

  // 두 리스트를 합친 전체 ChatTile 리스트 제공
  List<ChatTile> get allChatTileList => [...stickyChatTileList, ...notStickyChatTileList];

  // 초기화 메서드
  void initialize(List<ChatTile> initialSticky, List<ChatTile> initialNotSticky) {
    stickyChatTileList = initialSticky;
    notStickyChatTileList = initialNotSticky;
  }
}