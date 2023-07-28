import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/models/post/post.dart';
import 'package:iconly/iconly.dart';
import '../models/Search/search.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              SocialCubit.get(context)
                  .titles[SocialCubit.get(context).currentIndex],
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                   Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => const Search())));
                },
                icon: const Icon(
                  IconlyBroken.search,
                ),
                color: Colors.black,
              ),
              IconButton(
                  onPressed: () {
                   
                  },
                  icon: const Icon(IconlyBroken.notification),
                  color: Colors.black),
            ],
          ),
          body: SocialCubit.get(context).screens[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomAppBar(
            notchMargin: 4,
            clipBehavior: Clip.antiAlias,
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 60,
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    SocialCubit.get(context).changeBottomNav(index);
                  },
                  currentIndex: SocialCubit.get(context).currentIndex,
                  items: const [
                    BottomNavigationBarItem(
                        label: 'Home',
                        icon: Icon(
                          IconlyBroken.home,
                          color: Colors.grey,
                        )),
                    BottomNavigationBarItem(
                        label: 'Chats            ',
                        icon: Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Icon(
                            IconlyBroken.chat,
                            color: Colors.grey,
                          ),
                        )),
                    BottomNavigationBarItem(
                        label: '           Users',
                        icon: Padding(
                          padding: EdgeInsets.only(left: 40.0),
                          child: Icon(
                            IconlyBroken.user_2,
                            color: Colors.grey,
                          ),
                        )),
                    BottomNavigationBarItem(
                        label: 'Setting',
                        icon: Icon(
                          IconlyBroken.setting,
                          color: Colors.grey,
                        )),
                  ]),
            ),
          ),

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PostsScreen()));
            },
            child: const Icon(
              Icons.add_circle_outline_outlined,
              color: Colors.grey,
              size: 30,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
        );
      },
    );
  }
}
