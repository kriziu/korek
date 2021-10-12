import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AdaptiveButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final bool outlined;

  const AdaptiveButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.outlined = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: () => onPressed(),
            child: child,
            color: const Color(0xffFFC526),
          )
        : TextButton(
            onPressed: () => onPressed(),
            child: child,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              backgroundColor:
              outlined ? Colors.white : Theme.of(context).primaryColor,
              side: outlined
                  ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
                  : BorderSide.none,
            ),
          );
  }
}
