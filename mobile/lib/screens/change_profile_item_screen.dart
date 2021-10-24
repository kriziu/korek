import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/helpers/subjects.dart';
import 'package:korek/models/update_data.dart';
import 'package:korek/providers/auth_provider.dart';
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
  List<Subjects?> subjects = [];

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
      case 'subjects':
        subjects = user!.subjects;
        break;
    }
  }

  Future<void> updateUserField() async {
    showPlatformDialog(
        context: context,
        builder: (context) => const LoadingDialog(title: "Updating..."));
    try {
      await Provider.of<AuthProvider>(context, listen: false).updateUserInfo(
          widget.updateData.databaseName,
          widget.updateData.databaseName == 'subjects'
              ? subjects.map((e) => EnumToString.convertToString(e)).toList()
              : newValue);
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
              if (widget.updateData.databaseName != 'subjects')
                PlatformTextFormField(
                  initialValue: newValue,
                  onFieldSubmitted: (val) async {
                    await updateUserField();
                  },
                  onChanged: (val) {
                    setState(() => newValue = val);
                  },
                ),
              if (widget.updateData.databaseName == 'subjects')
                SizedBox(
                  width: double.infinity,
                  child: AdaptiveButton(
                      outlined: true,
                      child: Text(
                        "Choose Subjects",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      onPressed: () {
                        showPlatformModalSheet(
                          context: context,
                          builder: (_) => PlatformWidget(
                            material: (_, __) => _chooseSubjectsContent(),
                            cupertino: (_, __) => _chooseSubjectsContent(),
                          ),
                        );
                      }),
                ),
              const SizedBox(
                height: 8,
              ),
              if (widget.updateData.databaseName == 'subjects')
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: subjects
                        .map((subject) => Text(EnumToString.convertToString(
                                subject,
                                camelCase: true) +
                            ", "))
                        .toList()),
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
                        if (widget.updateData.databaseName == 'subjects' &&
                            subjects.isEmpty) {
                          return ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Choose at least one subject"),
                          ));
                        }
                        await updateUserField();
                      }))
            ],
          ),
        ),
      ),
    );
  }

  Widget _chooseSubjectsContent() => StatefulBuilder(
        builder: (BuildContext context, setState) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (content, i) => CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      this.setState(() {
                        if (subjects.contains(subjectsList[i])) {
                          subjects.remove(subjectsList[i]);
                        } else {
                          subjects.add(subjectsList[i]);
                        }
                      });
                    });
                  },
                  value: subjects.contains(subjectsList[i]),
                  title: Text(EnumToString.convertToString(subjectsList[i],
                      camelCase: true)),
                ),
            itemCount: subjectsList.length),
      );
}
