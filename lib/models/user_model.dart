import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? imageUrl; // URL to the user's profile image
  final String? address;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.birthDate,
    this.phoneNumber,
    this.imageUrl,
    this.address,
  });

  // Converts the user data from a Firestore document to a UserModel
  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      email: map['email'] as String,
      fullName: map['fullName'] as String,
      birthDate: map['birthDate'] != null
          ? (map['birthDate'] as Timestamp).toDate()
          : null,
      phoneNumber: map['phoneNumber'] as String?,
      imageUrl: map['imageUrl'] as String?,
      address: map['address'] as String?,
    );
  }

  // Converts the UserModel to a map, suitable for uploading to Firestore
  Map<String, dynamic> toMap() {
    return {
      // 'id' is typically used as the document ID in Firestore and is not included in the map
      'email': email,
      'fullName': fullName,
      'birthDate': birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'address': address,
    };
  }
}
