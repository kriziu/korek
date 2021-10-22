import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korek/models/filters.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/providers/messages_provider.dart';
import 'package:korek/screens/profile_screen.dart';
import 'package:korek/widgets/chat_item.dart';
import 'package:korek/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  SortType sortType = SortType.sortMessagesMethods[0];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchController = TextEditingController();
  String? searchStr;
  List<User> chats = [];

  Future<void> _fetchChats(String id) async {
    try {
      await Provider.of<MessagesProvider>(context, listen: false)
          .fetchChatted(id);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
    }
  }

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      _fetchChats(user.id);
    }
  }

  void sortChats(List<User> chats) {
    switch (sortType.sort) {
      case Sort.nameAZ:
        chats.sort((a, b) => a.firstName.compareTo(b.firstName));
        break;
      case Sort.nameZA:
        chats.sort((a, b) => b.firstName.compareTo(a.firstName));
        break;
      case Sort.newest:
        chats.sort((a, b) => b.firstName.compareTo(a.firstName));
        break;
      case Sort.oldest:
        chats.sort((a, b) => b.firstName.compareTo(a.firstName));
        break;
      case Sort.rating:
        break;
      case Sort.highPrice:
        break;
      case Sort.lowPrice:
        break;
    }
  }

  void filterChats(List<User> allChats) {
    if (searchStr!=null) {
      chats = allChats
          .where((teacher) =>
              teacher.firstName
                  .toLowerCase()
                  .contains(searchStr!.toLowerCase()) ||
              teacher.lastName
                  .toLowerCase()
                  .contains(searchStr!.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final allChats = Provider.of<MessagesProvider>(context).chatted;
    chats = allChats;
    sortChats(chats);
    filterChats(allChats);

    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(
          widgetKey: _scaffoldKey, drawer: const HomeDrawer()),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async => await _fetchChats(user!.id),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null && user.userType == "teacher")
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () =>
                              _scaffoldKey.currentState!.openDrawer(),
                          icon: const Icon(
                            Icons.menu_rounded,
                            size: 40,
                          ),
                          iconSize: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(platformPageRoute(
                                context: context,
                                builder: (context) => const ProfileScreen()));
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[300],
                            child: Hero(
                              tag: "profileimg",
                              child: SvgPicture.asset(
                                  "assets/${user.avatarId}.svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      24,
                      (user != null && user.userType == "teacher") ? 0 : 32,
                      24,
                      32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Chats",
                        style: platformThemeData(
                          context,
                          material: (data) => data.textTheme.headline2,
                          cupertino: (data) => data.textTheme.actionTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: _searchController,
                            onChanged: (val) => setState(() => searchStr = val),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchStr = null;
                                      _searchController.clear();
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  child: const Icon(Icons.clear,
                                      color: Color(0xff888888)),
                                ),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xff888888)),
                                hintText: 'Search',
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 8)),
                            style: const TextStyle(fontSize: 15),
                          )),
                          const SizedBox(width: 12),
                          PopupMenuButton<SortType>(
                            tooltip: "Sort by",
                            onSelected: (SortType sortType) {
                              setState(() {
                                this.sortType = sortType;
                              });
                            },
                            itemBuilder: (context) => SortType
                                .sortMessagesMethods
                                .map((sortTypeData) => PopupMenuItem(
                                    child: Text(sortTypeData.name,
                                        style: TextStyle(
                                            color: sortType.name ==
                                                    sortTypeData.name
                                                ? Theme.of(context).primaryColor
                                                : Colors.black,
                                            fontWeight: sortType.name ==
                                                    sortTypeData.name
                                                ? FontWeight.w600
                                                : FontWeight.w400)),
                                    value: sortTypeData))
                                .toList(),
                            child: const Icon(Icons.filter_list),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      chats.isNotEmpty
                          ? ListView.builder(
                              itemBuilder: (context, i) => ChatItem(chats[i]),
                              itemCount: chats.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 16),
                                const Center(
                                    child: Text(
                                  "No Chats Found",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                )),
                                const SizedBox(height: 16),
                                Center(
                                    child: SvgPicture.asset(
                                  'assets/hero_no_results.svg',
                                  height: 200,
                                ))
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
