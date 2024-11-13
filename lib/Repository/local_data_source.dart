import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalDataSource {
  Future<List<Map<String, dynamic>>> loadData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/chat_data.json');

    if (await file.exists()) {
      final contents = await file.readAsString();
      return List<Map<String, dynamic>>.from(jsonDecode(contents));
    } else {
      return [];
    }
  }

  Future<void> saveData(List<Map<String, dynamic>> data) async {
    final directory = await getApplicationDownloadsDirectory();
    final file = File('${directory.path}/chat_data.json');
    await file.writeAsString(jsonEncode(data));
  }
}


import 'dart:io';
import 'package:path_provider_android/path_provider_android.dart';

Future<Directory?> getDownloadDirectory() async {
  if (Platform.isAndroid) {
    final directories = await PathProviderAndroid.getExternalStorageDirectories(
      type: StorageDirectory.downloads,
    );
    return directories.isNotEmpty ? directories.first : null;
  } else {
    print("Download directory is only available on Android.");
    return null;
  }
}