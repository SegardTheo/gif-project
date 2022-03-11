import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gif/services/message_service.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class ModifyPage extends StatefulWidget {
  final String cheminGif;

  const ModifyPage(this.cheminGif, {Key? key}) : super(key: key);

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  List<Filter> filters = presetFiltersList;
  late File imageFile;
  late String nomGif;
  bool saveEnabled = false;

  @override
  void initState() {
    super.initState();
    imageFile = File.fromUri(Uri.parse(widget.cheminGif));
  }

  Future getImage(context) async {
    nomGif = basename(imageFile.path);
    var imageDecode = imageLib.decodeImage(imageFile.readAsBytesSync());

    if (imageDecode != null) {
      imageLib.Image image = imageLib.copyResize(imageDecode, width: 600);

      Map imagefile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoFilterSelector(
            title: const Text("Filtre image"),
            image: image,
            filters: presetFiltersList,
            filename: nomGif,
            loader: const Center(child: CircularProgressIndicator()),
            fit: BoxFit.contain,
          ),
        ),
      );

      if (imagefile.containsKey('image_filtered')) {
        setState(() {
          saveEnabled = true;
          imageFile = imagefile['image_filtered'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modification image'),
      ),
      body: Center(
        child:  Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  ElevatedButton(onPressed:  () =>
                      MessageService.afficheMessage(
                          context, "A faire !", Colors.orange), child: const Icon(Icons.save)),
                ElevatedButton(onPressed:  () => getImage(context), child: const Icon(Icons.play_arrow_rounded))
              ],
            ),
            Container(
              child: imageFile == null
                  ? const Center(
                child: Text('Pas d\'image sélectionnée.'),
              )
                  : Image.file(imageFile, key: Key(imageFile.path)),
            )
          ],
        )
      ),
    );
  }
}
