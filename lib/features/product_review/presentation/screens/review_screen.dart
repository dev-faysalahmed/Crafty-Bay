import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/review_provider.dart';
import 'package:crafty_bay/features/product_review/presentation/screens/add_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../../app/constants.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});
  
  static const String name = '/review-screen';
  final String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {


  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReviewProvider>().loadInitialReviewList(widget.productId);
      _scrollController.addListener(_loadMoreData);
    },);
  }

  void _loadMoreData(){
    if(context.read<ReviewProvider>().moreLoading){
      return;
    }

    if(_scrollController.position.extentAfter < 300){
      context.read<ReviewProvider>().fetchReviewList(widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ReviewProvider>(
              builder: (context, provider, _) {
                if(provider.initialLoading){
                  return CenterCircularProgress();
                }

                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: provider.reviewList.length,
                          itemBuilder: (context, index) {
                          return ReviewCard(model: provider.reviewList[index]);
                        },),
                      ),
                    ),

                    if(provider.moreLoading)
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
        onPressed: (){
          _onTapCreateReviewButton();
        },
        shape: CircleBorder(),
        backgroundColor: AppColor.themeColor,
        child: Icon(Icons.add, color: Colors.white, ),
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
                  return Text('Reviews (${context.read<ReviewProvider>().totalReviewCount})', style: TextTheme.of(context).bodyLarge?.copyWith(fontWeight: .bold));
                }
              ),

            ],
          ),
        ],
      ),
    );
  }

  void _onTapCreateReviewButton()async{
    if(await AuthController.isAlreadyLoggedIn()){
      Navigator.pushNamed(context, AddReviewScreen.name, arguments: widget.productId);
    }else{
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
}


