import 'package:flutter/material.dart';
import 'package:korek/models/user.dart';
import 'package:korek/providers/users_provider.dart';
import 'package:korek/widgets/review_item.dart';
import 'package:provider/provider.dart';

class ReviewsScreen extends StatefulWidget {
  final User? teacher;
  final bool backButtonVisible;
  const ReviewsScreen(this.teacher,{this.backButtonVisible = false,Key? key}) : super(key: key);

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context,listen: false).getUserRatings(widget.teacher!.id);
  }

  @override
  Widget build(BuildContext context) {
    final ratings = Provider.of<UsersProvider>(context).ratings;
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [

                  if(widget.backButtonVisible)
                    Align(
                      child: IconButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  const SizedBox(height: 32,),
                  Text("Reviews of ${widget.teacher!.firstName} ${widget.teacher!.lastName}",style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
                  const SizedBox(height: 32,),
                  ListView.builder(itemBuilder: (context,i)=>ReviewItem(ratings[i]),shrinkWrap: true,itemCount: ratings.length,)

                ],
              ))),
    );
  }
}
