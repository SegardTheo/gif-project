import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gif/models/liste_gif.dart';
import 'package:gif/services/gif_service.dart';
import 'package:gif/services/navigation_service.dart';
import '../api/api.dart';
import '../models/gif.dart';

/// Composant listant les gifs recherchés via l'api
/// Possibilité de voir le gif en plein écran en cliquant dessus
/// Possibilité de partager le gif et voir le détail via un long press
class ListeGifComponent extends StatefulWidget {
  final ListeGif? listeGif;
  final Api api;

  const ListeGifComponent(this.api, this.listeGif, {Key? key}) : super(key: key);

  @override
  _ListeGifComponent createState() => _ListeGifComponent();
}

class _ListeGifComponent extends State<ListeGifComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            color: const Color.fromRGBO(10, 10, 10, 1),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.listeGif!.listeGif.length,
              itemBuilder: (BuildContext context, int index) {
                Gif gif = widget.listeGif!.listeGif[index];
                return FocusedMenuHolder(
                  onPressed: () {},
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                        title: const Text("Detail"),
                        onPressed: () {
                          NavigationService.navigateToDetail(
                              context, gif.urlGif);
                        }),
                    FocusedMenuItem(
                        title: const Text("Partage"),
                        onPressed: () {
                          GifService.shareFile(gif.urlGif);
                        })
                  ],
                  child: InkWell(
                      onTap: () {
                        NavigationService.navigateToDetail(context, gif.urlGif);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(11, 11, 11, 1),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Image.network(
                                gif.urlGif,
                                fit: BoxFit.contain,
                              )))),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            )));
  }
}
