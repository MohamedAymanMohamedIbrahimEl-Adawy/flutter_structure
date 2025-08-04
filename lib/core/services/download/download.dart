import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../log/app_log.dart';
import 'dart:convert';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

class DownloadServices {
  static Future<File> download({
    required String url,
    required SaveTypes saveType,
  }) async {
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    AppLog.logValue(uri.pathSegments.last.split('/').last);

    late final Directory documentDirectory;

    if (saveType == SaveTypes.savePermanently) {
      documentDirectory = await getApplicationDocumentsDirectory();
    } else {
      documentDirectory = await getTemporaryDirectory();
    }

    final file = File(
      join(documentDirectory.path, uri.pathSegments.last.split('/').last),
    );

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }

  Future<void> downloadAndOpenBase64File(
    String base64String,
    String fileName,
  ) async {
    loadDialog();
    await Future.delayed(const Duration(seconds: 1));
    try {
      if (base64String.contains(',')) {
        base64String = base64String.split(',')[1].trim();
      }
      Uint8List bytes = base64Decode(base64String);
      // 4️⃣ Get Save Location (Use internal storage)
      Directory directory = await getApplicationDocumentsDirectory();
      String filePath = "${directory.path}/$fileName";
      // 5️⃣ Write the file
      File file = File(filePath);
      await file.writeAsBytes(bytes);
      AppLog.printValue("✅ File saved at: $filePath");
      hideLoadingDialog();
      // 6️⃣ Open the file
      OpenFilex.open(filePath);
    } catch (e) {
      hideLoadingDialog();
      AppLog.printValue("❌ Error: $e");
    }
  }
}

enum SaveTypes { saveTemporary, savePermanently }
