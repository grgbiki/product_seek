import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/views/login/login_page.dart';
import 'package:product_seek_mobile/views/profile/settings_page.dart';
import 'package:product_seek_mobile/views/wishlist/wishlist_page.dart';
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
  final TextEditingController _feedback = TextEditingController();
  bool _isFeedbackEmpty = true;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

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
      key: _scaffoldkey,
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(
                    height: _isLoggedIn
                        ? MediaQuery.of(context).size.height / 6
                        : MediaQuery.of(context).size.height / 4,
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        SafeArea(
                            child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SettingPage(
                                                userInfo: userInfo,
                                                profileViewModel:
                                                    profileViewModel,
                                              )));
                                },
                                icon: Icon(Icons.settings),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: _isLoggedIn
                                  ? _buildProfileView()
                                  : Center(
                                      child: RaisedButton(
                                          child: Container(
                                            child: Text(
                                              "Login / Sign Up",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(
                                                          loginCallback:
                                                              loginCallBack,
                                                        )));
                                          }),
                                    ),
                            ),
                          ],
                        ))
                      ],
                    ))
              ],
            ),
          ),
          _buildOrdersMenu(),
          _buildFeedback()
        ],
      ),
    );
  }

  Widget _buildFeedback() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                if (_isLoggedIn) {
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                loginCallback: loginCallBack,
                              )));
                }
              },
              child: Container(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.rate_review),
                    Text("My Reviews")
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (_isLoggedIn) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Send feedbacks"),
                          content: Container(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _feedback,
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _isFeedbackEmpty = true;
                                  } else {
                                    _isFeedbackEmpty = false;
                                  }
                                });
                              },
                            ),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                _feedback.clear();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                if (_feedback.text.trim().isNotEmpty) {
                                  print("test");
                                  profileViewModel.postFeedback(
                                      _feedback.text.trim(), userInfo.id);

                                  _scaffoldkey.currentState
                                      .showSnackBar(SnackBar(
                                    content: Container(
                                        child: Text(
                                            "Your feedback has been posted successfully")),
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                  _feedback.clear();
                                  Navigator.pop(context);
                                }
                              },
                              child: Text("Confirm",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor)),
                            )
                          ],
                        );
                      });
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                loginCallback: loginCallBack,
                              )));
                }
              },
              child: Container(
                child: Column(
                  children: <Widget>[Icon(Icons.chat), Text("Feedback")],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersMenu() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Row(
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
              onTap: () {
                if (_isLoggedIn) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WishlistPage(
                                userInfo: userInfo,
                              )));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                loginCallback: loginCallBack,
                              )));
                }
              },
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
                if (_isLoggedIn) {
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                loginCallback: loginCallBack,
                              )));
                }
              },
              child: Container(
                child: Column(
                  children: <Widget>[Icon(Icons.history), Text("My Orders")],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (_isLoggedIn) {
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage(
                                loginCallback: loginCallBack,
                              )));
                }
              },
              child: Container(
                child: Column(
                  children: <Widget>[Icon(Icons.undo), Text("My Returns")],
                ),
              ),
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
