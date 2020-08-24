import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_seek_mobile/models/cart_model.dart';
import 'package:product_seek_mobile/models/checkout_model.dart';
import 'package:product_seek_mobile/models/product_model.dart';
import 'package:product_seek_mobile/models/user_model.dart';
import 'package:product_seek_mobile/models/wish_list_model.dart';
import 'package:product_seek_mobile/network/network_endpoints.dart';
import 'package:product_seek_mobile/resources/app_constants.dart';
import 'package:product_seek_mobile/viewmodels/cart_view_model.dart';
import 'package:product_seek_mobile/viewmodels/category_view_model.dart';
import 'package:product_seek_mobile/viewmodels/profile_view_model.dart';
import 'package:product_seek_mobile/viewmodels/store_view_model.dart';
import 'package:product_seek_mobile/viewmodels/wishlist_view_model.dart';
import 'package:product_seek_mobile/views/cart/cart_page.dart';
import 'package:product_seek_mobile/views/checkout/checkout_page.dart';
import 'package:product_seek_mobile/views/login/login_page.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  ItemDetail({this.product});

  final ProductModel product;

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  List<String> images = new List<String>();
  bool _isLoggedIn = false;
  UserModel userInfo;

  bool _isFavourite = false;
  String heartPath = "assets/icons/heart_outline.svg";

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  String categoryName = "";
  String storeName = "";
  ProfileViewModel profileViewModel;
  StoreViwModel storeViewModel;
  CategoryViewModel categoryViewModel;
  WishlistViewModel wishlistViewModel;
  CartViewModel cartViewModel;
  List<WishlistModel> wishlists = new List<WishlistModel>();

  WishlistModel currentWishListModel;

  toggleFavourite() {
    setState(() {
      _isFavourite = !_isFavourite;
      if (_isFavourite) {
        wishlistViewModel.addWishList(widget.product.id, userInfo.id);
      } else
        wishlistViewModel.removeWishList(currentWishListModel);
      refreshWishlist();
    });
  }

  refreshWishlist() async {
    if (_isLoggedIn) {
      await wishlistViewModel.getWishlist(userInfo.id).then((datas) {
        wishlists = datas;
      });
    }

    var wishItem = wishlists.singleWhere(
        (it) => it.product.id == widget.product.id,
        orElse: () => null);

    if (wishItem != null) {
      setState(() {
        currentWishListModel = wishItem;
        _isFavourite = true;
        heartPath = "assets/icons/heart.svg";
      });
    } else {
      setState(() {
        _isFavourite = false;
        heartPath = "assets/icons/heart_outline.svg";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (userDetails != null) {
        _isLoggedIn = true;
        userInfo = userDetails;
      }
      _isFavourite = false;
      heartPath = "assets/icons/heart_outline.svg";
      jsonDecode(widget.product.images).forEach((item) {
        images.add(item);
      });
    });

    profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);
    wishlistViewModel = Provider.of<WishlistViewModel>(context, listen: false);
    storeViewModel = Provider.of<StoreViwModel>(context, listen: false);
    categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);

    if (storeName.isEmpty) {
      storeViewModel.getStoreInfoFromBackend(widget.product.storeId);
    }
    storeViewModel.getStoreInfo(widget.product.storeId).then((store) {
      if (store != null) {
        if (storeName.isEmpty) {
          setState(() {
            storeName = store.name;
          });
        }
      }
    });

    if (categoryName.isEmpty) {
      categoryViewModel.getCategoryInfoBackend(widget.product.categoryId);
    }
    categoryViewModel
        .getCategoryInfo(widget.product.categoryId)
        .listen((category) {
      if (category != null) {
        if (categoryName.isEmpty) {
          setState(() {
            categoryName = category.name;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        body: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                            child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Hero(
                                  tag: widget.product.id,
                                  child: CarouselSlider.builder(
                                      itemCount:
                                          jsonDecode(widget.product.images)
                                              .length,
                                      itemBuilder: (context, index) {
                                        var imageUrl = images[index];
                                        return _buildImageItem(imageUrl);
                                      },
                                      options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        autoPlay: false,
                                        enableInfiniteScroll: false,
                                        enlargeCenterPage: true,
                                      )),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                          icon: Icon(Icons.arrow_back),
                                          color: Colors.white,
                                          iconSize: 25,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                        SliverToBoxAdapter(
                          child: Column(
                            children: <Widget>[
                              _buildItemInfo(),
                              _buildCategoryInfo(),
                              _buildDescriptionPage(),
                              _buildStoreInfo()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                _buildBottomControl()
              ],
            ),
          ),
        ));
  }

  _buildCategoryInfo() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          Text("Category", style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Colors.grey[200],
              child: Text(categoryName.isNotEmpty ? categoryName : ""),
            ),
          )
        ],
      ),
    );
  }

  _buildItemInfo() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$ ' + widget.product.price.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20, color: Theme.of(context).primaryColor),
                ),
                InkWell(
                  onTap: () {
                    toggleFavourite();
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        heartPath,
                        width: 20,
                      )),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ));
  }

  _buildStoreInfo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.store,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Text(storeName.isNotEmpty ? storeName : ""))),
              FlatButton(
                onPressed: () {},
                child: Text("Follow"),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildDescriptionPage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Description",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            child: Text(widget.product.description),
          )
        ],
      ),
    );
  }

  _buildBottomControl() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
              ),
            ),
            Container(
              width: 2,
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.chat),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 45,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (_isLoggedIn) {
                      var product = jsonEncode(widget.product);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    checkoutitems: new CheckoutModel(
                                        null,
                                        [
                                          new CartItemModel(
                                              null,
                                              product,
                                              1,
                                              1 *
                                                  widget.product.price
                                                      .toDouble(),
                                              "pending")
                                        ],
                                        0,
                                        userInfo.id),
                                  )));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 45,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_isLoggedIn) {
                      cartViewModel.addItemToCart(new CartItemModel(
                          null,
                          jsonEncode(widget.product.toJson()),
                          1,
                          1 * widget.product.price.toDouble(),
                          "pending"));
                      _scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Container(child: Text("Item added to cart")),
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                            label: 'Go to cart',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartPage()));
                            }),
                      ));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.5,
        child: FittedBox(
          child: CachedNetworkImage(
            imageUrl: NetworkEndpoints.BASE_URL + imageUrl,
          ),
          fit: BoxFit.fill,
        ));
  }
}
