import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/subjects.dart';
import 'package:korek/widgets/adaptive_button.dart';

class MoreRegisterDataScreen extends StatefulWidget {
  const MoreRegisterDataScreen({Key? key}) : super(key: key);

  @override
  State<MoreRegisterDataScreen> createState() => _MoreRegisterDataScreenState();
}

class _MoreRegisterDataScreenState extends State<MoreRegisterDataScreen> {
  final _formKey = GlobalKey<FormState>();

  final _registerData = {
    'email': '',
    'password': '',
  };

  var isTeacher = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
          context,
          platformPageRoute(
              context: context,
              builder: (context) => const MoreRegisterDataScreen(),
              settings: RouteSettings(arguments: _registerData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thanks for joining!",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tell us more about you!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    PlatformTextFormField(
                      validator: (val) =>
                          val!.length > 1 ? null : 'Provide correct first name',
                      style: const TextStyle(fontSize: 15),
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                              hintText: 'First name',
                              prefixIcon: Icon(
                                Icons.person_outline,
                                size: 24,
                                color: Color(0xff343434),
                              ))),
                      onChanged: (val) => _registerData['email'] = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      validator: (val) =>
                          val!.length > 1 ? null : 'Provide correct last name',
                      style: const TextStyle(fontSize: 15),
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                        hintText: 'Second Name',
                        prefixIcon: Icon(
                          Icons.person_search_outlined,
                          size: 24,
                          color: Color(0xff343434),
                        ),
                      )),
                      onChanged: (val) => _registerData['password'] = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text("Who you are?",
                          style: platformThemeData(
                            context,
                            material: (data) => data.textTheme.headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                            cupertino: (data) =>
                                data.textTheme.navTitleTextStyle,
                          )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ToggleButtons(
                      constraints: BoxConstraints(
                          minWidth:
                              (MediaQuery.of(context).size.width - 51) / 2),
                      borderColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).primaryColor,
                      selectedBorderColor: Theme.of(context).primaryColor,
                      selectedColor: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          child: Row(
                            children: const [
                              Icon(Icons.school_rounded),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Student')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          child: Row(
                            children: const [
                              Icon(Icons.airplay),
                              SizedBox(
                                width: 8,
                              ),
                              Text('Teacher')
                            ],
                          ),
                        ),
                      ],
                      isSelected: [!isTeacher, isTeacher],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            isTeacher = false;
                          } else {
                            isTeacher = true;
                          }
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: Text("What you want to learn?",
                          style: platformThemeData(
                            context,
                            material: (data) => data.textTheme.headline5!
                                .copyWith(fontWeight: FontWeight.w700),
                            cupertino: (data) =>
                                data.textTheme.navTitleTextStyle,
                          )),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        child: Text(
                          "Choose school subjects!",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () {
                          showPlatformModalSheet(
                            context: context,
                            builder: (_) => PlatformWidget(
                              material: (_, __) => _chooseSubjectsContent(),
                              cupertino: (_, __) => _chooseSubjectsContent(),
                            ),
                          );
                        },
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        child: Text(
                          "Go inside!",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () async => await _submitForm(),
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chooseSubjectsContent() => ListView.builder(
      itemBuilder: (content, i) => CheckboxListTile(
            onChanged: (bool? value) {},
            value: true,
            title: Text(EnumToString.convertToString(subjectsList[i],
                camelCase: true)),
          ),
      itemCount: subjectsList.length);
}
