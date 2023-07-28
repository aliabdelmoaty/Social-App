import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final db = FirebaseFirestore.instance;

  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user);
      emit(LoginSuccess(value.user?.uid));
    }).then((value) {
      print('this my $value');
    }).catchError((onError) {
      emit(LoginError(onError.toString()));
    });
  }

  void forgetPassword({required String email}) {
    emit(ForgetPasswordLoading());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ForgetPasswordSuccess());
    }).catchError((e) {
      emit(ForgetPasswordError(e.toString()));
    });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibility());
  }
}
