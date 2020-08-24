import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/order_model.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/order_view_model.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: orderViewModel.getOrders(userDetails.id),
                builder: (context, AsyncSnapshot<List<OrderModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else if (snapshot.data.length > 0) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data[index];
                          return _buildOrderItem(item, context);
                        });
                  } else {
                    return Center(child: Text("No order history."));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(OrderModel item, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.orderNumber,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  item.status,
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text("\$ " + item.totalPrice.toString()),
            )
          ],
        ),
      ),
    );
  }
}
