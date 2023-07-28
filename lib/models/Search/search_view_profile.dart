// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import 'package:social/models/Search/Search_model.dart';

import '../../layout/cubit/social_cubit.dart';

class SearchView extends StatefulWidget {
  SearchModel searchModel;
  SearchView({super.key, 
    required this.searchModel,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  void initState() {
    super.initState();
    SocialCubit.get(context).getNumberUserPosts(widget.searchModel.uId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0.0,
            title: const Text(
              'Ali Abdelmoaty',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: const Icon(IconlyBroken.arrow_left_2)),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 206,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(widget.searchModel.cover!),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        CircleAvatar(
                            radius: 64,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(widget.searchModel.profile!),
                            ))
                      ]),
                ),
                Text(
                  widget.searchModel.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.searchModel.bio!,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(SocialCubit.get(context)
                                  .postsNumber
                                  .length
                                  .toString()),
                              Text('Posts',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              const Text('100k'),
                              Text('Photos',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              const Text('100k'),
                              Text('Followers',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              const Text('100k'),
                              Text('Followings',
                                  style:
                                      Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
