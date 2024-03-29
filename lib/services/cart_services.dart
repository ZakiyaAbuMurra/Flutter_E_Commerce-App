import 'package:ecommrac_app/models/cart_orders_model.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:ecommrac_app/utils/api_paths.dart';

abstract class CartServices {
  Future<List<CartOrdersModel>> getCartItems(String uid);
  Future<void> updateCartItem(String uid, CartOrdersModel cartOrder);
}

class CartServicesImpl implements CartServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<CartOrdersModel>> getCartItems(String uid) async =>
      await firestoreService.getCollection<CartOrdersModel>(
        path: ApiPaths.cartItems(uid),
        builder: (data, documentId) => CartOrdersModel.fromMap(data),
      );

  @override
  Future<void> updateCartItem(String uid, CartOrdersModel cartOrder) async =>
      await firestoreService.setData(
        path: ApiPaths.cartItem(uid, cartOrder.id),
        data: cartOrder.toMap(),
      );
}
