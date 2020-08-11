import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/viewmodels/product_view_model.dart';
import 'package:product_seek_mobile/views/home/product_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel> products = new List<ProductModel>();

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    productViewModel.getLocalProducts().listen((product) {
      if (product.length > 0) {
        setState(() {
          if (products != product) products = product;
        });
      }
    });

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Product Seek"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: GridView.builder(
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height) /
                          0.65,
                    ),
                    itemBuilder: (context, index) {
                      var product = products[index];
                      return _buildStoreItem(product);
                    }))
          ],
        ),
      ),
    ));
  }

  Widget _buildStoreItem(ProductModel product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ItemDetail(product: product)));
          },
          child: Column(
            children: <Widget>[
              Container(
                child: Hero(
                  tag: product.id,
                  child: CachedNetworkImage(
                    imageUrl: jsonDecode(product.images)[0],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: RichText(
                        text: TextSpan(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            children: <TextSpan>[
                          TextSpan(text: 'Rs. '),
                          TextSpan(
                              text: product.price,
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
