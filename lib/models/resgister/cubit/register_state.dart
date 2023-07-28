part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {}

class ChangePasswordVisibility extends RegisterState {}

class CreateUserSuccess extends RegisterState {}

class CreateUserError extends RegisterState {
   final String error;
  CreateUserError(this.error);
}

class ProfileImageSuccess extends RegisterState {}

class ProfileImageError extends RegisterState {}

class CoverImageSuccess extends RegisterState {}

class CoverImageError extends RegisterState {}

class UploadProfileImageSuccess extends RegisterState {}

class UploadProfileImageError extends RegisterState {}

class UploadProfileImageLoading extends RegisterState {}


class UploadCoverImageSuccess extends RegisterState {}

class UploadCoverImageError extends RegisterState {}

class UploadCoverImageLoading extends RegisterState {}
