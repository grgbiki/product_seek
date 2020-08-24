import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/viewmodels/checkout_view_model.dart';
import 'package:provider/provider.dart';

class ConfirmationPage extends StatefulWidget {
  ConfirmationPage({this.checkoutitems, this.userInfo});

  final CheckoutModel checkoutitems;
  final UserModel userInfo;

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final checkoutViewModel = Provider.of<CheckoutViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm order"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount.",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            widget.checkoutitems.total.toString(),
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        checkoutViewModel.orderItems(widget.checkoutitems);
                        //Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        child: Center(
                          child: Text("Confirm Order",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
