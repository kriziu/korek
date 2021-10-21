import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korek/widgets/message_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();



  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) => MaterialAppBarData(
            elevation: 1,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            )),
        backgroundColor: Colors.white,
        title: const Text(
          "Jan Matejko",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      controller: _controller,
                      itemBuilder: (context, index) => MessageItem(index),
                      itemCount: 10,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(8,8,8,8),
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
                          hintText: "Start typing...",
                        )),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Icon(Icons.send,color: Colors.white,),
                        )
                      ],
                    ),
                  )
      ])),
    );
  }
}
