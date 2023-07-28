

import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:social/models/chat_details/chat_model.dart';
import 'package:intl/intl.dart';
import '../../layout/cubit/social_cubit.dart';
import '../resgister/userModel.dart';

// ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({super.key, 
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context)
          .getMessages(receiverId: userModel.uId.toString());
      return BlocConsumer<SocialCubit, SocialState>(listener: (context, state) {
        // TODO: implement listener
      }, builder: (context, state) {
        final message = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userModel.profile!),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userModel.name!,
                  style: const TextStyle(color: Colors.black, fontSize: 17),
                ),
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                icon: const Icon(IconlyBroken.arrow_left_2)),
          ),
          body: ConditionalBuilder(
              fallback: (context) => Center(
                  child: LottieBuilder.asset('assets/images/loading3.json')),
              condition: SocialCubit.get(context).messageSend.length != null,
              builder: (context) {
                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var messageSend =
                                  SocialCubit.get(context).messageSend[index];
                              if (SocialCubit.get(context).userModel?.uId ==
                                  messageSend.senderId) {
                                return buildMyMessage(messageSend);
                              }
                              return buildMessage(messageSend);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 10,
                                    ),
                            itemCount:
                                SocialCubit.get(context).messageSend.length),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          if (SocialCubit.get(context).uploadChatImage != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: FileImage(File(
                                            SocialCubit.get(context)
                                                .uploadChatImage!
                                                .path)),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .removeChatImage();
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
                            ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            child: TextFormField(
                              maxLines: null,
                              controller: message,
                              decoration: InputDecoration(
                                hintText: 'type your message here...',
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIconColor: Colors.blue,
                                prefixIcon: IconButton(
                                  iconSize: 32,
                                  onPressed: () {
                                    SocialCubit.get(context).getChatImage();
                                  },
                                  icon: const Icon(IconlyBroken.camera),
                                ),
                                suffixIconColor: Colors.blue,
                                suffixIcon: IconButton(
                                  iconSize: 32,
                                  icon: const Icon(IconlyBroken.send),
                                  onPressed: () {
                                    if (SocialCubit.get(context)
                                            .uploadChatImage !=
                                        null) {
                                      SocialCubit.get(context).chatImage(
                                          message: message.text,
                                          receiverId: userModel.uId.toString(),
                                          dateTime:
                                              DateFormat('yyyy-MM-dd–kk:mm')
                                                  .format(DateTime.now()));
                                    } else {
                                      SocialCubit.get(context).sendMessage(
                                          message: message.text,
                                          receiverId: userModel.uId.toString(),
                                          dateTime:
                                              DateFormat('yyyy-MM-dd–kk:mm')
                                                  .format(DateTime.now()));
                                    }
                                    SocialCubit.get(context).uploadChatImage =
                                        null;
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
                        ],
                      ),
                    ),
                  ],
                );
              }),
        );
      });
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          children: [
            if (messageModel.message != '')
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(5),
                      topEnd: Radius.circular(5),
                      topStart: Radius.circular(5),
                    )),
                child: Text(messageModel.message!),
              ),
            if (messageModel.chatImage != '')
              Column(children: [
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        messageModel.chatImage!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ])
          ],
        ),
      );
  Widget buildMyMessage(MessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (messageModel.message != '')
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: const BorderRadiusDirectional.only(
                      bottomEnd: Radius.circular(5),
                      topEnd: Radius.circular(5),
                      topStart: Radius.circular(5),
                    )),
                child: Text(messageModel.message!),
              ),
            if (messageModel.chatImage != '')
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      messageModel.chatImage!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      );
}
