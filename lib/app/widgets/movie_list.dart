import 'package:Moview/app/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  final Function(int index) onPressIndexed;
  final double width;
  final double height;
  final int itemCount;
  final String title;
  final List<MovieModel> movies;

  const MovieList({
    Key key,
    this.onPressIndexed,
    this.width = 235,
    this.height = 150,
    this.itemCount,
    this.movies,
    this.title,
  })  : assert(itemCount != null),
        assert(movies != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: title != null
              ? Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                )
              : Container(),
        ),
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16, top: 8.0),
            itemCount: movies.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var movie = movies[index];
              return Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        movie.imageUrl,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: width,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(6),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                movie.title,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
