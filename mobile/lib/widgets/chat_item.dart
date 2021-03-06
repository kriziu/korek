import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/rating.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/providers/messages_provider.dart';
import 'package:korek/providers/users_provider.dart';
import 'package:korek/screens/chat_screen.dart';
import 'package:korek/screens/pay_screen.dart';
import 'package:korek/widgets/adaptive_button.dart';
import 'package:korek/widgets/dialogs/loading_dialog.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatelessWidget {
  final User user;

  const ChatItem(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () => showPlatformDialog(
          context: context,
          builder: (context) => PlatformAlertDialog(
                title: const Text(
                  "Are you sure to delete this chat?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
                actions: [
                  PlatformDialogAction(
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  PlatformDialogAction(
                    child: Text("Delete",
                        style:
                            TextStyle(color: Theme.of(context).primaryColor)),
                    onPressed: () {
                      final currentUser =
                          Provider.of<AuthProvider>(context, listen: false)
                              .user;
                      if (currentUser != null) {
                        final roomId = currentUser.userType == "teacher"
                            ? currentUser.id + "_" + user.id
                            : user.id + "_" + currentUser.id;
                        appSocket.emit("deleteRoom", roomId);
                        Provider.of<MessagesProvider>(context, listen: false)
                            .deleteChat(roomId, user.id);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )),
      onTap: () {
        FocusScope.of(context).unfocus();
        Provider.of<MessagesProvider>(context, listen: false).clearMessages();
        Navigator.of(context).push(platformPageRoute(
            context: context, builder: (context) => ChatScreen(user)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SvgPicture.asset(
              "assets/${user.avatarId}.svg",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    user.userType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Color(0xffaaaaaa),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  if (user.userType == "teacher")
                    const SizedBox(
                      height: 4,
                    ),
                  if (user.userType == "teacher")
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                        const SizedBox(width: 4),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(user.rate.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                  if (user.userType == "teacher")
                    const SizedBox(
                      height: 4,
                    ),
                  if (user.userType == "teacher")
                    Row(
                      children: [
                        Expanded(
                          child: AdaptiveButton(
                            smallPadding: true,
                            onPressed: () {
                              Navigator.of(context).push(platformPageRoute(
                                  context: context,
                                  builder: (context) => PayScreen(user)));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text("Pay",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: AdaptiveButton(
                            smallPadding: true,
                            outlined: true,
                            onPressed: () {
                              final Rating rating = Rating(5, "", "");
                              showPlatformDialog(
                                  context: context,
                                  builder: (context) =>
                                      _ratingDialog(context, rating));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Rate",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_right)
        ]),
      ),
    );
  }

  Widget _ratingDialog(BuildContext context, Rating rating) =>
      PlatformAlertDialog(
        title: Text(
          "Add rate to ${user.firstName} ${user.lastName}",
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                glowColor: Colors.amber,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).primaryColor,
                ),
                onRatingUpdate: (r) {
                  rating.stars = r.toInt();
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            PlatformTextField(
              onChanged: (val) => rating.message = val,
              hintText: 'Optional Message',
              minLines: 3,
              maxLines: 5,
            )
          ],
        ),
        actions: [
          PlatformDialogAction(
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          PlatformDialogAction(
            child: Text("Add Rate",
                style: TextStyle(color: Theme.of(context).primaryColor)),
            onPressed: () async {
              try {
                showPlatformDialog(
                    context: context,
                    builder: (_) => const LoadingDialog(title: "Adding rate..."),
                    barrierDismissible: false);
                rating.teacherId = user.id;
                await Provider.of<UsersProvider>(context, listen: false)
                    .addRate(rating);
                await Provider.of<MessagesProvider>(context, listen: false)
                    .fetchChatted();
                Navigator.of(context)
                  ..pop()
                  ..pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rate Added")));
              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
          ),
        ],
      );
}
