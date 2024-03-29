import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommrac_app/models/user_model.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:ecommrac_app/utils/api_paths.dart';

abstract class UserService {
  Future<UserModel> getUser(String userId);
}

class UserServiceImpl extends UserService {
  final firestoreService = FirestoreService.instance;

  @override
  Future<UserModel> getUser(String userId) async {
    final doc =
        await firestoreService.firestore.doc(ApiPaths.user(userId)).get();

    if (doc.exists) {
      return UserModel.fromMap(doc.data()!, doc.id);
    } else {
      throw Exception('User not found.');
    }
  }
}
