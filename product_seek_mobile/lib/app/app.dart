import 'package:flutter/material.dart';
import 'package:product_seek_mobile/views/root_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Seek',
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
}
