import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/update_data.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/screens/change_avatar_screen.dart';
import 'package:korek/screens/change_profile_item_screen.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/wrappers/login_wrapper.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return PlatformScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: user != null ? Column(
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
                GestureDetector(
                  onTap: () => Navigator.of(context).push(platformPageRoute(
                      context: context,
                      builder: (context) => const ChangeAvatarScreen())),
                  child: Stack(
                    children: [
                      Hero(
                        tag: "profileimg",
                        child: SvgPicture.asset("assets/${user.avatarId}.svg",
                            width: 120, height: 120),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: const TextStyle(
                      color: Color(0xffaaaaaa),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                // SwitchListTile(title: Row(
                //   children: const [
                //     Icon(Icons.nightlight_round),
                //     SizedBox(width:8),
                //     Text("Night mode"),
                //   ],
                // ), onChanged: (bool value) {
                // }, value: true,),
                ListView.builder(
                  itemBuilder: (context, i) => _settingItem(i),
                  itemCount: UpdateData.updatedData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
                const SizedBox(height: 16,),
                SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton(
                    child: Text("Log out",style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),),
                    onPressed: () async {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          platformPageRoute(
                              context: context,
                              builder: (context) => const LoginWrapper()),
                              (route) => false);

                    },
                  ),
                )
              ],
            ) : const Text("Something went wrong!"),
          ),
        ),
      ),
    );
  }

  Widget _settingItem(int index) {
    final updateDataObj = UpdateData.updatedData[index];
    if (updateDataObj.databaseName == "price" &&
        Provider.of<AuthProvider>(context, listen: false).user!.userType ==
            "student") return Container();

    return GestureDetector(
      onTap: () => Navigator.of(context).push(platformPageRoute(
          context: context,
          builder: (context) => ChangeProfileItemScreen(updateDataObj))),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffefefef),
            borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(updateDataObj.icon, size: 28),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              "Change ${updateDataObj.name}",
              style: const TextStyle(color: Colors.black, fontSize: 17),
            )),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
