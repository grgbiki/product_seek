import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/viewmodels/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItemModel> items = new List<CartItemModel>();

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
    initDemoItems();
    refreshTotalCost();
  }

  void refreshTotalCost() {
    totalPrice = 0;
    items.forEach((item) {
      totalPrice += item.product.price * item.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget>[_buildCart()],
                ),
              ),
              _buildBottomPage(),
            ],
          ),
        ));
  }

  Widget _buildBottomPage() {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Theme.of(context).accentColor),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Total: ',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  TextSpan(
                      text: '\$ ' + totalPrice.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                ])),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: 45,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCart() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        var cartItem = items[index];
        return _buildCartItems(cartItem, index);
      }, childCount: items.length),
    );
  }

  Widget _buildCartItems(CartItemModel item, int index) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height / 10,
              child: FittedBox(
                child: CachedNetworkImage(
                  imageUrl: jsonDecode(item.product.images)[0],
                ),
                fit: BoxFit.fill,
              )),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(child: Text(item.product.title)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                              child:
                                  Text('\$ ' + item.product.price.toString()))),
                      IconButton(
                        onPressed: item.quantity > 1
                            ? () {
                                setState(() {
                                  item.quantity--;
                                  refreshTotalCost();
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.remove,
                        ),
                        iconSize: 16,
                      ),
                      Container(
                        child: Text(item.quantity.toString()),
                      ),
                      IconButton(
                        onPressed: item.quantity < 5
                            ? () {
                                setState(() {
                                  item.quantity++;
                                  refreshTotalCost();
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.add,
                        ),
                        iconSize: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  initDemoItems() {
    items.add(new CartItemModel(
        null,
        new ProductModel(
          1,
          "Apple",
          '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
          120,
          "This is an apple",
        ),
        1,
        120));
    items.add(new CartItemModel(
        null,
        new ProductModel(
          2,
          "Apple",
          '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
          120,
          "This is an apple",
        ),
        1,
        120));
    items.add(new CartItemModel(
        null,
        new ProductModel(
          3,
          "Apple",
          '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
          120,
          "This is an apple",
        ),
        1,
        120));
  }
}
