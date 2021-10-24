import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:korek/models/rating.dart';


class ReviewItem extends StatelessWidget {


  final Rating rating;
  const ReviewItem(this.rating,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SvgPicture.asset(
            "assets/${rating.from!.avatarId}.svg",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 4,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingBar.builder(
              ignoreGestures: true,
              initialRating: double.parse(rating.stars.toString()),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              glowColor: Colors.amber,
              itemPadding: const EdgeInsets.symmetric(horizontal: 0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              itemSize: 16,
              onRatingUpdate: (r) {
                rating.stars = r.toInt();
              },
            ),
            const SizedBox(height: 4,),
            Text(rating.message),
            const SizedBox(height: 12,),
            Text(rating.from!.firstName + " " + rating.from!.lastName,style: TextStyle(color: Colors.grey[500]),),
          ],
        )

      ],
    );
  }
}
