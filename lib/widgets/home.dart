import 'package:flutter/material.dart';
import 'about.dart';
import 'detail.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ["This is item 1", "This is item 2", "This item 3"];
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
                Expanded(child: TextField(decoration:
                InputDecoration(hintText: "Enter movie to search"),)),
                FlatButton(onPressed: (){

                }, child: Text("Search movie"))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(items[index]),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap:(){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailPage(info:items[index])));
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
