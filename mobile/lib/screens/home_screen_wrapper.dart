import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/screens/chat_screen.dart';
import 'package:korek/screens/home_screen.dart';

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  State<HomeScreenWrapper> createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  final views = [const HomeScreen(), const ChatScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        bottomNavBar: PlatformNavBar(
          currentIndex: index,
          itemChanged: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
          ],
        ),
        body: views.elementAt(index));
  }
}
