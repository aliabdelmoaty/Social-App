import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:social/layout/layout.dart';
import 'package:social/models/login/loginScreen.dart';
import 'package:social/models/resgister/cubit/register_cubit.dart';

// ignore: camel_case_types
class registerScreen extends StatelessWidget {
  registerScreen({super.key});
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final bio = TextEditingController();
  String? cover;
  String? profile;
  var formKay = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is CreateUserError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is CreateUserSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LayoutScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: const Icon(IconlyBroken.arrow_left_2),
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKay,
                    child: Column(
                      children: [
                        if (state is UploadProfileImageLoading ||
                            state is UploadCoverImageLoading)
                          const LinearProgressIndicator(),
                        SizedBox(
                          height: 203,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                      image: DecorationImage(
                                        image: RegisterCubit.get(context)
                                                    .coverImage ==
                                                null
                                            ? const AssetImage(
                                                    'assets/images/cover.png')
                                                as ImageProvider<Object>
                                            : FileImage(File(
                                                RegisterCubit.get(context)
                                                    .coverImage!
                                                    .path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        radius: 20.0,
                                        child: IconButton(
                                          // padding: EdgeInsets.all(8),
                                          onPressed: () {
                                            RegisterCubit.get(context)
                                                .getCoverImage();
                                          },
                                          icon: const Icon(
                                            IconlyLight.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (RegisterCubit.get(context).coverImage !=
                                      null)
                                    Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 20.0,
                                          child: IconButton(
                                            // padding: EdgeInsets.all(8),
                                            onPressed: () {
                                              RegisterCubit.get(context)
                                                  .upLoadCover();
                                            },
                                            icon: const Icon(
                                              IconlyLight.upload,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (state is UploadCoverImageSuccess)
                                    Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          radius: 20.0,
                                          child: IconButton(
                                            // padding: EdgeInsets.all(8),
                                            onPressed: () {
                                              RegisterCubit.get(context)
                                                  .getCoverImage();
                                            },
                                            icon: const Icon(
                                              IconlyLight.camera,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 58,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 54,
                                      backgroundImage: RegisterCubit.get(
                                                      context)
                                                  .profileImage ==
                                              null
                                          ? const AssetImage(
                                                  'assets/images/profile.jpg')
                                              as ImageProvider<Object>
                                          : FileImage(File(
                                              RegisterCubit.get(context)
                                                  .profileImage!
                                                  .path)),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 20.0,
                                    child: IconButton(
                                      // alignment: Alignment.bottomRight,
                                      // padding: EdgeInsets.all(8),
                                      onPressed: () {
                                        RegisterCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: const Icon(
                                        IconlyLight.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (RegisterCubit.get(context).profileImage !=
                                      null)
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 20.0,
                                      child: IconButton(
                                        // alignment: Alignment.bottomRight,
                                        // padding: EdgeInsets.all(8),
                                        onPressed: () {
                                          RegisterCubit.get(context)
                                              .upLoadProfile();
                                        },
                                        icon: const Icon(
                                          IconlyLight.upload,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  if (state is UploadProfileImageSuccess)
                                    CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 20.0,
                                      child: IconButton(
                                        // alignment: Alignment.bottomRight,
                                        // padding: EdgeInsets.all(8),
                                        onPressed: () {
                                          RegisterCubit.get(context)
                                              .getProfileImage();
                                        },
                                        icon: const Icon(
                                          IconlyLight.camera,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'please enter your Email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email),
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
                          controller: password,
                          obscureText: RegisterCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'please enter your Password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'password',
                              prefixIcon: const Icon(IconlyBold.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  RegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(RegisterCubit.get(context).suffix),
                              ),
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'please enter your Phone';
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: bio,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'enter your bio';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'bio',
                            prefixIcon: const Icon(Icons.error),
                            labelStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          builder: (context) {
                            return Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKay.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                        name: name.text,
                                        email: email.text,
                                        password: password.text,
                                        phone: phone.text,
                                        bio: bio.text,
                                        cover: RegisterCubit.get(context)
                                                .coverLoad ??
                                            'https://th.bing.com/th/id/R.746297ceecb4c032a0d2192992bada15?rik=U1piEvJFnN5oiQ&pid=ImgRaw&r=0',
                                        // :RegisterCubit.get(context).coverLoad,
                                        profile: RegisterCubit.get(context)
                                                .profileLoad ??
                                            'https://zultimate.com/wp-content/uploads/2019/12/default-profile.png'
                                        //  await RegisterCubit.get(context).profileLoad??

                                        //  ,
                                        );
                                  }
                                },
                                child: Text(
                                  'Register'.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          condition: state is! RegisterLoading,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        Row(
                          children: [
                            Text(
                              'Do have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: const Text('Login')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
