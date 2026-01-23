import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/product_review/data/models/review_model.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/delete_review_provider.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/review_provider.dart';
import 'package:crafty_bay/features/product_review/presentation/screens/add_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatefulWidget {
  const ReviewCard({
    super.key, required this.model, required this.productId,
  });

  final ReviewModel model;
  final String productId;

  @override
  State<ReviewCard> createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {

  final DeleteReviewProvider _deleteReviewProvider = DeleteReviewProvider();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ChangeNotifierProvider(
        create: (context) => _deleteReviewProvider,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .center,
                    children: [
                      CircleAvatar(backgroundColor: Colors.grey.withAlpha(100), radius: 16, child: Icon(Icons.person_outline,),),
                      SizedBox(width: 8,),
                      Text('${widget.model.firstName} ${widget.model.lastName}', style: TextStyle(color: Colors.black, fontWeight: .w600),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text(widget.model.review),

                ],
              ),
              Column(
                children: [
                Consumer<DeleteReviewProvider>(
                  builder: (context, _, _) {
                    if(_deleteReviewProvider.deleteReviewInProgress){
                      return CenterCircularProgress();
                    }
                    return GestureDetector(
                        onTap: () {
                          _onTapDeleteReview();
                        },
                        child: Icon(Icons.delete));
                  }
                ),
                SizedBox(height: 8,),
                GestureDetector(
                    onTap: () {
                      _onTapEditButton();
                    },
                    child: Icon(Icons.edit))
              ],)
            ],
          ),
        ),
      ),
    );
  }

  void _onTapEditButton(){
    Map<String, dynamic> map = {
      "productId" : widget.productId,
      "reviewModel" : widget.model
    };
    Navigator.pushNamed(context, AddReviewScreen.name, arguments: map);
  }


  Future<void> _onTapDeleteReview() async {
    bool isSuccess = await _deleteReviewProvider.deleteReview(reviewId: widget.model.id);
    if(isSuccess){
      context.read<ReviewProvider>().loadInitialReviewList(widget.model.id);
    }else{
      showSnackBarMessage(context, _deleteReviewProvider.errorMessage!);
    }
  }
}