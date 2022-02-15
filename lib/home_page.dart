import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'api/api.dart';
import 'components/liste_gif_component.dart';
import 'models/liste_gif.dart';

class HomePage extends StatefulWidget {
  final Api api;

  const HomePage(this.api, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _recherche = "";
  final TextEditingController _controller = TextEditingController();
  late Future<ListeGif> fetchListeGif;

  @override
  void initState() {
    super.initState();
    fetchListeGif = widget.api.fetchGif("");
  }

  void clearData() {
    _controller.clear();
    rechercheGif("");
  }

  void rechercheGif(String motRecherche) {
    setState(() {
      _recherche = motRecherche;
    });

    fetchListeGif = widget.api.fetchGif(motRecherche);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Recherche',
                hintText: 'Recherchez un gif ...',
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 5.0, top: 10.0),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  label: const Text('Vider'),
                  onPressed: () {
                    clearData();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
            Container(
                margin: const EdgeInsets.only(left: 5.0, top: 10.0),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.find_in_page,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('Rechercher'),
                  onPressed: () {
                    rechercheGif(_controller.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, top: 10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Gif recherché : " + _recherche,
              style: Theme.of(context).textTheme.overline,
            ),
          ),
        ),
        FutureBuilder<ListeGif>(
            future: fetchListeGif,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ListeGif? listeGif = snapshot.data;
                return ListeGifComponent(widget.api, listeGif);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return const CircularProgressIndicator();
            })
      ],
    ));
  }
}
