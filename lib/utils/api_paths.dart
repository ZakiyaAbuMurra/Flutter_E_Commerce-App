class ApiPaths {
  //its a function  so that we can use it to generate the path
  static String products() => 'products/';
  static String product(String id) => 'products/$id';
  static String announcements() => 'announcement/';
  static String announcement(String id) => 'announcement/$id';
  static String user(String uid) => 'users/$uid';
  static String users() => 'users/';
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cartItems/$cartItemId';
  static String cartItems(String uid) => 'users/$uid/cartItems/';
  static String addresses(String uid) => 'users/$uid/addresses/';
  static String paymentMethods(String uid) => 'users/$uid/paymentMethods/';
}
