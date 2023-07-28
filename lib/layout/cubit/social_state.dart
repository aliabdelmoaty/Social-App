part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialGetUserSuccess extends SocialState {}

class UserSingOutSuccess extends SocialState {}

class SocialGetUserError extends SocialState {
  final String e;
  SocialGetUserError({required this.e});
}

class SocialGetUserLoading extends SocialState {}

class SocialGetAllUserSuccess extends SocialState {}

class SocialGetAllUserError extends SocialState {
  final String e;
  SocialGetAllUserError({required this.e});
}

class SocialGetAllUserLoading extends SocialState {}

class ChangeBottomNav extends SocialState {}

class GetProfileImageSuccess extends SocialState {}

class GetProfileImageError extends SocialState {}

class GetCoverImageSuccess extends SocialState {}

class GetCoverImageError extends SocialState {}

class UpLoadProfileImageSuccess extends SocialState {}

class UpLoadProfileImageError extends SocialState {}

class UpLoadCoverImageSuccess extends SocialState {}

class UpLoadProfileImageLoading extends SocialState {}

class UpLoadCoverImageLoading extends SocialState {}

class UpLoadCoverImageError extends SocialState {}

class SocialUpdateUserLoading extends SocialState {}

class SocialUpdateUserError extends SocialState {}

//createPost
class CreatePostError extends SocialState {}

class CreatePostSuccess extends SocialState {}

class CreatePostLoading extends SocialState {}

class GetPostImageSuccess extends SocialState {}

class GetPostImageError extends SocialState {}

class GetPostVideoSuccess extends SocialState {}

class GetPostVideoError extends SocialState {}

class RemovePostVideo extends SocialState {}

class RemovePostImage extends SocialState {}

class SocialGetPostsSuccess extends SocialState {}

class SocialGetPostsError extends SocialState {
  final String e;
  SocialGetPostsError({required this.e});
}

class SocialGetPostsLoading extends SocialState {}

class PostLikeSuccess extends SocialState {}

class PostLikeError extends SocialState {
  final String e;
  PostLikeError({required this.e});
}

class PostCommentSuccess extends SocialState {}

class PostCommentLoading extends SocialState {}

class PostCommentError extends SocialState {
  final String e;
  PostCommentError({required this.e});
}

class GetPostCommentSuccess extends SocialState {
  GetPostCommentSuccess(List<CommentModel> comments);
}

class GetPostCommentError extends SocialState {
  final String e;
  GetPostCommentError({required this.e});
}

class GetCommentImageSuccess extends SocialState {}

class SocialGetCommentsLoading extends SocialState {}

class GetCommentImageError extends SocialState {}

class RemoveCommentImage extends SocialState {}

class SendMessageError extends SocialState {}

class SendMessageSuccess extends SocialState {}

class GetMessageError extends SocialState {}

class GetMessageSuccess extends SocialState {}

class GetChatImageSuccess extends SocialState {}

class GetChatImageLoading extends SocialState {}

class GetChatImageError extends SocialState {}

class RemoveChatImage extends SocialState {}

class GetChatVideoSuccess extends SocialState {}

class GetChatVideoError extends SocialState {}

class RemoveChatVideo extends SocialState {}

class SearchLoading extends SocialState {}

class SearchSuccess extends SocialState {}

class SearchError extends SocialState {
  final String e;
  SearchError({required this.e});
}

class GetReactSuccess extends SocialState {}

class GetReactError extends SocialState {}
