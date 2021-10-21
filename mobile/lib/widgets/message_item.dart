import 'dart:ui';

import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  final int index;

  const MessageItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24.0),
      child: Row(
        children: [
          if (index % 2 == 1)
            Expanded(
              child: Container(),
              flex: 1,
            ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(index % 2 == 1 ? 20 : 0),
                      bottomRight: Radius.circular(index % 2 == 1 ? 0 : 20)),
                  color: index % 2 == 1
                      ? const Color(0xffffbc00)
                      : const Color(0xffefefef)),
              child: Text(
                "Text widomosci essa essa ezssa essae sswea sa asd sdfkmnksdfjnksdkjsdgkojsdfjiksd",
                style: TextStyle(
                    color: index % 2 == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (index % 2 == 0)
            Expanded(
              child: Container(),
              flex: 1,
            )
        ],
      ),
    );
  }
}
