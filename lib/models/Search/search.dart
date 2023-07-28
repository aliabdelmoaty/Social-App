import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:social/models/Search/Search_model.dart';
import 'package:social/models/Search/search_view_profile.dart';

import '../../layout/cubit/social_cubit.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<SearchModel> searchModel = [];
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              titleSpacing: 0.0,
              title: const Text(
                'Search',
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
            body: ConditionalBuilder(
                condition: SocialCubit.get(context).search!.isNotEmpty,
                fallback: (context) => Center(
                    child: LottieBuilder.asset('assets/images/loading3.json')),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            // cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            controller: search,
                            onChanged: (searchedUser) {
                              addSearch(context, searchedUser);
                              setState(() {});
                            },

                            decoration: InputDecoration(
                                hintText: 'Find a user...',
                                suffixIcon: MaterialButton(
                                    height: 15,
                                    minWidth: 15,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      setState(() {
                                        search.clear();
                                      });
                                    },
                                    child: const Icon(Icons.close_rounded)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildSearchItem(
                                  context,
                                  search.text.isNotEmpty
                                      ? searchModel[index]
                                      : SocialCubit.get(context)
                                          .search![index]),
                              separatorBuilder: (context, index) => const Divider(),
                              itemCount: search.text.isNotEmpty
                                  ? searchModel.length
                                  : SocialCubit.get(context).search!.length),
                        )
                      ],
                    ),
                  );
                }));
      },
    );
  }

  Widget buildSearchItem(context, SearchModel search) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchView(
                  searchModel: search,
                  // SocialCubit.get(context).getNumberPosts(search.uId!);

                ),
              ));
          // SocialCubit.get(context).getNumberPosts(search.uId!);
          // });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 25.0, backgroundImage: NetworkImage(search.profile!)),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    search.name!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    search.bio!,
                    style: Theme.of(context).textTheme.bodySmall!,
                  )
                ],
              )
            ],
          ),
        ),
      );
  void addSearch(BuildContext context, String? searchedUser) {
    searchModel = SocialCubit.get(context)
        .search!
        .where((element) =>
            element.name!.toLowerCase().startsWith(searchedUser!.toLowerCase()))
        .toList();
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SocialCubit>(context).getSearch();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }
}
