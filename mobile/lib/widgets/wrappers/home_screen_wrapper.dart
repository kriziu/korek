import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/chats_screen.dart';
import 'package:korek/screens/home_screen.dart';
import 'package:korek/screens/reviews_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  final views = [const HomeScreen(), const ChatsScreen()];
  List<Widget> teacherViews = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    teacherViews = [const ChatsScreen(), ReviewsScreen(Provider.of<AuthProvider>(context,listen: false).user)];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return PlatformScaffold(
        bottomNavBar: PlatformNavBar(
                currentIndex: index,
                itemChanged: (i) => setState(() => index = i),
                items:  [
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.school), label: user?.userType == "student" ? 'Learn' : "Chats"),
                  BottomNavigationBarItem(
                      icon: const Icon(Icons.chat), label: user?.userType == "student" ? 'Chats' : "Reviews"),
                ],
              ),
        body: (user?.userType == "student")
            ? IndexedStack(
                children: views,
                index: index,
              )
            : IndexedStack(
          children: teacherViews,
          index: index,
        ));
  }
}
