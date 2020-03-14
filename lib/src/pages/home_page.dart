import 'package:flutter/material.dart';

import 'package:movie_app_2/providers/movie_provider.dart';
import 'package:movie_app_2/src/widgets/card_swiper_w.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon:  Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget> [
            _cardSwiper(),  
          ]
        ),
      )
    );
  }

  Widget _cardSwiper() {

    final movieProvider = new MovieProvider();
    

    return FutureBuilder(
      future: movieProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if( snapshot.hasData ) {
          return CardSwiper( movies: snapshot.data, );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

      },
    );
  }

}