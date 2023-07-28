import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/models/comment/comments.dart';
import 'package:social/models/post/post.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:social/models/react/react.dart';
import 'package:social/models/video/vidoes.dart';
import 'package:social/models/post/post_model.dart';

// import 'rea';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context).userModel;
          return ConditionalBuilder(
              condition: SocialCubit.get(context).posts.isNotEmpty &&
                  SocialCubit.get(context).userModel != null,
              fallback: (context) => Center(
                  child: LottieBuilder.asset('assets/images/loading3.json')),
              builder: (context) {
                
                return Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        NetworkImage('${cubit!.profile}')),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PostsScreen())),
                                    child: Container(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        height: 35,
                                        decoration: ShapeDecoration(
                                          shape: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'What\'s on your mind, ${cubit.name} ?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(height: 1.2),
                                          ),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PostsScreen())),
                                    icon: const Icon(IconlyBroken.camera))
                              ],
                            ),
                          ),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) =>
                              buildPostItem(context,
                                  SocialCubit.get(context).posts[index], index),
                          itemCount: SocialCubit.get(context).posts.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget buildPostItem(context, PostModel? cubit, index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(cubit!.profile!),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.name!,
                      style: Theme.of(context).textTheme.titleMedium!,
                    ),
                    Text(
                      cubit.dateTime!,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(height: 1.5, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined))
            ],
          ),
          Divider(
            color: Colors.grey[400],
          ),
          const SizedBox(
            height: 3,
          ),
          if (cubit.text != '')
            Column(
              children: [
                Text(
                  cubit.text!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          if (cubit.postImage != '')
            Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(cubit.postImage!), fit: BoxFit.cover),
                )),
          if (cubit.postVideo != '')
            VideoScreen(
              videoUrl: cubit.postVideo,
            ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Lottie.asset(
                          'assets/images/like2.json',
                          width: 30,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocialCubit.get(context).reactsNumber[index]} ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Lottie.asset(
                          'assets/images/comment.json',
                          width: 30,
                          height: 25,
                        ),
                        Text(
                          '${SocialCubit.get(context).commentsNumber[index]} ',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                    '${SocialCubit.get(context).userModel?.profile}'),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentScreen(
                                  postId:
                                      SocialCubit.get(context).postId[index],
                                )));
                    SocialCubit.get(context).comments.clear();
                  },
                  child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      height: 35,
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Write a comment...',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(height: 1.2),
                        ),
                      )),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              ReactScreen(
                postId: SocialCubit.get(context).postId[index],
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context)
                      .getReacts(SocialCubit.get(context).postId[index]);
                  print(SocialCubit.get(context).reactUser);
                },
                child: Lottie.asset(
                  'assets/images/share.json',
                  width: 25,
                  height: 40,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
