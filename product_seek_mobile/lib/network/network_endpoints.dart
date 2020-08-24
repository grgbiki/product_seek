//Network endpoints
class NetworkEndpoints {
  static const String _BASE_URL = "http://192.168.1.97:8000";
  static const String BASE_URL = "http://192.168.1.97:8000";
  static const String _BASE_API = _BASE_URL + "/api";

  static const String LOGIN_API = _BASE_API + "/login";
  static const String REGISTER_API = _BASE_API + "/register";

  static const String PRODUCT_API = _BASE_API + "/products";
  static const String PRODUCT_SEARCH_API = _BASE_API + "/products/search/";

  static const String CATEGORY_INFO = _BASE_API + "/categories/show/";
  static const String STORE_INFO = _BASE_API + "/stores/show/";

  static const String FEEDBACK_API = _BASE_API + "/feedback/create";

  static const String WISHLIST_API = _BASE_API + "/wishlist/show/";
  static const String ADD_WISHLIST_API = _BASE_API + "/wishlist/add";
  static const String REMOVE_WISHLIST_API = _BASE_API + "/wishlist/remove/";

  static const String ADD_ORDERS_API = _BASE_API + "/order/add";
  static const String CANCEL_ORDERS_API = _BASE_API + "/order/cancle/";
  static const String USER_ORDERS_API = _BASE_API + "/order/user-orders/";
}
