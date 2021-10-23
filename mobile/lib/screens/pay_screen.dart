import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/models/user.dart';
import 'package:korek/widgets/adaptive_button.dart';

class PayScreen extends StatelessWidget {
  final User teacher;

  const PayScreen(this.teacher, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Pay ${teacher.firstName} ${teacher.lastName}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: Text(
                    "YOUR BALANCE :",
                    style: platformThemeData(
                      context,
                      material: (data) =>
                          data.textTheme.headline2!.copyWith(fontSize: 17),
                      cupertino: (data) =>
                          data.textTheme.actionTextStyle.copyWith(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: const Center(
                      child: FittedBox(
                    child: Text(
                      "54\$",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Divider(),
                const SizedBox(
                  height: 4,
                ),
                Center(
                  child: Text(
                    "PAY :",
                    style: platformThemeData(
                      context,
                      material: (data) =>
                          data.textTheme.headline2!.copyWith(fontSize: 17),
                      cupertino: (data) =>
                          data.textTheme.actionTextStyle.copyWith(fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: const Center(
                      child: FittedBox(
                    child: Text(
                      "25\$",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton(
                    onPressed: () {},
                    child: Text(
                      "Pay",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton(
                    onPressed: () {},
                    child: Text(
                      "Add deposit",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 17),
                    ),
                    outlined: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
