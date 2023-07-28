import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social/models/resgister/userModel.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  var db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String bio,
    String? profile,
    String? cover,
  }) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        bio: bio,
        uId: value.user!.uid,
        profile: profile,
        cover: cover,
      );
    }).catchError((e) {
      emit(RegisterError());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String bio,
    required String uId,
    String? profile,
    String? cover,
  }) {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      bio: bio,
      phone: phone,
      uId: uId,
      profile: profile,
      cover: cover,
      isEmailVerified: false,
    );
    db
        .collection('users')
        .doc(uId)
        .set(
          userModel.toMap(),
        )
        .then((value) {
      emit(CreateUserSuccess());
    }).catchError((error) {
      emit(CreateUserError(error));
    });
  }

  File? profileImage;
  final picker = ImagePicker();
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);

      emit(ProfileImageSuccess());
    } else {
      print('no select image');
      emit(ProfileImageError());
    }
  }

  var profileLoad;
  void upLoadProfile() {
    emit(UploadProfileImageLoading());

    storageRef
        .child('user/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((v) {
      v.ref.getDownloadURL().then((v) {
        profileLoad = v;
        print('your url $v');
        print(profileLoad);
      });
      // print(profileLoad);
      emit(UploadProfileImageSuccess());
    }).catchError((e) {
      emit(UploadProfileImageError());
    });
  }

  File? coverImage;
  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImageSuccess());
    } else {
      print('no select image');
      emit(CoverImageError());
    }
  }

  var coverLoad;
  void upLoadCover() {
    emit(UploadCoverImageLoading());

    storageRef
        .child('user/Cover/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((v) {
      v.ref.getDownloadURL().then((v) {
        coverLoad = v;
        print(coverLoad);
        print(v);
      });
      print(coverLoad.toString());
      emit(UploadCoverImageSuccess());
    }).catchError((e) {
      emit(UploadCoverImageError());
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
