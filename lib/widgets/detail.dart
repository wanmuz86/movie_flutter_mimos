import 'package:flutter/material.dart';
import 'package:movie_app/models/film_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {

  final String info;

  DetailPage({this.info});


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  FilmDetail filmDetail;

  @override
  void initState() {

    super.initState();

    fetchDetailFromId(widget.info).then((value) => {
      setState((){
        filmDetail=value;
      })

    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(title: Text("Detail page"),),
        body:
        filmDetail != null ?
            SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(filmDetail.poster),
                  Text(filmDetail.title),
                  SizedBox(height: 10,),
                  Text(filmDetail.year),
                  SizedBox(height: 10,),
                  Text(filmDetail.actors),
                  SizedBox(height: 10,),
                  Text(filmDetail.plot)

                ],
              ),
            )
            :

            Center(
              child:CircularProgressIndicator()
            )


    );
  }
}

Future<FilmDetail> fetchDetailFromId(imdbId) async {
  final response = await http.get('https://www.omdbapi.com/?i=$imdbId&apikey=87d10179');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return FilmDetail.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}
