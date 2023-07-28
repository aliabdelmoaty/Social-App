import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/models/comment/commentmodel.dart';

import '../../layout/cubit/social_cubit.dart';

// ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  var postId;
  CommentScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  var comment = TextEditingController();

  @override
  Widget build(
    BuildContext context,
  ) {
    SocialCubit.get(context).getComments(postId);
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0.0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: const Icon(IconlyBroken.arrow_left_2)),
          ),
          body: Stack(
            children: [
              if (state is PostCommentLoading) const LinearProgressIndicator(),
              Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: SocialCubit.get(context).comments.length,
                      itemBuilder: (context, index) => buildCommentItem(context,
                          index, SocialCubit.get(context).comments[index]),
                    ),
                  ),
                  Column(
                    children: [
                      if (SocialCubit.get(context).uploadCommentImage != null)
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: FileImage(File(SocialCubit.get(context)
                                      .uploadCommentImage!
                                      .path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removeCommentImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconlyBroken.close_square,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: TextFormField(
                            maxLines: null,
                            controller: comment,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              filled: true,
                              fillColor: Colors.grey[200],
                              prefixIconColor: Colors.blue,
                              prefixIcon: IconButton(
                                iconSize: 32,
                                onPressed: () {
                                  SocialCubit.get(context).postCommentImage();
                                },
                                icon: const Icon(IconlyBroken.camera),
                              ),
                              suffixIconColor: Colors.blue,
                              suffixIcon: IconButton(
                                iconSize: 32,
                                icon: const Icon(IconlyBroken.send),
                                onPressed: () {
                                  if (SocialCubit.get(context)
                                          .uploadCommentImage !=
                                      null) {
                                    SocialCubit.get(context).commentImage(
                                      comment: comment.text,
                                      postId: postId,
                                    );
                                  } else {
                                    SocialCubit.get(context).commentPost(
                                      comment: comment.text,
                                      postId: postId,
                                    );
                                  }
                                  SocialCubit.get(context).uploadCommentImage =
                                      null;
                                  comment.clear();
                                },
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              errorBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              disabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.all(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildCommentItem(
    context,
    index,
    CommentModel commentModel,
  ) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: ShapeDecoration(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.top,
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(commentModel.profile!),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: ShapeDecoration(
                      shape: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentModel.name!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  height: 1.3, fontWeight: FontWeight.bold),
                        ),
                        if(commentModel.comment != '')
                        Text(
                          commentModel.comment!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15, color: Colors.black54),
                        ),
                      ],
                    )),
                if (commentModel.commentImage != '')
                  Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: NetworkImage(
                              commentModel.commentImage!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
}
