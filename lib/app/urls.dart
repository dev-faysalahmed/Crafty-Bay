class Urls {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUpUrl = '$_baseUrl/auth/signup';
  static const String verifyOtpUrl = '$_baseUrl/auth/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String homeSliderUrl = '$_baseUrl/slides';
  static const String addToCartUrl = '$_baseUrl/cart';
  static const String getCartListUrl = '$_baseUrl/cart';
  static const String addWishListUrl = '$_baseUrl/wishlist';
  static const String addReviewUrl = '$_baseUrl/review';
  static  String categoryListUrl(int pageSize, int pageNo) => '$_baseUrl/categories?count=$pageSize&page=$pageNo';
  static String productsByCategoryUrl(int pageSize, int pageNo, String categoryId) => '$_baseUrl/products?count=$pageSize&page=$pageNo&category=$categoryId';
  static String productDetailsUrl(String productId) => '$_baseUrl/products/id/$productId';
  static String updateCartItemUrl(String cartId) => '$_baseUrl/cart/$cartId';
  static String deleteCartItemUrl(String cartId) => '$_baseUrl/cart/$cartId';
  static String deleteWishListItemUrl(String wishListId) => '$_baseUrl/wishlist/$wishListId';
  static String getWishListUrl(int count, int page) => '$_baseUrl/wishlist?count=$count&page=$page';
  static String getProductListBySlugUrl(int count, int page, String slug) => '$_baseUrl/products?count=$count&page=$page&category=$slug';
  static String getHome10ProductListUrl(String slug) => '$_baseUrl/products?count=10&category=$slug';
  static String getReviewsByProductIdUrl(int count, int page, String productId) => '$_baseUrl/reviews?count=$count&page=$page&product=$productId';

}