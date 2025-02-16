import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataSourceFile {
  final String apiKey = dotenv.env['API_KEY']!;
  final String apiUrl = dotenv.env['API_URL']!;

  // 메시지 전송 및 응답 반환
  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'llama3-8b-8192',
          'messages': [{'role': 'user', 'content': message}],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to send message');
      }
    } catch (error) {
      throw Exception('Failed to send message: $error');
    }
  }
}
