import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/Search/Search_model.dart';
import 'package:social/models/chat_details/chat_model.dart';
import 'package:social/models/chats/chats.dart';
import 'package:social/models/home/home.dart';
import 'package:social/models/resgister/userModel.dart';
import 'package:social/models/post/post_model.dart';
import 'package:social/models/setting/setting.dart';
import 'package:social/shared/constants.dart';

import '../../models/comment/commentmodel.dart';
import '../../models/users/users.dart';
part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  final db = FirebaseFirestore.instance;
  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  PostModel? postModel;
  SearchModel? searchModel;
  void userSignOut() {
    FirebaseAuth.instance.signOut().then((value) {
      emit(UserSingOutSuccess());
    });
  }

  void getUserData() {
    emit(SocialGetUserLoading());
    db.collection('users').doc(uId).get().then((value) {
      emit(SocialGetUserSuccess());
      // print(value.data());
      userModel = UserModel.fromJson(value.data()!);
    }).catchError((e) {
      print(e.toString());
      emit(SocialGetUserError(e: e.toString()));
    });
  }

  File? updateProfile;
  final pickerImage = ImagePicker();
  Future upDateProfileImage() async {
    final pickedFile = await pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateProfile = File(pickedFile.path);

      emit(GetProfileImageSuccess());
    } else {
      print('no select image');
      emit(GetProfileImageError());
    }
  }

  void upLoadUpDateProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpLoadProfileImageLoading());
    FirebaseStorage.instance
        .ref()
        .child(
            'user/profile/${Uri.file(updateProfile!.path).pathSegments.last}')
        .putFile(updateProfile!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
          // cover: userModel!.cover
        );
        // upLoadUpDateProfile = value;
        print(value);
        // userModel!.profile = value;
      });
      emit(UpLoadProfileImageSuccess());
    }).catchError((e) {
      emit(UpLoadProfileImageError());
    });
  }

  File? updateCover;
  Future upDateCoverImage() async {
    final pickedFile = await pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateCover = File(pickedFile.path);

      emit(GetCoverImageSuccess());
    } else {
      print('no select image');
      emit(GetCoverImageError());
    }
  }

  void upLoadUpDateCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(UpLoadCoverImageLoading());
    FirebaseStorage.instance
        .ref()
        .child('user/Cover/${Uri.file(updateCover!.path).pathSegments.last}')
        .putFile(updateCover!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
          // cover: userModel!.cover
        );
        // upLoadUpDateCover = v;
        // userModel!.cover = upLoadUpDateCover;
      });
      emit(UpLoadCoverImageSuccess());
    }).catchError((e) {
      emit(UpLoadCoverImageError());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const settingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int? index) {
    // if (index == 0) {
    //   getPosts();
    // }
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index!;
    emit(ChangeBottomNav());
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
    String? cover,
    String? profile,
  }) {
    UserModel model = UserModel(
      name: name,
      profile: profile ?? userModel?.profile,
      cover: cover ?? userModel?.cover,
      bio: bio,
      phone: phone,
      uId: userModel?.uId,
      email: userModel?.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((e) {
      emit(SocialUpdateUserError());
    });
  }

  File? uploadPostImage;
  Future upLoadPostImage() async {
    final pickedFile = await pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadPostImage = File(pickedFile.path);

      emit(GetPostImageSuccess());
    } else {
      print('no select image');
      emit(GetPostImageError());
    }
  }

  File? uploadPostVideo;
  Future upLoadPostVideo() async {
    final pickedFile = await pickerImage.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadPostVideo = File(pickedFile.path);

      emit(GetPostVideoSuccess());
    } else {
      print('no select image');
      emit(GetPostVideoError());
    }
  }

  void removePostImage() {
    uploadPostImage = null;
    emit(RemovePostImage());
  }

  void removePostVideo() {
    uploadPostVideo = null;
    emit(RemovePostVideo());
  }

  void postImage({
    required String dataTime,
    required String text,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'user/posts/image/${Uri.file(uploadPostImage!.path).pathSegments.last}')
        .putFile(uploadPostImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dataTime: dataTime,
          text: text,
          postImage: value,
        );
      }).catchError((e) {
        emit(GetPostImageError());
      });
    }).catchError((e) {
      emit(GetPostImageError());
    });
  }

  void postVideo({
    required String dataTime,
    required String text,
  }) {
    FirebaseStorage.instance
        .ref()
        .child(
            'user/posts/video/${Uri.file(uploadPostVideo!.path).pathSegments.last}')
        .putFile(uploadPostVideo!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        createPost(
          dataTime: dataTime,
          text: text,
          postVideo: value,
        );
      }).catchError((e) {
        emit(GetPostImageError());
      });
    }).catchError((e) {
      emit(GetPostImageError());
    });
  }

  void createPost({
    required String dataTime,
    required String text,
    String? postImage,
    String? postVideo,
    String? idPost,
  }) {
    emit(CreatePostLoading());
    PostModel postModel = PostModel(
      name: userModel?.name,
      dateTime: dataTime,
      profile: userModel?.profile,
      uId: userModel?.uId,
      text: text,
      postVideo: postVideo ?? '',
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(CreatePostError());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> reactsNumber = [];
  List<String> postsNumber = [];

  void getPosts() {
    db.collection('posts').orderBy('dateTime').get().then((value) {
    
      for (var element in value.docs) {
        element.reference.collection('reacts').get().then((value) {
          reactsNumber.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
        element.reference.collection('comments').get().then((value) {
          commentsNumber.add(value.docs.length);
        });
        print(commentsNumber);
        print(reactsNumber);
      }
      emit(SocialGetPostsSuccess());
    }).catchError((e) {
      SocialGetPostsError(e: e.toString());
    });
  }

  void getNumberUserPosts(String uId) {
    postsNumber = [];
    db.collection('posts').get().then((value) {
      value.docs.forEach((element) async {
        if (element.data()['uId'] == uId) {
          postsNumber.add(element.data()['uId']);
        }
      });
    });
  }

  var nameReact;
  void likePost(String postId) {
    db
        .collection('posts')
        .doc(postId)
        .collection('reacts')
        .doc(userModel?.uId)
        .set({'react': nameReact, "userId": userModel?.uId}).then((value) {
      emit(PostLikeSuccess());
    }).catchError((e) {
      emit(PostLikeError(e: e));
    });
  }

  String? reactUser;
  void getReacts(String postId) {
    db
        .collection('posts')
        .doc(postId)
        .collection('reacts')
        .doc(userModel?.uId)
        .get()
        .then((value) {
      reactUser = value.data()?['react'];
      emit(GetReactSuccess());
    }).catchError((e) {
      print("error is ${e.toString()}");
      emit(GetReactError());
    });
  }

  File? uploadCommentImage;
  Future postCommentImage() async {
    final pickedFile = await pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadCommentImage = File(pickedFile.path);

      emit(GetCommentImageSuccess());
    } else {
      print('no select image');
      emit(GetCommentImageError());
    }
  }

  void commentImage({
    required String comment,
    required String postId,
  }) {
    emit(PostCommentLoading());
    FirebaseStorage.instance
        .ref()
        .child(
            'user/posts/comment/image/${Uri.file(uploadCommentImage!.path).pathSegments.last}')
        .putFile(uploadCommentImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        print(value);
        commentPost(
          comment: comment,
          commentImage: value,
          postId: postId,
        );
      }).catchError((e) {
        emit(GetCommentImageError());
      });
    }).catchError((e) {
      emit(GetCommentImageError());
    });
  }

  void removeCommentImage() {
    uploadCommentImage = null;
    emit(RemovePostImage());
  }

  void commentPost({
    required String comment,
    String? commentImage,
    required String postId,
  }) {
    emit(PostCommentLoading());
    CommentModel commentModel = CommentModel(
      name: userModel?.name,
      profile: userModel?.profile,
      uId: userModel?.uId,
      comment: comment,
      commentImage: commentImage ?? '',
    );
    db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
      emit(PostCommentSuccess());
    }).catchError((e) {
      emit(PostCommentError(e: e));
    });
  }

  List<CommentModel> comments = [];
  List<int> commentsNumber = [];

  void getComments(String? postId) {
    emit(SocialGetCommentsLoading());
    db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .snapshots()
        .listen((event) {
      comments = [];
      for (var element in event.docs) {
        comments.add(CommentModel.fromJson(element.data()));
        // commentsNumber.add(event.docs.length);
      }
      emit(GetPostCommentSuccess(comments));
    });
  }

  List<UserModel>? users;
  void getAllUsers() {
    users = [];
    db.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel?.uId) {
          users!.add(UserModel.fromJson(element.data()));
        }

        print(element.data()['uId']);
      }
      emit(SocialGetAllUserSuccess());
    }).catchError((e) {
      SocialGetAllUserError(e: e.toString());
    });
  }

  File? uploadChatImage;
  Future getChatImage() async {
    final pickedFile = await pickerImage.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadChatImage = File(pickedFile.path);

      emit(GetChatImageSuccess());
    } else {
      print('no select image');
      emit(GetChatImageError());
    }
  }

  void chatImage({
    required String message,
    required String receiverId,
    required String dateTime,
  }) {
    emit(GetChatImageLoading());
    FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(uploadChatImage!.path).pathSegments.last}')
        .putFile(uploadChatImage!)
        .then((v) {
      v.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
          message: message,
          dateTime: dateTime,
          chatImage: value,
          receiverId: receiverId,
        );
      }).catchError((e) {
        emit(GetChatImageError());
      });
    }).catchError((e) {
      emit(GetChatImageError());
    });
  }

  void removeChatImage() {
    uploadChatImage = null;
    emit(RemoveChatImage());
  }

  File? uploadChatVideo;
  Future chatGhatVideo() async {
    final pickedFile = await pickerImage.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadChatVideo = File(pickedFile.path);

      emit(GetChatVideoSuccess());
    } else {
      print('no select image');
      emit(GetChatVideoError());
    }
  }

  void sendMessage({
    required String message,
    required String receiverId,
    required String dateTime,
    String? chatImage,
  }) {
    MessageModel messageModel = MessageModel(
        senderId: uId,
        message: message,
        dateTime: dateTime,
        receiverId: receiverId,
        chatImage: chatImage ?? '');
    db
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId?.toString())
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((e) {
      emit(SendMessageError());
    });
    db
        .collection('users')
        .doc(userModel?.uId?.toString())
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((e) {
      emit(SendMessageError());
    });
  }

  List<MessageModel> messageSend = [];
  // List<MessageModel> messageSend = [];

  void getMessages({
    required String receiverId,
  }) {
    db
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messageSend = [];
      for (var element in event.docs) {
        messageSend.add(MessageModel.fromJson(element.data()));
      }
      print(messageSend);
      emit(GetMessageSuccess());
    });
  }

  List<SearchModel>? search;
  List<String>? searchName;
  void getSearch() {
    emit(SearchLoading());
    search = [];
    searchName = [];
    db.collection('users').get().then((value) {
      for (var element in value.docs) {
        search!.add(SearchModel.fromJson(element.data()));
        searchName!.add(element.data()['name']);
      }
      print('names is $searchName');
      emit(SearchSuccess());
    }).catchError((e) {
      SearchError(e: e.toString());
    });
  }
}
