import 'package:flutter/material.dart';
import '../components/movie/moviecard/actor_card.dart';
import '../components/movie/moviecategory/singel_page_header.dart';
import '../models/movie.dart';
import '../styles.dart';

class SingleMoviePage extends StatelessWidget {
  const SingleMoviePage({Key? key, this.index}) : super(key: key);
  final int? index;
  final String imageURL = "https://i.ytimg.com/vi/Vaz_kpmTi0M/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLD4f7SJYl-eRII0Xpt2AFUabz9wtg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieList[1].title.toString())
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            imageURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.black,
                          ],
                          stops: const [
                            0.0,
                            1.0
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 8,
                      right: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movieList[1].title.toString(),
                              style: Styles.overTheImageTitle,
                            ),
                            GestureDetector(
                              onTap: (){
                                print("");
                              },
                              child: const Icon(
                                Icons.bookmark_add,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          ],
                        ),
                        Text(movieList[1].year.toString(), style: Styles.overTheImageSubTitle),
                      ],
                    ),
                  ),
                ],
              ),
              SinglePageHeader(
                  header: "Heading Movie",
                  reusableWidget: Text(
                    movieList[1].description.toString(),
                    style: Styles.textSectionBody,
                  )),
              SinglePageHeader(
                  header: "Cast and Crew",
                  reusableWidget: Column(
                    children:  [
                      Container(
                        width: 400,
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (ctx,i) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10
                            ),
                            child: const ActorCard(),
                          ),
                        ),
                      ),
                    ],
                  )),
              SinglePageHeader(
                  header: "Quiz information",
                  reusableWidget: Row(
                    children: const [
                      // Custom Card comes here with a horizontal Scroller.
                    ],
                  )),
              SinglePageHeader(
                header: "Movie Rating",
                reusableWidget:
                    Text("IMBd Movie Rating 9.8 ", style: Styles.textSectionBody),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
