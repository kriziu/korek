import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TeacherItem extends StatelessWidget {
  const TeacherItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                const Text(
                  "Jan Matejko",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18  ,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  "Math, Physics, Chemistry",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color(0xffaaaaaa),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star_outlined, color: Theme.of(context).primaryColor,size: 28,),
                    const SizedBox(width:4),
                    const Padding(
                      padding: EdgeInsets.only(top:4.0),
                      child: Text('4.7',style:TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        const Text('20\$',style: TextStyle(
            color: Colors.black,
            fontSize: 18  ,
            fontWeight: FontWeight.w700),)
      ]),
    );
  }
}
