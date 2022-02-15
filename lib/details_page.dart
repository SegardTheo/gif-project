import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif/services/gif_service.dart';

/// Affiche le giff sélectionné en plein écran
/// Possibilité de partage en cliquant sur le gif
class DetailsPage extends StatefulWidget {
  final String urlPhoto;

  const DetailsPage({Key? key, required this.urlPhoto}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            color: const Color.fromRGBO(11, 11, 11, 1),
            child: InkWell(
                onTap: () {
                  GifService.shareFile(widget.urlPhoto);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.network(
                      widget.urlPhoto,
                      fit: BoxFit.contain,
                    )))));
  }
}
