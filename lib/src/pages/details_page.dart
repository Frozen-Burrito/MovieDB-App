import 'package:flutter/material.dart';

import 'package:movie_app_2/src/providers/movie_provider.dart';

import 'package:movie_app_2/src/models/movie_model.dart';
import 'package:movie_app_2/src/models/actor_model.dart';

class DetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          _appBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0, ),
                _head( context, movie ),

                _overview(movie),
                _overview(movie),
                _overview(movie),
                _overview(movie),

                _movieCasting(movie),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _appBar( Movie movie ) {

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.blue,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        ),

        background: FadeInImage(
          image: NetworkImage( movie.getBackdropImg() ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _head( BuildContext context, Movie movie ) {

    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[

          _poster(movie),

          SizedBox(width: 20.0,),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.originalTitle, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
                Text('Released ${movie.releaseDate}', style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),

                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );

  }

  Widget _poster( Movie movie ) {

    return Hero(
      tag: movie.uniqueId,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image(
          image: NetworkImage( movie.getPosterImg() ),
          height: 150.0,
        ),
      ),
    );
  }

  Widget _overview( Movie movie ) {
    
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        
      ),
    );
  }

  Widget _movieCasting( Movie movie ) {

    final movieProvider = new MovieProvider();



    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        if (snapshot.data != null) {
          return _castPageView( snapshot.data );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _castPageView( List<Actor> actors) {

    return SizedBox(
      height: 200.0,

      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),

        itemCount: actors.length,
        itemBuilder: (context, i) => _actorCard(actors[i])
      ),
    );
  }

  Widget _actorCard( Actor actor ) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getProfilePicture()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover
            ),
          ),

          Text(actor.name, overflow: TextOverflow.ellipsis,),
        ],
      ),
    );
  }
}