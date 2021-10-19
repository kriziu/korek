import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/screens/profile_screen.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: key,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "KOREK",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 3),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(platformPageRoute(
                    context: context, builder: (context) => const ProfileScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.policy,
              color: Colors.black,
            ),
            title: const Text('Privacy Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.source,
              color: Colors.black,
            ),
            title: const Text('Sources'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
