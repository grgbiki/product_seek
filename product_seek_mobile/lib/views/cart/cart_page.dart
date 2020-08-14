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

  @override
  void initState() {
    super.initState();
    setState(() {});
    initDemoItems();
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("My Cart"),
        ),
        body: Container(
          child: CustomScrollView(
            slivers: <Widget>[_buildCart()],
          ),
        ));
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(child: Text(item.product.title)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child: Text("Rs. " + item.product.price)),
                        IconButton(
                          onPressed: item.quantity > 1
                              ? () {
                                  setState(() {
                                    item.quantity--;
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
            ),
          )
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
            "120",
            "This is an apple",
            1),
        1,
        120));
    items.add(new CartItemModel(
        null,
        new ProductModel(
            2,
            "Apple",
            '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
            "120",
            "This is an apple",
            1),
        1,
        120));
    items.add(new CartItemModel(
        null,
        new ProductModel(
            3,
            "Apple",
            '[ "https://picsum.photos/600", "https://picsum.photos/600", "https://picsum.photos/600" ]',
            "120",
            "This is an apple",
            1),
        1,
        120));
  }
}
