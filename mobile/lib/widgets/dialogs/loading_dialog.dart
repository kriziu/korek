import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class LoadingDialog extends StatelessWidget {

  final String title;
  const LoadingDialog({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformAlertDialog(
      content: Row(
        children: [
          PlatformCircularProgressIndicator(
            material: (_, __) => MaterialProgressIndicatorData(
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 10,), Text(title),
        ],
      ),
    );
  }
}
