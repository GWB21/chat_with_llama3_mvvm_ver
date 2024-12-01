import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../Model/chat_room.dart';
import '../Model/msg.dart';

class LocalDataSource {
  late final String directoryPath;

  LocalDataSource();

  Future<void> initialize() async {
    final directory = await getDownloadsDirectory();
    if (directory != null) {
      directoryPath = directory.path;
    } else {
      throw Exception('Could not find the downloads directory');
    }
  }

  Future<List<ChatRoom>> loadChatRooms() async {
    final file = File('$directoryPath/chat_log.json');
    if (!await file.exists()) {
      return [];
    }
    final jsonData = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(jsonData);
    final futures = jsonList.map((json) => ChatRoom.fromJson(json)).toList();
    return Future.wait(futures);
  }

  Future<void> saveChatRooms(List<ChatRoom> chatRooms) async {
    final file = File('$directoryPath/chat_log.json');
    final jsonData = jsonEncode(chatRooms.map((room) => room.toJson()).toList());
    await file.writeAsString(jsonData);
  }

  Future<void> saveChatRoomMessages(ChatRoom chatRoom) async {
    final agentFile = File('$directoryPath/log_${chatRoom.agentName}.json');
    final agentData = {
      'msgList': chatRoom.msgList.map((msg) => msg.toJson()).toList(),
      'stickyMsg': chatRoom.stickyMsg?.toJson(),
    };
    await agentFile.writeAsString(jsonEncode(agentData));
  }

  Future<void> loadChatRoomMessages(ChatRoom chatRoom) async {
    final agentFile = File('$directoryPath/log_${chatRoom.agentName}.json');
    if (await agentFile.exists()) {
      final jsonData = await agentFile.readAsString();
      final Map<String, dynamic> agentData = jsonDecode(jsonData);
      chatRoom.msgList.clear();
      chatRoom.msgList.addAll((agentData['msgList'] as List)
          .map((msgJson) => Msg.fromJson(msgJson)));
      chatRoom.stickyMsg = agentData['stickyMsg'] != null
          ? Msg.fromJson(agentData['stickyMsg'])
          : null;
    }
  }
}
