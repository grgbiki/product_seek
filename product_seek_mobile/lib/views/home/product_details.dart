import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/views/cart/cart_page.dart';
import 'package:product_seek_mobile/views/checkout/checkout_page.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({this.product});

  final ProductModel product;

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  List<String> images = new List<String>();

  bool _isFavourite = false;
  String heartPath = "assets/icons/heart_outline.svg";

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFavourite = false;
      heartPath = "assets/icons/heart_outline.svg";
      jsonDecode(widget.product.images).forEach((item) {
        images.add(item);
      });
    });
  }

  toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
      if (_isFavourite)
        heartPath = "assets/icons/heart.svg";
      else
        heartPath = "assets/icons/heart_outline.svg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Hero(
                                tag: widget.product.id,
                                child: CarouselSlider.builder(
                                  itemCount: images.length,
                                  options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.5,
                                      autoPlay: false,
                                      aspectRatio: 2,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false),
                                  itemBuilder: (context, index) {
                                    var imageUrl = images[index];
                                    return _buildImageItem(imageUrl);
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                        icon: Icon(Icons.arrow_back),
                                        color: Colors.white,
                                        iconSize: 25,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '\$ ' +
                                                widget.product.price.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              toggleFavourite();
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(8),
                                                child: SvgPicture.asset(
                                                  heartPath,
                                                  width: 20,
                                                )),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          widget.product.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _buildDescriptionPage(),
                                _buildStoreInfo(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
              _buildBottomControl(),
            ],
          ),
        ),
      ),
    );
  }

  _buildStoreInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.store,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(child: InkWell(onTap: () {}, child: Text("Store Name"))),
              FlatButton(
                onPressed: () {},
                child: Text("Follow"),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildDescriptionPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            child: Text(widget.product.description),
          )
        ],
      ),
    );
  }

  _buildBottomControl() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
              ),
            ),
            Container(
              width: 2,
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chat),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 45,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                                  checkoutitems: new CheckoutModel(
                                      null,
                                      [
                                        new CartItemModel(
                                            null,
                                            widget.product,
                                            1,
                                            1 * widget.product.price.toDouble())
                                      ],
                                      0),
                                )));
                  },
                  child: Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 45,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _scaffoldkey.currentState.showSnackBar(SnackBar(
                      content: Container(child: Text("Item added to cart")),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                          label: 'Go to cart',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          }),
                    ));
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        child: FittedBox(
          child: CachedNetworkImage(
            imageUrl: NetworkEndpoints.BASE_URL + imageUrl,
          ),
          fit: BoxFit.fill,
        ));
  }
}
