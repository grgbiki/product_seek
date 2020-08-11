import 'package:flutter/material.dart';
import 'package:product_seek_mobile/models/user_model.dart';
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
  bool _isLoggedIn = false;
  UserModel userInfo;

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    profileViewModel.getUserData().listen((data) {
      setState(() {
        if (data != null) {
          _isLoggedIn = true;
          userInfo = data;
        } else {
          _isLoggedIn = false;
        }
      });
    });

    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Visibility(
            visible: !_isLoggedIn,
            child: Center(
              child: RaisedButton(
                  child: Container(
                    child: Text("Login/Sign Up"),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  }),
            ),
          ),
          Visibility(
            visible: _isLoggedIn,
            child: Container(
              child: Column(
                children: <Widget>[_buildProfileView()],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _buildProfileView() {
    return Container(
      child: Text(userInfo != null ? userInfo.name : ""),
    );
  }
}
