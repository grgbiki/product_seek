import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/views/login/login_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({this.changeIndex});
  final Function(int) changeIndex;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoggedIn = false;
  UserModel userInfo;
  ProfileViewModel profileViewModel;

  void loginCallBack() {
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
  }

  @override
  Widget build(BuildContext context) {
    profileViewModel = Provider.of<ProfileViewModel>(context);

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

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                _isLoggedIn
                    ? Container(
                        height: MediaQuery.of(context).size.height / 8,
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          children: <Widget>[
                            SafeArea(child: _buildProfileView())
                          ],
                        ))
                    : Container(
                        height: MediaQuery.of(context).size.height / 4,
                        color: Theme.of(context).primaryColor,
                        child: SafeArea(
                          child: Center(
                            child: RaisedButton(
                                child: Container(
                                  child: Text(
                                    "Login / Sign Up",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage(
                                                loginCallback: loginCallBack,
                                              )));
                                }),
                          ),
                        ),
                      ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                widget.changeIndex(1);
                              },
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.shopping_cart),
                                    Text("My Cart")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      "assets/icons/heart.svg",
                                      width: 20,
                                    ),
                                    Text("Favourites")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                print("test");
                              },
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.history),
                                    Text("My Orders")
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.undo),
                                    Text("My Returns")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          userInfo != null ? userInfo.name : "",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
