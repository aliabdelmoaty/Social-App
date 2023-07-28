import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:social/layout/layout.dart';
import 'package:social/models/login/cubit/login_cubit.dart';
import 'package:social/models/login/cubit/login_state.dart';
import 'package:social/models/resgister/resgister.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/shared/constants.dart';
import 'package:social/shared/network/local/cache_helper.dart';

import '../forget_password/forget_password.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is LoginSuccess) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LayoutScreen()),
                  ((route) => false));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Login to waste your time.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'please enter your Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
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
                          validator: (v) {
                            if (v!.isEmpty) {
                              return 'please enter your Password';
                            }
                            return null;
                          },
                          obscureText: LoginCubit.get(context).isPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: 'password',
                              prefixIcon: const Icon(IconlyBold.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(LoginCubit.get(context).suffix),
                              ),
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 25,
                          child: MaterialButton(
                              padding: EdgeInsets.zero,
                              child: Text(
                                'Forget Password ?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             BlocProvider(
                                              create: (context) =>
                                                  LoginCubit(),
                                              child: const ForgetPassword(),
                                            )));
                              }),
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
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: email.text,
                                        password: password.text);
                                  }
                                },
                                child: Text(
                                  'Login'.toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          condition: state is! LoginLoading,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => registerScreen()),
                                  );
                                },
                                child: const Text('Register')),
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
