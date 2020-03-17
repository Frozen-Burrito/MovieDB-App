import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:movie_app_2/src/models/movie_model.dart';
import 'package:movie_app_2/src/models/actor_model.dart';

class MovieProvider {
  String _apiKey = '62068c4f77360e22a3536d8a1bb9e140';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _page = 0;
  bool _loading = false;

  List<Movie> _popular = new List();

  final _popularStmController = StreamController<List<Movie>>.broadcast();


  Function(List<Movie>) get popularSink => _popularStmController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStmController.stream;


  void disposeStreams() {
    _popularStmController?.close();
  }

  Future<List<Movie>> _getMovieResponse(Uri uri) async {

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

    return _getMovieResponse(uri);
  }

  Future <List<Movie>> getPopular() async {

    if (_loading) return [];

    _loading = true;
    _page++;

    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : _page.toString(),
    });

    final resp = await _getMovieResponse(uri);

    _popular.addAll(resp);
    popularSink(_popular);

    _loading = false;

    return resp;
  }

  Future <List<Actor>> getCast( String movieId ) async {
    
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key' : _apiKey,
      'language' : _language,
    });

    final response = await http.get(url);
    final data = json.decode(response.body);

    final cast = new Cast.fromJsonList(data['cast']);

    return cast.actors;
  }

}