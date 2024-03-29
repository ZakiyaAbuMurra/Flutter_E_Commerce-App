import 'package:ecommrac_app/models/user_model.dart';
import 'package:ecommrac_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final userService = UserServiceImpl();

  void loadUserProfile(String userId) async {
    debugPrint('Attempting to load user profile for userId: $userId');
    emit(ProfileLoading());
    try {
      final user = await userService.getUser(userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
