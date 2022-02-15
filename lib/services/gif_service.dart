import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GifService {
  static Future<void> shareFile(String urlGif) async {
    final url = Uri.parse(urlGif);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String path = '$tempPath/image.gif';
    File(path).writeAsBytesSync(bytes);

    await Share.shareFiles([path], text: 'Hey regarde ce que j\'ai trouvé !');
  }
}
