import 'package:flutter/material.dart';

import 'package:movie_app_2/src/providers/movie_provider.dart';

import 'package:movie_app_2/src/widgets/card_swiper_w.dart';
import 'package:movie_app_2/src/widgets/horizontal_scroll.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget> [
            _cardSwiper(), 
            _footer(context), 
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

  Widget _footer(BuildContext context) {

    final movieProvider = new MovieProvider();

    return Container(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Popular', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 20.0,),

          FutureBuilder(
            future: movieProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

              if (snapshot.hasData) {
                return HorizontalScroll( items: snapshot.data,);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}