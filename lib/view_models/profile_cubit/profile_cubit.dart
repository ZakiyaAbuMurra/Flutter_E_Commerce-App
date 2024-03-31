import 'package:ecommrac_app/models/user_model.dart';
import 'package:ecommrac_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final userService = UserServiceImpl();

  void loadUserProfile(String userId) async {
    emit(ProfileLoading()); // Emit ProfileLoading state here

    debugPrint('Attempting to load user profile for userId: $userId');

    try {
      final user = await userService.getUser(userId);
      debugPrint('The USer is  ${user.toString()}');
      emit(ProfileLoaded(user));
      debugPrint('Success Loaddd !!!!!');
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // In ProfileCubit
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    emit(ProfileLoading());
    try {
      // Update the user profile
      await userService.updateUser(userId, updates);

      // Fetch the updated profile
      final updatedUser = await userService.getUser(userId);
      emit(ProfileLoaded(updatedUser));
    } catch (error) {
      emit(ProfileError(error.toString()));
    }
  }
}
