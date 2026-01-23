import 'package:crafty_bay/features/product_review/data/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key, required this.model, required this.index,
  });

  final ReviewModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .center,
              children: [
                CircleAvatar(backgroundColor: Colors.grey.withAlpha(100), radius: 16, child: Icon(Icons.person_outline,),),
                SizedBox(width: 8,),
                Text('${model.firstName} ${model.lastName} (${index+1})', style: TextStyle(color: Colors.black, fontWeight: .w600),)
              ],
            ),
            SizedBox(height: 8,),
            Text(model.review),

          ],
        ),
      ),
    );
  }
}