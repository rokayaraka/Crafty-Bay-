class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';
  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';

  static const String getSlidersUrl = '$_baseUrl/slides';

  static const String cartUrl = '$_baseUrl/cart';


  static String categoryListUrl(int pageNo, int count) =>
      '$_baseUrl/categories?count=$count&page=$pageNo';
  static String productListUrl(int pageNo, int count) =>
      '$_baseUrl/products?count=$count&page=$pageNo';
    static String productDetailsUrl(String productId) =>
      '$_baseUrl/products/id/$productId';
  static String wishlistUrl(int currentPage, int productsPerPage) =>
      '$_baseUrl/wishlist?count=$productsPerPage&page=$currentPage';

  static const String cartListUrl = '$_baseUrl/cart';
  static const String addToCartUrl = '$_baseUrl/cart';
  static String cartDeleteUrl(String cartItemId) => '$_baseUrl/cart/$cartItemId';
    static String reviewUrl(String productId) => '$_baseUrl/review?product=$productId';
  static String reviewListUrl(String productId, {int count = 2}) =>
      '$_baseUrl/reviews?product=$productId&count=$count';
}