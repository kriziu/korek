import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/home_screen.dart';
import 'package:korek/widgets/wrappers/login_wrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var isLoading = true;
  var isLogged = false;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  Future<void> autoLogIn() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.autoIdLogin();
      setState(() => isLoading = false);
      if(authProvider.user == null)  setState(() => isLogged = false);
      if(authProvider.user != null)  setState(() => isLogged = true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlatformCircularProgressIndicator(
                  material: (_, __) => MaterialProgressIndicatorData(
                      color: Theme.of(context).primaryColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      if (isLogged) {
        return const HomeScreen();
      } else {
        return const LoginWrapper();
      }
    }
  }
}
