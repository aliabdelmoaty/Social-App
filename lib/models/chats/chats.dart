import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social/models/chat_details/chat_details.dart';
import 'package:social/models/resgister/userModel.dart';

import '../../layout/cubit/social_cubit.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users!.isNotEmpty,
            fallback: (context) => Center(
                child: LottieBuilder.asset('assets/images/loading3.json')),
            builder: (context) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: ((context, index) => buildChatItem(
                      context, SocialCubit.get(context).users![index])),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: SocialCubit.get(context).users!.length);
            });
      },
    );
  }

  Widget buildChatItem(context, UserModel userModel) => InkWell(
        onTap: () {
          print(userModel.uId);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailsScreen(
                  userModel: userModel,
                ),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(userModel.profile!),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(userModel.name!)
            ],
          ),
        ),
      );
}
