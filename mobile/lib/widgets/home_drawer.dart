import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/privacy_policy_screen.dart';
import 'package:korek/screens/profile_screen.dart';
import 'package:korek/screens/sources_screen.dart';
import 'package:korek/screens/wallet_screen.dart';
import 'package:korek/widgets/wrappers/login_wrapper.dart';
import 'package:provider/provider.dart';

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
          const Padding(
            padding: EdgeInsets.only(left: 20.0,top: 24),
            child: Text("App"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet,
              color: Colors.black,
            ),
            title: const Text('Wallet'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(platformPageRoute(
                    context: context, builder: (context) => WalletScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.policy,
              color: Colors.black,
            ),
            title: const Text('Privacy Policy'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(platformPageRoute(
                    context: context, builder: (context) => const PrivacyPolicyScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.source,
              color: Colors.black,
            ),
            title: const Text('Sources'),
            onTap: () {
              Navigator.of(context)
                ..pop()
                ..push(platformPageRoute(
                    context: context, builder: (context) => const SourcesScreen()));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0,top: 24),
            child: Text("Settings"),
          ),
          const Divider(),
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
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text('Log Out'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .logOut();
              Navigator.of(context).pushAndRemoveUntil(
                  platformPageRoute(
                      context: context,
                      builder: (context) => const LoginWrapper()),
                      (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
