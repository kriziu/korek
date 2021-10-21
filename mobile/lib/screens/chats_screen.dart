import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korek/models/filters.dart';
import 'package:korek/providers/auth_provider.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(
          widgetKey: _scaffoldKey, drawer: const HomeDrawer()),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async => {},
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
                            onChanged: (str) {},
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {});
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
                              setState(() {});
                            },
                            itemBuilder: (context) => SortType.sortMethods
                                .map((sortType) => PopupMenuItem(
                                    child: Text(sortType.name,
                                        style: const TextStyle(
                                          // color: _filters.sortType.name ==
                                          //     sortType.name
                                          //     ? Theme.of(context).primaryColor
                                          //     :
                                          color: Colors.black,
                                          // fontWeight: _filters.sortType.name ==
                                          //     sortType.name
                                          //     ? FontWeight.w600
                                          //     : FontWeight.w400),
                                        )),
                                    value: sortType))
                                .toList(),
                            child: const Icon(Icons.filter_list),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ListView.builder(
                        itemBuilder: (context, index) => const ChatItem(),
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
