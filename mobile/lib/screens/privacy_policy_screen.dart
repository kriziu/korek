import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/main.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

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
                "Privacy Policy",
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
                "There's short privacy policy of usage our app",
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
                  "POLICY SUMMARY",
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
              Text("Personal data collected for the following purposes and using the following services : ",
                  style: platformThemeData(
                    context,
                    material: (data) =>
                        data.textTheme.headline2!.copyWith(fontSize: 17),
                    cupertino: (data) =>
                        data.textTheme.actionTextStyle.copyWith(fontSize: 17),
                  )),
              const SizedBox(
                height: 16,
              ),
              const ListTile(title: Text('Authenticating',),leading: Icon(Icons.person,color: Colors.black,),),
              const ListTile(title: Text('Communicating with each other',),leading: Icon(Icons.message,color: Colors.black,),),
              const Divider(),
              const SizedBox(
                height: 4,
              ),
              Center(
                child: Text(
                  "CONTACT EMAIL",
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
              const ListTile(title: Text('jan@jan.com',),leading: Icon(Icons.person,color: Colors.black,),),
            ],
          ),
        ),
      ),
    );
  }
}
