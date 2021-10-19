import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/models/update_data.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/providers/users_provider.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';

class ChangeProfileItemScreen extends StatefulWidget {
  final UpdateData updateData;

  const ChangeProfileItemScreen(this.updateData, {Key? key}) : super(key: key);

  @override
  _ChangeProfileItemScreenState createState() =>
      _ChangeProfileItemScreenState();
}

class _ChangeProfileItemScreenState extends State<ChangeProfileItemScreen> {
  String newValue = "";

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    switch (widget.updateData.databaseName) {
      case 'firstName':
        newValue = user!.firstName;
        break;
      case 'lastName':
        newValue = user!.lastName;
        break;
      case 'email':
        newValue = user!.email;
        break;
      case 'price':
        newValue = user!.price.toString();
        break;
    }
  }

  Future<void> updateUserField() async {
    showPlatformDialog(
        context: context,
        builder: (context) => const LoadingDialog(title: "Updating..."));
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .updateUserInfo(widget.updateData.databaseName, newValue);
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
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Padding(
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
                "Change ${widget.updateData.name}",
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.headline3,
                  cupertino: (data) => data.textTheme.navActionTextStyle,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              PlatformTextFormField(
                initialValue: newValue,
                onFieldSubmitted: (val) async {
                  await updateUserField();
                },
                onChanged: (val) {
                  setState(() => newValue = val);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton(
                      child: const Text(
                        "Change",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        await updateUserField();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
