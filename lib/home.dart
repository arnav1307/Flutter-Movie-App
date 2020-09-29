import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

//  final List movies = [
//    "Avatar",
//    "I am Legend",
//    "300",
//    "The Avengers",
//    "The Wolf of Wall Street",
//    "Captain Marvel",
//    "X-men",
//    "Game Night",
//    "Tag",
//    "Ready Player One",
//    "Triple Frontier",
//    "6 Underground",
//  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body:ListView.builder(
          itemCount:movieList.length ,
          itemBuilder: (BuildContext context, int index){
            return Stack(
                children: [

                  movieCard(movieList[index], context),

                  Positioned(
                    top:10.0 ,
                      child: movieImage(movieList[index].images[0])),

                ]);
//        return Card(
//          elevation: 5.5 ,
//          color: Colors.white,
//          child: ListTile(
//            leading: CircleAvatar(
//              child:Container(
//                height: 200,
//                width: 200,
//                decoration: BoxDecoration(
//                  image:DecorationImage(
//                    image: NetworkImage(movieList[index].images[0]),
//                    fit: BoxFit.cover
//                  ) ,
//                  //color: Colors.blue,
//                  borderRadius:BorderRadius.circular(13), 
//                ),
//                child: null,
//              ) ,
//            ),
//            trailing: Text("..."),
//            onTap: (){
//              Navigator.push(context, MaterialPageRoute(
//                  builder: (context) => MovieListViewDetails(movieName:movieList.elementAt(index).title,
//                  movie: movieList[index],
//                  )));
//            },
//            //onTap: () =>debugPrint("Movie name: ${movies.elementAt(index)}"),
//            title:Text(movieList[index].title) ,
//            subtitle: Text("${movieList[index].title}"),
//          ),
//        );
      }) ,
    );
  }
  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 50.0),
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 55.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Flexible(
                      child: Text(movie.title,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white
                      ),),
                    ),
                    Text("Rating: ${movie.imdbRating} / 10",
                    style: mainTextStyle())
                  ],),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Released: ${movie.released}",
                      style: mainTextStyle(),),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated,
                        style: mainTextStyle()
                      )],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
      Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MovieListViewDetails(movieName:movie.title,
                  movie: movie,
                  )))

      },
    );
  }

  TextStyle mainTextStyle(){
    return TextStyle(
      fontSize: 15.0,
      color: Colors.grey,
    );
  }


  Widget movieImage(String imageUrl){
    return Container(
      width:100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTc0NzAxODAyMl5BMl5BanBnXkFtZTgwMDg0MzQ4MDE@._V1_SX1500_CR0,0,1500,999_AL_.jpg'),
          fit: BoxFit.cover
        ),
      ),
    );
  }

}

//new route( screen or page)
class MovieListViewDetails extends StatelessWidget {


  final Movie movie;
    final String movieName;
//key is replacing one widget to another
  const MovieListViewDetails({Key key, this.movieName, this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
    body: ListView(
      children: [
        MovieDetailsThumbnail(thumbnail: movie.images[0],),
        MovieDetailsHeaderWithPoster(movie: movie,),
        HorizontalLine(),
        MovieDetailsCast(movie: movie),
        HorizontalLine(),
        MovieDetailsExtraPosters(posters:movie.images)
      ],
    ),
//      body:Center(
//        child: Container(
//          child: RaisedButton(
//            child: Text("Go back  ${this.movie.director}"),
//            onPressed: (){
//               Navigator.pop(context);
//            },
//          ),
//        ),
//      ) ,
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key key, this.thumbnail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover
                  ),
                ),
              ),
              Icon(Icons.play_circle_outline,size: 100,color: Colors.white,)
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient:LinearGradient(colors:[Color(0x00f5f5f5),Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

              ),
            ),
            height: 80,
          ),
        ],
    );
  }
}
class MovieDetailsHeaderWithPoster extends StatelessWidget {

  final Movie movie;

  const MovieDetailsHeaderWithPoster({Key key, this.movie}) : super(key: key);

  @override


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16),
      child: Row(
        children: [
          MoviePoster(poster:movie.images[0].toString()),
          SizedBox(width: 16,),
          Expanded(
            child: MovieDetailsHeader(movie: movie),
          ),
        ],
      ),
    );
  }
}


class MoviePoster extends StatelessWidget {

  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius:borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover
            )
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {

  final Movie movie;

  const MovieDetailsHeader({Key key, this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${movie.year} . ${movie.genre}'.toUpperCase(),
        style: TextStyle(
         fontWeight: FontWeight.w400,
         color: Colors.cyan
        ),
        ),
        Text(movie.title,style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32
        ),),
        Text.rich(TextSpan(
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w300
          ),
          children: <TextSpan>[
            TextSpan(
              text: movie.plot
            ),
            TextSpan(
              text: "More...",
              style: TextStyle(
                color: Colors.indigo
              )
            ),
            ]
        ),

        )
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {

  final Movie movie;

  const MovieDetailsCast({Key key, this.movie}) : super(key: key);

  @override


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field:"Directors",value:movie.director),
          MovieField(field: "Awards", value:movie.awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$field : ',style: TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),),
        Expanded(
          child: Text(
            value,style:TextStyle(color: Colors.black,
          fontSize: 12,
            fontWeight: FontWeight.w300
          ) ,
          ),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}


class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key key, this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text("More Movie Posters".toUpperCase(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black26
            ),),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 8,),
              itemCount: posters.length,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(posters[index]),
                          fit: BoxFit.cover)
                  ),

                ),

              ) ),
        )

      ],
    );
  }
}










