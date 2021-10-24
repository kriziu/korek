import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/message.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:korek/providers/messages_provider.dart';

class TeacherDetailsScreen extends StatefulWidget {
  final User teacher;
  final int index;

  const TeacherDetailsScreen(this.teacher, this.index, {Key? key})
      : super(key: key);

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  final _controller = TextEditingController();

  Future<void> _sendMessage() async {
    final currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    try {
      if (_controller.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Write bigger message")));
        return;
      }
      showPlatformDialog(
          context: context,
          builder: (_) => const LoadingDialog(title: "Sending..."),
          barrierDismissible: false);

      final roomId = widget.teacher.id + '_' + Provider.of<AuthProvider>(context,listen: false).user!.id;
      appSocket.emit('createRoom', roomId);
      appSocket.emit('joinRoom', roomId);

      await Provider.of<MessagesProvider>(context, listen: false).sendMessage(
          Message(widget.teacher.id + "_" + currentUser!.id, currentUser.id,
              _controller.text));
      Provider.of<MessagesProvider>(context, listen: false).fetchChatted();

      Navigator.of(context)
        ..pop()
        ..pop()
        ..pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Message sent.")));
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SingleChildScrollView(
        child: _content(context),
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  Widget _content(BuildContext context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      48 -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Center(
                      child: Hero(
                          tag: "avatar_${widget.index}",
                          child: SvgPicture.asset(
                            "assets/${widget.teacher.avatarId}.svg",
                            width: 200,
                            height: 200,
                          )),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "${widget.teacher.firstName} ${widget.teacher.lastName}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.teacher.subjectsStr,
                      style: const TextStyle(
                          color: Color(0xffaaaaaa),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 48,
                        ),
                        const SizedBox(width: 4),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text('4.7',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 4),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Text(
                      '${widget.teacher.price}\$/h',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 48,
                  child: AdaptiveButton(
                      child: Text(
                        "Choose teacher",
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
                      ),
                      onPressed: () {
                        showPlatformDialog(
                            context: context,
                            builder: (context) => PlatformAlertDialog(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/${widget.teacher.avatarId}.svg",
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${widget.teacher.firstName} ${widget.teacher.lastName}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text("How I can help you?"),
                                      const SizedBox(height: 8),
                                      TextField(
                                        controller: _controller,
                                        minLines: 3,
                                        maxLines: 3,
                                        decoration: InputDecoration(
                                            hintText: "Message"),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    PlatformDialogAction(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    PlatformDialogAction(
                                      child: Text("Send",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      onPressed: () async {
                                        await _sendMessage();
                                      },
                                    ),
                                  ],
                                ));
                      }),
                ),
              )
            ],
          ),
        ),
      );
}
