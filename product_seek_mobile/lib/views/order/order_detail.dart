import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/viewmodels/order_view_model.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  OrderDetail({this.orderItem});
  final OrderModel orderItem;

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  bool _isLoading = false;
  String _buttonText = "Return this product";
  final formKey = GlobalKey<FormState>();

  final TextEditingController _returnNote = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.orderItem.status == "Processing") {
      _buttonText = "Cancel Order";
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderItem.orderNumber),
      ),
      body: Container(
        child: Column(
          children: [
            _buildItems(widget.orderItem),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Visibility(
                  visible: widget.orderItem.returnable ||
                      widget.orderItem.status == "Processing",
                  child: _buildReturnButton(orderViewModel)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItems(OrderModel item) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                  child: FittedBox(
                    child: CachedNetworkImage(
                      height: MediaQuery.of(context).size.height / 10,
                      imageUrl: NetworkEndpoints.BASE_URL +
                          jsonDecode(item.product.images)[0],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.product.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            item.status,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('\$ ' + item.product.price.toString()),
                            Text("Qty. " + item.quantity.toString())
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Theme.of(context).accentColor),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Item(s) total: ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: '\$ ' + (item.totalPrice + 5).toString(),
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildReturnButton(OrderViewModel orderViewModel) {
    return ButtonTheme(
      height: 45,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        onPressed: _isLoading
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                if (widget.orderItem.status == "Processing") {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "Are you sure you want to cancel this order?"),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  orderViewModel
                                      .cancelOrder(widget.orderItem.id)
                                      .then((value) {
                                    setState(() {
                                      widget.orderItem.status = "Cancled";
                                      _isLoading = false;
                                    });
                                  });
                                },
                                child: Text("Yes")),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: Text("No"))
                          ],
                        );
                      });
                } else if (widget.orderItem.returnable) {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "Are you sure you want to return this order?"),
                          content: Form(
                              key: formKey,
                              child: TextFormField(
                                controller: _returnNote,
                                validator: (value) {
                                  if (value.trim().isEmpty) {
                                    return 'Please enter your reasons for returning this item.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText:
                                        "Reasons for returning this item"),
                              )),
                          actions: [
                            FlatButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    Navigator.pop(context);
                                    orderViewModel
                                        .returnOrder(widget.orderItem.id,
                                            _returnNote.text.trim())
                                        .then((value) {
                                      setState(() {
                                        widget.orderItem.status = "Cancled";
                                        _isLoading = false;
                                      });
                                    });
                                  }
                                },
                                child: Text("Yes")),
                            FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                child: Text("No"))
                          ],
                        );
                      });
                }
              },
        child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            constraints: BoxConstraints(maxWidth: 800.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              _buttonText,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
