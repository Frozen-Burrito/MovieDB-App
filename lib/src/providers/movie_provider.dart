import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movie_app_2/src/models/movie_model.dart';

class MovieProvider {
  String _apiKey = '62068c4f77360e22a3536d8a1bb9e140';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _getResponse(Uri uri) async {

    final resp = await http.get( uri );
    final decodedData = json.decode(resp.body);

    final movieList = new Movies.fromJsonList(decodedData['results']);

    return movieList.movies;
  }

  Future <List<Movie>> getNowPlaying() async {

    final uri = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language' : _language,
    });

    return _getResponse(uri);
  }

  Future <List<Movie>> getPopular() async {

    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
    });

    return _getResponse(uri);
  }
}