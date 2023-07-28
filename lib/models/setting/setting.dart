import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:iconly/iconly.dart';
import 'package:social/models/editProfile/editprofile.dart';
import 'package:social/models/login/loginScreen.dart';
import 'package:social/shared/constants.dart';
import 'package:social/shared/network/local/cache_helper.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  @override
  void initState() {
    super.initState();
    SocialCubit.get(context)
        .getNumberUserPosts(SocialCubit.get(context).userModel!.uId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).userModel;
        //  SocialCubit.get(context).getNumberPosts(cubit!.uId!);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                                  image: NetworkImage(cubit!.cover!),
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
                            backgroundImage: NetworkImage(cubit.profile!),
                          ),
                        )
                      ]),
                ),
                Text(
                  cubit.name!,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  cubit.bio!,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print(uId);
                          },
                          child: Column(
                            children: [
                              Text(
                                SocialCubit.get(context)
                                  .postsNumber
                                  .length
                                  .toString()),
                              Text('Posts',
                                  style: Theme.of(context).textTheme.bodySmall!),
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
                                  style: Theme.of(context).textTheme.bodySmall!),
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
                                  style: Theme.of(context).textTheme.bodySmall!),
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
                                  style: Theme.of(context).textTheme.bodySmall!),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text(
                          'Add photo',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    OutlinedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditScreen())),
                        child: const Icon(IconlyBroken.edit))
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                           setState(() {
                              CacheHelper.removeData(key: 'uId').then((value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                              }).then((value) {
                                SocialCubit.get(context).userSignOut();
                              });
                           });
                          },
                          child: const Text(
                            'LogOut',
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
