import 'package:flutter/material.dart';

class SubjectItem extends StatelessWidget {
  final String subject;
  final int index;

  const SubjectItem({Key? key, required this.subject, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: index == 0 ? 28 : 16, right: index == 11 ? 28 : 16),
      child: Text(subject,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: index == 0 ? Theme.of(context).primaryColor : const Color(0xffaaaaaa))),
    );
  }
}
