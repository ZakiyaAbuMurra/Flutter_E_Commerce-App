import 'package:ecommrac_app/models/announcement_model.dart';
import 'package:ecommrac_app/models/product_item_model.dart';
import 'package:ecommrac_app/services/announcement_service.dart';
import 'package:ecommrac_app/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();
  final annServices = AnnouncementServiceImp();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      //
      final products = await homeServices.getProducts();
      final announcements = await annServices.getAnnouncement();
      emit(HomeLoaded(products, announcements));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
