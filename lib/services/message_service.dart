import 'package:flutter/material.dart';

class MessageService {
  static void afficheMessage(BuildContext context, String texte, Color couleur)
  {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texte), backgroundColor: couleur, duration: const Duration(seconds: 2)),
    );
  }
}