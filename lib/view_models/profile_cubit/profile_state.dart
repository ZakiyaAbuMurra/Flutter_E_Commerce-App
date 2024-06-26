part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  
  final UserModel user; // Updated to a single UserModel instance
  ProfileLoaded(this.user);
}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
