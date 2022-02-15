import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif/api/api.dart';
import 'package:gif/home_page.dart';
import '../details_page.dart';

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
}