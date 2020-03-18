import 'package:flutter/material.dart';

import 'package:movie_app_2/src/providers/movie_provider.dart';
import 'package:movie_app_2/src/models/movie_model.dart';

class Search extends SearchDelegate{

  final movieProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search delegate

    List<Widget> actions = [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];

    return actions;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading for the appBar

    return IconButton(
      icon: AnimatedIcon( 
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Creates results
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions

    if ( query.isEmpty ) return Container();

    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if ( !snapshot.hasData ) return Center(
          child: CircularProgressIndicator(),
        );

        final movies = snapshot.data;

        return ListView(
          children: movies.map( (movie ) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage( movie.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.contain,
              ),

              title: Text(movie.title),
              subtitle: Text(movie.voteAverage.toString()),

              onTap: () {
                close(context, null);
                movie.uniqueId = '';
                Navigator.pushNamed(context, 'details', arguments: movie);
              },
            );
          }).toList(),
        );

      },
    );
  }

}