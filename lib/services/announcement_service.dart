import 'package:ecommrac_app/models/announcement_model.dart';
import 'package:ecommrac_app/services/firestore_services.dart';
import 'package:ecommrac_app/utils/api_paths.dart';

abstract class AnnouncementService {
  Future<List<AnnouncementModel>> getAnnouncement();
}

class AnnouncementServiceImp implements AnnouncementService {
  final firestoreService = FirestoreService.instance;

  @override
  Future<List<AnnouncementModel>> getAnnouncement() async =>
      await firestoreService.getCollection<AnnouncementModel>(
        path: ApiPaths.announcements(),
        builder: (data, documentId) =>
            AnnouncementModel.fromMap(data, documentId),
      );
}
