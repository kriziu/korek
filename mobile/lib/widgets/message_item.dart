import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:korek/models/message.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final curUserId = Provider.of<AuthProvider>(context).user!.id;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:24.0),
      child: Row(
        children: [
          if (message.from == curUserId)
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
                      bottomLeft: Radius.circular((message.from == curUserId) ? 20 : 0),
                      bottomRight: Radius.circular((message.from == curUserId) ? 0 : 20)),
                  color:(message.from == curUserId)
                      ? const Color(0xffffbc00)
                      : const Color(0xffefefef)),
              child: Text(
                message.message,
                style: TextStyle(
                    color: (message.from == curUserId) ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          if (message.from !=curUserId)
            Expanded(
              child: Container(),
              flex: 1,
            )
        ],
      ),
    );
  }
}
