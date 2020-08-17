import 'package:flutter/material.dart';
import 'package:product_seek_mobile/views/cart/cart_page.dart';
import 'package:product_seek_mobile/views/home/home_page.dart';
import 'package:product_seek_mobile/views/profile/profile_page.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildPageView(),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  //Builds page view with bottom navigationbar
  Widget _buildPageView() {
    return PageView(
      physics: new NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        setState(() => _selectedIndex = index);
      },
      children: <Widget>[
        Container(
          child: HomePage(),
        ),
        Container(
          child: CartPage(),
        ),
        Container(
          child: ProfilePage(
            changeIndex: changeIndex,
          ),
        ),
      ],
    );
  }

  //Creates bottom nav bar and returns it as widget
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), title: Text("Cart")),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text("Profile")),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
