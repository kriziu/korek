import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:korek/helpers/helpers.dart';
import 'package:korek/models/message.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/auth_provider.dart';
import 'package:korek/providers/messages_provider.dart';
import 'package:korek/widgets/message_item.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final User chatUser;

  const ChatScreen(this.chatUser, {Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();
  final _inputController = TextEditingController();
  late final Message message;
  late IO.Socket socket;

  Future<void> _fetchMessages() async {
    try {
      await Provider.of<MessagesProvider>(context, listen: false)
          .fetchChatMessages(message.roomId);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error : ${e.toString()}")));
    }
  }

  @override
  void initState() {
    final currentUser = Provider.of<AuthProvider>(context, listen: false).user;

    final roomId = currentUser!.userType == "teacher"
        ? currentUser.id + "_" + widget.chatUser.id
        : widget.chatUser.id + "_" + currentUser.id;
    socket = IO.io(
      BASE_URL,
      <String, dynamic>{
        'transports': ['websocket'],
      },
    );
    socket.onConnect((data) {
      socket.emit("joinRoom", roomId);
      socket.on("receive", (msg) {
        Provider.of<MessagesProvider>(context, listen: false)
            .receiveMessage(Message.fromJson(msg));
      });
    });
    socket.connect();

    message = Message(roomId, currentUser.id, "");
    _fetchMessages();
    super.initState();
  }

  Future<void> _sendMessage() async {
    if (_inputController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Write correct message")));
      return;
    }
    socket.emit("send", {
      "roomId": message.roomId,
      "from": message.from,
      "message": message.message,
    });
    Provider.of<MessagesProvider>(context, listen: false).sendMessage(message);
    _inputController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final messages =
        Provider.of<MessagesProvider>(context).messages.reversed.toList();

    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(
            elevation: 1,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            )),
        backgroundColor: Colors.white,
        title: Text(
          "${widget.chatUser.firstName} ${widget.chatUser.lastName}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 20),
        ),
        trailingActions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        ],
      ),
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        messages.isNotEmpty
            ? Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  controller: _controller,
                  itemBuilder: (context, i) => MessageItem(messages[i]),
                  itemCount: messages.length,
                ),
              )
            : Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
        Container(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: PlatformTextField(
                controller: _inputController,
                onChanged: (val) => message.message = val,
                hintText: "Start typing...",
              )),
              GestureDetector(
                onTap: () => _sendMessage(),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        )
      ])),
    );
  }
}
