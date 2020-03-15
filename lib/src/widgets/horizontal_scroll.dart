import 'package:flutter/material.dart';

import 'package:movie_app_2/src/models/movie_model.dart';

class HorizontalScroll extends StatelessWidget {
  
  final List<Movie> items;

  HorizontalScroll({ @required this.items });

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.25,

      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),

        children: _cards(context),
      )
    );
  }

  List<Widget> _cards(BuildContext context) {

    return items.map( (item) {

      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( item.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),

                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),

            SizedBox(height: 5.0),

            Text(
              item.title, 
              overflow: TextOverflow.ellipsis, 
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        )
      );

    }).toList();

  }
}