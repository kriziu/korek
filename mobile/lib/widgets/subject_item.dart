import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:korek/helpers/subjects.dart';

class SubjectItem extends StatelessWidget {
  final Subjects subject;
  final void Function(Subjects) chooseSubject;
  final bool isChosen;
  final int index;

  const SubjectItem(
      {Key? key,
      required this.subject,
      required this.index,
      required this.isChosen,
      required this.chooseSubject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        chooseSubject(subject);
      },
      child: Container(
        padding: EdgeInsets.only(
            left: index == 0 ? 28 : 16, right: index == 11 ? 28 : 16),
        child: Text(EnumToString.convertToString(subject, camelCase: true),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: isChosen
                    ? Theme.of(context).primaryColor
                    : const Color(0xffaaaaaa))),
      ),
    );
  }
}
