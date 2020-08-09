import 'package:flutter/material.dart';
import 'package:product_seek_mobile/viewmodels/login_view_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/views/login/login_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return SafeArea(
        child: Scaffold(
            body: !loginViewModel.isLoggedIn
                ? Center(
                    child: RaisedButton(
                        child: Container(
                          child: Text("Login/Sign Up"),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[],
                    ),
                  )));
  }
}
