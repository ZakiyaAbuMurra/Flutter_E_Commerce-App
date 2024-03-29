// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AnnouncementModel {
  final String id;
  final String imgUrl;

  AnnouncementModel({required this.id, required this.imgUrl});

  //Convert the model to map then send it to firestore.
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});

    return result;
  }

  factory AnnouncementModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return AnnouncementModel(
      id: documentId,
      imgUrl: map['imgUrl'] ?? '',
    );
  }
}

List<AnnouncementModel> dummyAnnouncements = [
  AnnouncementModel(
    id: 'SmeEIkHweGMhjDRl4ybt',
    imgUrl:
        'https://edit.org/photos/img/blog/mbp-template-banner-online-store-free.jpg-840.jpg',
  ),
  AnnouncementModel(
    id: 'ueHrKkDTFJEKDJoLEoJC',
    imgUrl:
        'https://e0.pxfuel.com/wallpapers/606/84/desktop-wallpaper-ecommerce-website-design-company-noida-e-commerce-banner-design-e-commerce.jpg',
  ),
];
