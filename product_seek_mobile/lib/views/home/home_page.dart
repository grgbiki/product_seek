import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title: Text(
              "Product Seek",
              style: TextStyle(color: Colors.blue[300]),
            ),
            centerTitle: false,
            floating: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.grey[200], shape: BoxShape.circle),
                child: IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {}),
              )
            ],
          )
        ],
      ),
    ));
  }
}
