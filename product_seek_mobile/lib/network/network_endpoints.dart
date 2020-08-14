class NetworkEndpoints {
  static const String _BASE_URL = "http://192.168.1.97:8000";
  static const String BASE_URL = "http://192.168.1.97:8000";
  static const String _BASE_API = _BASE_URL + "/api";

  static const String LOGIN_API = _BASE_API + "/login";
  static const String REGISTER_API = _BASE_API + "/register";

  static const String PRODUCT_API = _BASE_API + "/products";

  static const String CATEGORY_INFO = _BASE_API + "/categories/show/";
  static const String STORE_INFO = _BASE_API + "/stores/show/";
}
