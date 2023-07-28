import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';


import '../../layout/cubit/social_cubit.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key});
  var name = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context).userModel;
        var upDateProfile = SocialCubit.get(context).updateProfile;
        var upDateCover = SocialCubit.get(context).updateCover;

        name.text = cubit!.name!;
        bio.text = cubit.bio!;
        phone.text = cubit.phone!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                        name: name.text,
                        bio: bio.text,
                        phone: phone.text,
                      );
                      
                    },
                    child: const Text('Update')),
              )
            ],
            title: const Text(
              'Edit profile',
              style: TextStyle(color: Colors.black),
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
                children: [
                  if (state is SocialUpdateUserLoading)
                    const Column(
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 206,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: upDateCover == null
                                            ? NetworkImage(cubit.cover!)
                                                as ImageProvider<Object>
                                            : FileImage(File(upDateCover.path)),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .upDateCoverImage();
                                    },
                                    icon: const CircleAvatar(
                                        child: Icon(
                                      IconlyBroken.camera,
                                    ))),
                              ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: upDateProfile == null
                                      ? NetworkImage(cubit.profile!)
                                          as ImageProvider<Object>
                                      : FileImage(File(upDateProfile.path)),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .upDateProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                      child: Icon(
                                    IconlyBroken.camera,
                                  ))),
                            ],
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (SocialCubit.get(context).updateProfile != null ||
                      SocialCubit.get(context).updateCover != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).updateProfile != null)
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                height: 40,
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blue,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .upLoadUpDateProfileImage(bio: bio.text, name: name.text, phone: phone.text);
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Upload profile',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        IconlyBroken.upload,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is UpLoadProfileImageLoading)
                                const LinearProgressIndicator(),
                            ],
                          )),
                        const SizedBox(
                          width: 10,
                        ),
                        if (SocialCubit.get(context).updateCover != null)
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                height: 40,
                                // width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.blue,
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .upLoadUpDateCoverImage(
                                            bio: bio.text,
                                            name: name.text,
                                            phone: phone.text);
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Upload cover',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        IconlyBroken.upload,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (state is UpLoadCoverImageLoading)
                                const LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter your Name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(IconlyBold.user_2),
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: bio,
                    keyboardType: TextInputType.name,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter your bio';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Bio',
                      prefixIcon: const Icon(Icons.error),
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'please enter your phone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
