import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/screens/login_screen.dart';
import 'package:korek/screens/register_screen.dart';
import 'package:korek/widgets/adaptive_button.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to korek!",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                "Sign in or register before starting",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                child: AdaptiveButton(
                  child: Text(
                    "Register",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      platformPageRoute(
                        context: context,
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                ),
                width: double.infinity,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: AdaptiveButton(
                  outlined: true,
                  child: Text(
                    "Log in",
                    style: GoogleFonts.montserrat(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      platformPageRoute(
                        context: context,
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
