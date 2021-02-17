import 'package:flutter/material.dart';
import 'package:movie_app/models/film_search.dart';
import 'about.dart';
import 'detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ["This is item 1", "This is item 2", "This item 3"];
  List<FilmSearch> filmSearches = [];
  var searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie app"), actions: [
        IconButton(icon: Icon(Icons.info), onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> AboutPage()));
        })
      ],),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(controller: searchText,
                  decoration:
                InputDecoration(hintText: "Enter movie to search"),)),
                FlatButton(onPressed: (){
                  if (searchText.text == ""){
                    // TODO show a toast or something
                    print("error");
                  }
                  else {
                    FocusManager.instance.primaryFocus.unfocus();
                  fetchFilmSearchResult(searchText.text).then((value) =>
                  {
                    setState(() =>
                    {
                      filmSearches = value
                    })
                  });
                  }
                }, child: Text("Search movie"))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filmSearches.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(filmSearches[index].title),
                    subtitle: Text("${filmSearches[index].type} - ${filmSearches[index].year}"),
                    leading: Image.network(filmSearches[index].poster),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap:(){
                      Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context)=>DetailPage(info:filmSearches[index].imdbId)));
                    }
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
Future<List<FilmSearch>> fetchFilmSearchResult(searchText) async {
  final response = await http.get('http://www.omdbapi.com/?s=$searchText&apikey=87d10179');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return FilmSearch.filmsFromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load weather');
  }
}
