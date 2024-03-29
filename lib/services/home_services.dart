import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:ecommrac_app/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> getProducts();
}

class HomeServicesImpl implements HomeServices {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<ProductItemModel>> getProducts() async =>
      await firestoreService.getCollection<ProductItemModel>(
        path: ApiPaths.products(),
        builder: (data, documentId) =>
            ProductItemModel.fromMap(data, documentId),
      );
}
