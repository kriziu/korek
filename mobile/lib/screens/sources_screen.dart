

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';


class SourcesScreen extends StatelessWidget {
  const SourcesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 24,
                ),
                Text(
                  "Sources",
                  style: platformThemeData(
                    context,
                    material: (data) => data.textTheme.headline2,
                    cupertino: (data) => data.textTheme.actionTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "There's sources which we used to build our app",
                  style: platformThemeData(
                    context,
                    material: (data) => data.textTheme.headline6,
                    cupertino: (data) => data.textTheme.navActionTextStyle,
                  ),
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
                    "AVATARS",
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
                Center(
                  child: Text("https://avatars.dicebear.com (avataaars type)",
                      style: platformThemeData(
                        context,
                        material: (data) =>
                            data.textTheme.headline5!.copyWith(fontSize: 15,),
                        cupertino: (data) =>
                            data.textTheme.navActionTextStyle.copyWith(fontSize: 15),
                      )),
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
                    "IMAGES",
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

                Center(
                  child: Text("https://undraw.co",
                      textAlign: TextAlign.center,
                      style: platformThemeData(
                        context,
                        material: (data) =>
                            data.textTheme.headline5!.copyWith(fontSize: 15,),
                        cupertino: (data) =>
                            data.textTheme.navActionTextStyle.copyWith(fontSize: 15),
                      )),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
