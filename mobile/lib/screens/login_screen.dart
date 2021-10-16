import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/register_screen.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _loginData = {
    'email': '',
    'password': '',
  };

  Future<void> _login() async {
    try {
      if (_formKey.currentState!.validate()) {
        showPlatformDialog(
            context: context,
            builder: (_) => const LoadingDialog(title: "Loging..."),
            barrierDismissible: false);
        await Provider.of<AuthProvider>(context, listen: false).logIn(_loginData);
        Navigator.of(context)
          ..pop()
          ..pushAndRemoveUntil(
              platformPageRoute(
                context: context,
                builder: (context) => const HomeScreen(),
              ),
              (Route<dynamic> route) => false);
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to korek!",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Sing in before starting learning new things!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : 'Provide correct email',
                      style: const TextStyle(fontSize: 15),
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                              hintText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                size: 24,
                                color: Color(0xff343434),
                              ))),
                      onChanged: (val) => _loginData['email'] = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      onFieldSubmitted: (value) async {
                        await _login();
                      },
                      validator: (val) => val!.length >= 6
                          ? null
                          : 'Provide min 6 letters password',
                      style: const TextStyle(fontSize: 15),
                      obscureText: true,
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 24,
                          color: Color(0xff343434),
                        ),
                      )),
                      onChanged: (val) => _loginData['password'] = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        child: Text(
                          "Login",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () async => await _login(),
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        outlined: true,
                        child: Text(
                          "Don't have an account? Register",
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
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                      ),
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
