import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:social/models/video/vidoes.dart';
import '../../layout/cubit/social_cubit.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  var text = TextEditingController();
    @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0.0,
            title: Row(
              children: [
                const Text(
                  'Create post',
                  style: TextStyle(color: Colors.black),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () {
                      var dataTime = DateFormat('yyyy-MM-dd–kk:mm')
                          .format(DateTime.now());
                      if (SocialCubit.get(context).uploadPostImage == null &&
                          SocialCubit.get(context).uploadPostVideo == null) {
                        SocialCubit.get(context).createPost(
                            dataTime: dataTime.toString(), text: text.text);
                      } else if (SocialCubit.get(context).uploadPostImage !=
                          null) {
                        SocialCubit.get(context).postImage(
                            dataTime: dataTime.toString(), text: text.text);
                      } else {
                        SocialCubit.get(context).postVideo(
                            dataTime: dataTime.toString(), text: text.text);
                      }
                      text.text = '';
                      SocialCubit.get(context).uploadPostVideo = null;
                      SocialCubit.get(context).uploadPostImage = null;
                    },
                    child: const Text('Add post')),
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: const Icon(IconlyBroken.arrow_left_2)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is CreatePostLoading) const LinearProgressIndicator(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(cubit.userModel!.profile!),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          cubit.userModel!.name!,
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    maxLength: null,
                    controller: text,
                    maxLines: null,
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          'What\'s on your mind,${cubit.userModel?.name}?',
                      hintStyle: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (SocialCubit.get(context).uploadPostVideo != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      VideoScreen(videoUrl: '${SocialCubit.get(context).uploadPostVideo!.uri}' ,),
                       IconButton(
                              onPressed: () {
                                SocialCubit.get(context).removePostVideo();
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
                   
                  if (SocialCubit.get(context).uploadPostImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              
                              image: FileImage(File(SocialCubit.get(context)
                                  .uploadPostImage!
                                  .path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                           SocialCubit.get(context).removePostImage();
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).upLoadPostImage();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add photo'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(IconlyBroken.image)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).upLoadPostVideo();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Add video'),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(IconlyBroken.video)
                            ],
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
      },
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }
}
