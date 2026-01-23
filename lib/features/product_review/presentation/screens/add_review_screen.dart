import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/product_review/data/models/review_model.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/add_review_provider.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/review_provider.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/update_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/presentation/widget/snack_bar_message.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.productId, this.reviewModel});

  static const String name = '/add-review';

  final String productId;
  final ReviewModel? reviewModel;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final UpdateReviewProvider _updateReviewProvider = UpdateReviewProvider();

  final TextEditingController _reviewTEController = TextEditingController();
  final TextEditingController _ratingTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.reviewModel != null){
      _reviewTEController.text = widget.reviewModel!.review;
      _ratingTEController.text = widget.reviewModel!.rating.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _addReviewProvider,),
        ChangeNotifierProvider(create: (context) => _updateReviewProvider,),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Create Review')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                SizedBox(
                  height: 200,
                  child: TextFormField(
                    controller: _reviewTEController,
                    decoration: InputDecoration(hintText: 'Write Review'),
                    maxLines: null,
                    minLines: 10,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _ratingTEController,
                  decoration: InputDecoration(hintText: 'Rating ~ 1-5'),
                  keyboardType: .number,
                ),
                SizedBox(height: 16),
                Consumer2<AddReviewProvider, UpdateReviewProvider>(
                  builder: (context, _, _, _) {
                    if (_addReviewProvider.addReviewInProgress || _updateReviewProvider.updateReviewInProgress) {
                      return CenterCircularProgress();
                    }
                    return FilledButton(onPressed: _onTapSubmitButton, child: Text((widget.reviewModel != null) ? "Update" : 'Submit'));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSubmitButton() async {

    if(widget.reviewModel != null){

      bool isSuccess = await _updateReviewProvider.updateReview(
        reviewId: widget.reviewModel!.id,
        newReview: _reviewTEController.text.trim(),
        rating: _ratingTEController.text.trim(),
      );

      if(isSuccess){
        showSnackBarMessage(context, 'update Review Success!');
        context.read<ReviewProvider>().loadInitialReviewList(widget.productId);
        Navigator.pop(context);
      }else{
        showSnackBarMessage(context, _addReviewProvider.errorMessage!);
      }


    }else{
      bool isSuccess = await _addReviewProvider.addReview(
        productId: widget.productId,
        review: _reviewTEController.text.trim(),
        rating: _ratingTEController.text.trim(),
      );

      if(isSuccess){
        showSnackBarMessage(context, 'Add Review Success!');
        context.read<ReviewProvider>().loadInitialReviewList(widget.productId);
        Navigator.pop(context);
      }else{
        showSnackBarMessage(context, _addReviewProvider.errorMessage!);
      }
    }

  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    _ratingTEController.dispose();
    super.dispose();
  }
}
