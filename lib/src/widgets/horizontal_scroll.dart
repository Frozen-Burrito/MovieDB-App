import 'package:flutter/material.dart';

import 'package:movie_app_2/src/models/movie_model.dart';

class HorizontalScroll extends StatelessWidget {
  
  final List<Movie> items;
  final Function nextPage;

  HorizontalScroll({ @required this.items, @required this.nextPage });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.32,
  );

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,

      child: PageView.builder(

        pageSnapping: false,
        controller: _pageController,
        itemCount: items.length,
        itemBuilder: ( context, i ) => _card( context, items[i] ),
      )
    );
  }


  Widget _card(BuildContext context, Movie movie) {

    movie.uniqueId = '${movie.id}-pageView';

    final movieCard = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( movie.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),

                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
          ),

          SizedBox(height: 5.0),

          Text(
            movie.title, 
            overflow: TextOverflow.ellipsis, 
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      )
    );

    return GestureDetector(
      child: movieCard,
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}