import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/helpers/avatars.dart';
import 'package:korek/helpers/subjects.dart';
import 'package:korek/models/register_data.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/widgets/wrappers/home_screen_wrapper.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _registerData = RegisterData();

  Future<void> _registerUser() async {
    try {
      if (_formKey.currentState!.validate()) {
        showPlatformDialog(
            context: context,
            builder: (_) => const LoadingDialog(title: "Registering..."),
            barrierDismissible: false);
        if (_registerData.subjects.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Choose at least 1 subject")));
          return;
        }
        await Provider.of<AuthProvider>(context, listen: false)
            .registerUser(_registerData);
        Navigator.of(context)
          ..pop()
          ..pushAndRemoveUntil(
              platformPageRoute(
                context: context,
                builder: (context) => const HomeScreenWrapper(),
              ),
              (Route<dynamic> route) => false);
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to korek!",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Sing up before starting learning new things!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : 'Provide correct email',
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(fontSize: 15),
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                              hintText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.alternate_email,
                                size: 24,
                                color: Color(0xff343434),
                              ))),
                      onChanged: (val) => _registerData.email = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.next,
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
                      onChanged: (val) => _registerData.firstName = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) =>
                          val!.length > 1 ? null : 'Provide correct last name',
                      style: const TextStyle(fontSize: 15),
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                        hintText: 'Last Name',
                        prefixIcon: Icon(
                          Icons.person_search_outlined,
                          size: 24,
                          color: Color(0xff343434),
                        ),
                      )),
                      onChanged: (val) => _registerData.lastName = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (val) => val!.length >= 6
                          ? null
                          : 'Provide min 6 letters password',
                      style: const TextStyle(fontSize: 15),
                      obscureText: true,
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_open,
                          size: 24,
                          color: Color(0xff343434),
                        ),
                      )),
                      onChanged: (val) => _registerData.password = val,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    PlatformTextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.length < 6) {
                          return 'Provide min 6 letters password';
                        }
                        if (val != _registerData.password) {
                          return 'Passwords don\'t match';
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 15),
                      obscureText: true,
                      material: (_, __) => MaterialTextFormFieldData(
                          decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          size: 24,
                          color: Color(0xff343434),
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 24,
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
                      isSelected: [
                        _registerData.userType == "student",
                        _registerData.userType == "teacher"
                      ],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            _registerData.userType = "student";
                          } else {
                            _registerData.userType = "teacher";
                          }
                        });
                      },
                    ),
                    if (_registerData.userType == "teacher")
                      const SizedBox(
                        height: 16,
                      ),
                    if (_registerData.userType == "teacher")
                      PlatformTextFormField(
                        textInputAction: TextInputAction.done,
                        validator: (val) => double.tryParse(val!) == null
                            ? "Wpisz poprawn wartość"
                            : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
                        ],
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(fontSize: 15),
                        material: (_, __) => MaterialTextFormFieldData(
                            decoration: const InputDecoration(
                          hintText: 'Price / h',
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            size: 24,
                            color: Color(0xff343434),
                          ),
                        )),
                        onChanged: (val) =>
                            _registerData.price = double.tryParse(val) ?? 20,
                      ),
                    const SizedBox(
                      height: 24,
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
                        outlined: true,
                        child: Text(
                          "Choose school subjects!",
                          style: GoogleFonts.montserrat(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
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
                      height: 24,
                    ),
                    Center(
                      child: Text("Choose avatar",
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
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showPlatformModalSheet(
                          context: context,
                          builder: (_) => PlatformWidget(
                            material: (_, __) => _chooseAvatarContent(),
                            cupertino: (_, __) => _chooseAvatarContent(),
                          ),
                        );
                      },
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset(
                              'assets/${_registerData.avatarId}.svg'),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 4),
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        child: Text(
                          "Register",
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () async => await _registerUser(),
                      ),
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: AdaptiveButton(
                        outlined: true,
                        child: Text(
                          "Have an account? Login",
                          style: GoogleFonts.montserrat(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            platformPageRoute(
                              context: context,
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                      width: double.infinity,
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

  Widget _chooseSubjectsContent() => StatefulBuilder(
        builder: (BuildContext context, setState) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (content, i) => CheckboxListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  checkColor: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      if (_registerData.subjects.contains(subjectsList[i])) {
                        _registerData.subjects.remove(subjectsList[i]);
                      } else {
                        _registerData.subjects.add(subjectsList[i]);
                      }
                    });
                  },
                  value: _registerData.subjects.contains(subjectsList[i]),
                  title: Text(EnumToString.convertToString(subjectsList[i],
                      camelCase: true)),
                ),
            itemCount: subjectsList.length),
      );

  Widget _chooseAvatarContent() => StatefulBuilder(
        builder: (BuildContext context, setState) => Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          height: 150,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (content, i) => GestureDetector(
                    onTap: () {
                      setState(() => _registerData.avatarId =
                          EnumToString.convertToString(avatars[i]));
                      this.setState(() {
                        _registerData.avatarId =
                            EnumToString.convertToString(avatars[i]);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 100,
                      height: 100,
                      child: SvgPicture.asset(
                          'assets/${EnumToString.convertToString(avatars[i])}.svg'),
                      decoration: BoxDecoration(
                          border: _registerData.avatarId ==
                                  EnumToString.convertToString(avatars[i])
                              ? Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 4)
                              : null,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
              itemCount: avatars.length),
        ),
      );
}
