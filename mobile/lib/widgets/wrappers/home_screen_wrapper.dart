import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/chats_screen.dart';
import 'package:korek/screens/home_screen.dart';
import 'package:provider/provider.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  final views = [const HomeScreen(), const ChatsScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return PlatformScaffold(
        bottomNavBar: (user != null && user.userType == "student")
            ? PlatformNavBar(
                currentIndex: index,
                itemChanged: (i) => setState(() => index = i),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.school), label: 'Learn'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat), label: 'Chats'),
                ],
              )
            : null,
        body: (user != null && user.userType == "student")
            ? IndexedStack(
                children: views,
                index: index,
              )
            : const ChatsScreen());
  }
}
