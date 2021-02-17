import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final String info;

  DetailPage({this.info});


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(title: Text("Detail page"),),
        body:Column(
          children: [
            Text("Detail page"),
            Text(widget.info)
          ],
        )
    );
  }
}
