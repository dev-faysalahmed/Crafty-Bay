import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../../app/constants.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});
  
  static const String name = 'review-screen';
  final String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  final ReviewProvider _reviewProvider = ReviewProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _reviewProvider.loadInitialReviewList(widget.productId);
      _scrollController.addListener(_loadMoreData);
    },);
  }

  void _loadMoreData(){
    if(_reviewProvider.moreLoading){
      return;
    }

    if(_scrollController.position.extentAfter < 300){
      _reviewProvider.fetchReviewList(widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      create: (context) => _reviewProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reviews'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ReviewProvider>(
                builder: (context, _, _) {
                  if(_reviewProvider.initialLoading){
                    return CenterCircularProgress();
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _reviewProvider.reviewList.length,
                            itemBuilder: (context, index) {
                            return ReviewCard(model: _reviewProvider.reviewList[index], index: index,);
                          },),
                        ),
                      ),

                      if(_reviewProvider.moreLoading)
                        CenterCircularProgress()
                    ],
                  );
                }
              ),
            ),

            _buildTotalReviewSection(),

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          backgroundColor: AppColor.themeColor,
          child: Icon(Icons.add, color: Colors.white, ),
        ),
      ),
    );
  }


  Widget _buildTotalReviewSection(){
    return
    Container(
      padding: .symmetric(horizontal: 16, vertical: 22),
      decoration: BoxDecoration(
          color: AppColor.themeColor.withAlpha(40),
          borderRadius: .only(
            topRight: .circular(16),
            topLeft: .circular(16),
          )
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Consumer<ReviewProvider>(
                builder: (context, _, _) {
                  return Text('Reviews (${_reviewProvider.totalReviewCount})', style: TextTheme.of(context).bodyLarge?.copyWith(fontWeight: .bold));
                }
              ),

            ],
          ),
        ],
      ),
    );
  }
}


