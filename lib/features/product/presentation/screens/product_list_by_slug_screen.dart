
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_slug_provider.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';
import '../../../common/presentation/providers/add_wish_list_provider.dart';
import '../../../common/presentation/widget/product_card.dart';
import '../../../common/presentation/widget/snack_bar_message.dart';

class ProductListBySlugScreen extends StatefulWidget {
  const ProductListBySlugScreen({super.key, required this.slug, required this.title});

  static final String name = '/product-list-by-slug';

  final String slug;
  final String title;


  @override
  State<ProductListBySlugScreen> createState() =>
      _ProductListBySlugScreenState();
}

class _ProductListBySlugScreenState
    extends State<ProductListBySlugScreen> {

  final ProductListBySlugProvider _productListBySlugProvider = ProductListBySlugProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productListBySlugProvider.loadInitialPopularList(widget.slug);
      _scrollController.addListener(_loadMoreData);
    },);
  }

  void _loadMoreData(){
    if(_productListBySlugProvider.moreLoading){
      return;
    }

    if(_scrollController.position.extentBefore < 300){
      _productListBySlugProvider.fetchPopularProductList(widget.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ChangeNotifierProvider(
        create: (context) => _productListBySlugProvider,
        child: Consumer<ProductListBySlugProvider>(
          builder: (context, _, _) {
            if(_productListBySlugProvider.initialLoading){
              return CenterCircularProgress();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemCount: _productListBySlugProvider.popularProductList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 0
                      ),
                      itemBuilder: (context, index) {
                        final product = _productListBySlugProvider.popularProductList[index];
                        return FittedBox(child: ProductCard(product: product, onTapFavourite: ()=> _onTapAddWishList(productId: product.id), fromWishList: false));
                      },
                    ),
                  ),
                  if(_productListBySlugProvider.moreLoading)
                    CenterCircularProgress()
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Future<void> _onTapAddWishList({required String productId}) async {
    if(await AuthController.isAlreadyLoggedIn()){
      final bool isSuccess = await context.read<AddWishListProvider>().addWishList(productId: productId);
      if(isSuccess){
        showSnackBarMessage(context, 'Added to wish list!');
      }else{
        showSnackBarMessage(context, context.read<AddWishListProvider>().errorMessage!);
      }
    }else{
      Navigator.pushNamed(context, SignUpScreen.name);
    }
  }
}
