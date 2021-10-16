import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korek/models/user.dart';

class TeacherItem extends StatelessWidget {
  final User teacher;
  const TeacherItem(this.teacher,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:SvgPicture.asset("assets/${teacher.avatarId}.svg",
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
                 "${teacher.firstName} ${teacher.lastName}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18  ,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  teacher.subjectsStr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
        Text('${teacher.price}\$',style: const TextStyle(
            color: Colors.black,
            fontSize: 18  ,
            fontWeight: FontWeight.w700),)
      ]),
    );
  }
}
