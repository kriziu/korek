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
          left: index == 0 ? 32 : 16, right: index == 11 ? 32 : 16),
      child: Text(subject,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: Color(0xffaaaaaa))),
    );
  }
}
