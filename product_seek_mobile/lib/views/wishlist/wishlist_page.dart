import 'package:flutter/material.dart';
import 'package:product_seek_mobile/viewmodels/wishlist_view_model.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  WishlistPage({Key key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    WishlistViewModel wishlistViewModel =
        Provider.of<WishlistViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wishlist"),
      ),
      body: Container(),
    );
  }
}
