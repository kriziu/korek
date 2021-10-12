import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:korek/providers/users_provider.dart';
import 'package:korek/screens/home_screen.dart';
import 'package:korek/screens/register_screen.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersProvider>(create: (_) => UsersProvider()),
      ],
      child: PlatformApp(
          title: 'Korek',
          home: const HomeScreen(),
          material: (_, __) => MaterialAppData(
                theme: ThemeData(
                  backgroundColor: Colors.white,
                    textSelectionTheme: const TextSelectionThemeData(
                      cursorColor: Colors.black,
                    ),
                    textTheme: GoogleFonts.montserratTextTheme().copyWith(
                      headline1: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 40),
                      headline2: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 32),
                      headline3: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 28),
                      headline4: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 24),
                      headline5: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 20),
                      headline6: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          color: const Color(0xff999999),
                          fontSize: 16),
                    ),
                    primaryColor: const Color(0xffFFC526),
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      fillColor: const Color(0xffeeeeee),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide.none,
                          gapPadding: 0),
                      hintStyle: const TextStyle(color: Color(0xff343434)),
                    ),
                    iconTheme: const IconThemeData(color: Color(0xff343434))),
              ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                primaryColor: Colors.black,
                actionTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 32),
                textStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 40),
                dateTimePickerTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 40),
                navActionTextStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff999999),
                  fontSize: 16),
                navLargeTitleTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 40),
                navTitleTextStyle:  GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 20),
                pickerTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 40),
                tabLabelTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 40),
              )
            )
          )),
    );
  }
}
