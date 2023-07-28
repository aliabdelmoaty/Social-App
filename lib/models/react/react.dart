// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:lottie/lottie.dart';
import 'package:social/layout/cubit/social_cubit.dart';

class ReactScreen extends StatefulWidget {
  var postId;
  ReactScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<ReactScreen> createState() => _ReactScreenState();
}

class _ReactScreenState extends State<ReactScreen> {
  var react;
  @override
  Widget build(BuildContext context) {
    {
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ReactionContainer(
              boxHorizontalPosition: HorizontalPosition.CENTER,
              boxPadding: const EdgeInsets.symmetric(horizontal: 5),
              onReactionChanged: (value) {
                setState(() {
                  react = value;
                });
                SocialCubit.get(context).nameReact = value;
                SocialCubit.get(context).likePost(widget.postId);
              },
              reactions: [
                Reaction(
                  icon: Lottie.asset(
                    'assets/images/like2.json',
                    width: 50,
                    height: 60,
                  ),
                  value: 'like',
                  id: 1,
                ),
                Reaction(
                  icon: Lottie.asset(
                    'assets/images/heart.json',
                    width: 50,
                    height: 60,
                  ),
                  value: 'heart',
                  id: 2,
                ),
                Reaction(
                  icon: Lottie.asset(
                    'assets/images/haha.json',
                    width: 50,
                    height: 60,
                  ),
                  value: 'haha',
                  id: 3,
                ),
                Reaction(
                  icon: Lottie.asset(
                    'assets/images/wow2.json',
                    width: 60,
                    height: 60,
                  ),
                  value: 'wow',
                  id: 4,
                ),
                Reaction(
                    id: 5,
                    icon: Lottie.asset(
                      'assets/images/sad.json',
                      width: 60,
                      height: 60,
                    ),
                    value: 'sad'),
                Reaction(
                    id: 6,
                    icon: Lottie.asset(
                      'assets/images/angry.json',
                      width: 60,
                      height: 60,
                    ),
                    value: 'angry'),
              ],
              child: Row(
                children: [
                    Row(
                      children: [
                        if (react == 'like')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/like2.json',
                                width: 30,
                                height: 40,
                              ),
                              Text('like',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else if (react == 'heart')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/heart.json',
                                width: 30,
                                height: 40,
                              ),
                              Text('Love',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else if (react == 'haha')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/haha.json',
                                width: 25,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text('haha',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else if (react == 'wow')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/wow2.json',
                                width: 30,
                                height: 40,
                              ),
                              Text('wow',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else if (react == 'sad')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/sad.json',
                                width: 30,
                                height: 40,
                              ),
                              Text('sad',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else if (react == 'angry')
                          Row(
                            children: [
                              Lottie.asset(
                                'assets/images/angry.json',
                                width: 30,
                                height: 40,
                              ),
                              Text('angry',
                                  style: Theme.of(context).textTheme.bodySmall!)
                            ],
                          )
                        else
                          Lottie.asset(
                            'assets/images/like2.json',
                            width: 50,
                            height: 40,
                          )
                      ],
                    )
                ],
              ));
        },
      );
    }
  }
}
