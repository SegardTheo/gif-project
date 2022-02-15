class Gif {
  String _urlGif = "";

  Gif(parsedJson) {
    _urlGif = parsedJson['media'][0]['mediumgif']['url'];
  }

  String get urlGif => _urlGif;
}