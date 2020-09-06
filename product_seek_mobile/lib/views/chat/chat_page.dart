import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/store_model.dart';

class ChatPage extends StatefulWidget {
  ChatPage({this.storeInfo, this.productModel});

  final StoreModel storeInfo;
  final ProductModel productModel;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeInfo.name),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: Container()), _buildMessageComposer()],
        ),
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 60,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0))),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: TextFormField(
                    controller: _messageController,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Message'),
                  ),
                ),
              ),
            ),
          )),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 25,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (_messageController.text.trim().isNotEmpty) {
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
