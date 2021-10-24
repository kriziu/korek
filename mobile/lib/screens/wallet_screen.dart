import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({Key? key}) : super(key: key);
  final depositController = TextEditingController();
  final withDrawController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<AuthProvider>(context);
    return PlatformScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
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
                height: 24,
              ),
              Text(
                "Your wallet",
                style: platformThemeData(
                  context,
                  material: (data) => data.textTheme.headline2,
                  cupertino: (data) => data.textTheme.actionTextStyle,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    userProvider.user!.wallet.toString() + "\$",
                    style: platformThemeData(
                      context,
                      material: (data) => data.textTheme.headline2!
                          .copyWith(color: Colors.white),
                      cupertino: (data) => data.textTheme.actionTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: AdaptiveButton(
                  onPressed: () {
                    showPlatformDialog(
                        context: context,
                        builder: (context) => PlatformAlertDialog(
                              title: const Text(
                                "Add deposit",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                      "Write how much deposit you want to add."),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: depositController,
                                    minLines: 1,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]+')),
                                    ],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                        hintText: "Deposit"),
                                  )
                                ],
                              ),
                              actions: [
                                PlatformDialogAction(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                PlatformDialogAction(
                                  child: Text("Add",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  onPressed: () async {
                                    final deposit =
                                        double.tryParse(depositController.text);
                                    if (deposit == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Provide correct value"),
                                      ));
                                      return;
                                    }
                                    await userProvider.addDeposit(deposit);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                  child: Text(
                    "Add deposit",
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: AdaptiveButton(
                  onPressed: () {
                    showPlatformDialog(
                        context: context,
                        builder: (context) => PlatformAlertDialog(
                              title: const Text(
                                "Withdraw money",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                      "Write how much deposit you want to withdraw."),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: withDrawController,
                                    minLines: 1,
                                    maxLines: 1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9.]+')),
                                    ],
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                        hintText: "Deposit"),
                                  )
                                ],
                              ),
                              actions: [
                                PlatformDialogAction(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                PlatformDialogAction(
                                  child: Text("Withdraw",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  onPressed: () async {
                                    final withDraw = double.tryParse(withDrawController.text);
                                    if (withDraw == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Provide correct value"),
                                      ));
                                      return;
                                    }
                                    await userProvider.withdraw(withDraw);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ));
                  },
                  child: Text(
                    "Withdraw",
                    style: GoogleFonts.montserrat(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  outlined: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
