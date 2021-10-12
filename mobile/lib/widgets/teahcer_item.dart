import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TeacherItem extends StatelessWidget {
  const TeacherItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "https://images.discordapp.net/avatars/555033139542491137/33e7f929df60cf790d8a7a47a7be3f73.png?size=512",
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
                Text("Jan Matejko"),
                Text("Math, Physics, Chemistry f fds  df f fsd dfs sdf",maxLines: 1,overflow: TextOverflow.ellipsis,),
                Row(
                  children: [
                    Icon(Icons.star, color: Theme.of(context).primaryColor),
                    Text('4.7')
                  ],
                ),
              ],
            ),
          ),
        ),
        Text('20\$')
      ]),
    );
  }
}
