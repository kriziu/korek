import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korek/helpers/avatars.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({Key? key}) : super(key: key);

  @override
  _ChangeAvatarScreenState createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  String currentAvatarId = "";

  @override
  void initState() {
    super.initState();
    currentAvatarId =
        Provider.of<AuthProvider>(context, listen: false).user!.avatarId;
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SafeArea(
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
                    height: 16,
                  ),
                  Text(
                    "Change avatar",
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.headline3,
                      cupertino: (data) => data.textTheme.navActionTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      children: avatars
                          .map((img) => GestureDetector(
                                onTap: () => setState(() {
                                  currentAvatarId =
                                      EnumToString.convertToString(img);
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: currentAvatarId ==
                                                EnumToString.convertToString(
                                                    img)
                                            ? Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                width: 4)
                                            : null,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: SvgPicture.asset(
                                            "assets/${EnumToString.convertToString(img)}.svg")),
                                  ),
                                ),
                              ))
                          .toList()),
                  const SizedBox(height: 8,),
                  SizedBox(
                    width: double.infinity,
                    child: AdaptiveButton(
                      onPressed: () async {
                        showPlatformDialog(
                            context: context,
                            builder: (context) => const LoadingDialog(title: "Updating..."));
                        try {
                          await Provider.of<AuthProvider>(context, listen: false).updateUserInfo(
                              "avatarId",currentAvatarId);
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(content: Text("Updated")));
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e.toString())));
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Save",style: TextStyle(color:Colors.white),),
                    ),
                  )
                ]))),
      ),
    );
  }
}
