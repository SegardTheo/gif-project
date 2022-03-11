import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif/api/api.dart';
import 'package:gif/home_page.dart';
import 'package:path_provider/path_provider.dart';
import '../details_page.dart';
import '../modify_page.dart';
import 'package:http/http.dart' as http;

/// Permet la navigation entre les différentes pages
class NavigationService {

  /// navigation vers la page Detail
  static Future<void> navigateToDetail(BuildContext context, String photoUrl) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(urlPhoto: photoUrl)),
    );
  }

  /// navigation vers la page HomePage
  static Future<void> navigateToHomePage(BuildContext context, Api api) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(api)),
    );
  }

  /// navigation vers la page HomePage
  static Future<void> navigateToModifyPage(BuildContext context, String photoUrl) async {
    final url = Uri.parse(photoUrl);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    // Récupère le gif dans le dossier temp pour traitement
    print(photoUrl);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String key =  DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/image-$key.gif';
    File tempFile = File(path);
    tempFile.writeAsBytesSync(bytes);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ModifyPage(path)),
    );
  }
}