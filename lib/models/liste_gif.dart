import 'gif.dart';

class ListeGif {
  List<Gif> _listeGif = [];

  ListeGif();


  ListeGif.fromJSON(Map<String, dynamic> parsedJson) {
    List<Gif> temp = [];

    if(parsedJson['results'] != null)
    {
      for(int i=0; i< parsedJson['results'].length; i++){
        Gif result = Gif(parsedJson['results'][i]);
        temp.add(result);
      }
    }

    _listeGif = temp;
  }

  List<Gif> get listeGif => _listeGif;
}