import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/widgets/adaptive_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
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
                  "Sing up before starting learning new things!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 48,
                ),
                PlatformTextFormField(
                  style: const TextStyle(fontSize: 15),
                  material: (_, __) => MaterialTextFormFieldData(
                      decoration: const InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            size: 24,
                            color: Color(0xff343434),
                          ))),
                ),
                const SizedBox(
                  height: 16,
                ),
                PlatformTextFormField(
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
                ),
                const SizedBox(
                  height: 16,
                ),
                PlatformTextFormField(
                  style: const TextStyle(fontSize: 15),
                  obscureText: true,
                  material: (_, __) => MaterialTextFormFieldData(
                      decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      size: 24,
                      color: Color(0xff343434),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 16,
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
                    onPressed: () {},
                  ),
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an account?",style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.headline5!.copyWith(fontSize: 14.5,color:Colors.black),
                      cupertino: (data) => data.textTheme.navTitleTextStyle.copyWith(fontSize: 14.5,color:Colors.black),
                    )),
                    Text(" Login here",style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.headline5!.copyWith(fontSize: 14.5,color:Theme.of(context).primaryColor),
                      cupertino: (data) => data.textTheme.navTitleTextStyle.copyWith(fontSize: 14.5,color:Theme.of(context).primaryColor),
                    ),),
                    const SizedBox(width: 4,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
