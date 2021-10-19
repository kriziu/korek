import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/models/user.dart';
import 'package:korek/widgets/adaptive_button.dart';

class TeacherDetailsScreen extends StatelessWidget {
  final User teacher;
  final int index;

  const TeacherDetailsScreen(this.teacher, this.index, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SingleChildScrollView(
        child: _content(context),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget _content(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 48 - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Center(
                      child: Hero(
                          tag: "avatar_$index",
                          child: SvgPicture.asset(
                            "assets/${teacher.avatarId}.svg",
                            width: 200,
                            height: 200,
                          )),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "${teacher.firstName} ${teacher.lastName}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      teacher.subjectsStr,
                      style: const TextStyle(
                          color: Color(0xffaaaaaa),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 48,
                        ),
                        const SizedBox(width: 4),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('4.7',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Text(
                      '${teacher.price}\$/h',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width-48,
                  child: AdaptiveButton(
                      child: Text(
                        "Choose teacher",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      onPressed: () {
                        showPlatformDialog(
                            context: context,
                            builder: (context) => PlatformAlertDialog(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/${teacher.avatarId}.svg",
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${teacher.firstName} ${teacher.lastName}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text("How I can help you?"),
                                  SizedBox(height: 8),
                                  TextField(
                                    minLines: 3,
                                    maxLines: 3,
                                  )
                                ],
                              ),
                              actions: [
                                PlatformDialogAction(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color:
                                        Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {},
                                ),
                                PlatformDialogAction(
                                  child: Text("Send",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColor)),
                                  onPressed: () {},
                                ),
                              ],
                            ));
                      }),
                ),
              )
            ],
          ),
        ),
      );
}
