abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordVisibility extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String ?uId;

  LoginSuccess(this.uId);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
class ForgetPasswordLoading extends LoginState {}

class ForgetPasswordSuccess extends LoginState {}

class ForgetPasswordError extends LoginState {
  final String error;
  ForgetPasswordError(this.error);
}
