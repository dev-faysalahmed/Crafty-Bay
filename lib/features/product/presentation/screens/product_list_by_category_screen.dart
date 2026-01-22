
import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';
import '../../../common/presentation/providers/add_wish_list_provider.dart';
import '../../../common/presentation/widget/product_card.dart';
import '../../../common/presentation/widget/snack_bar_message.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.categoryModel});

  static final String name = '/product-list-by-category';
  final CategoryModel categoryModel;

  @override
  State<ProductListByCategoryScreen> createState() =>
      _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState
    extends State<ProductListByCategoryScreen> {

  final ProductListByCategoryProvider _productListByCategoryProvider = ProductListByCategoryProvider();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productListByCategoryProvider.loadInitialProductList(widget.categoryModel.id);
      _scrollController.addListener(_loadMoreData);
    },);
  }

  void _loadMoreData(){
    if(_productListByCategoryProvider.moreLoading){
      return;
    }

    if(_scrollController.position.extentBefore < 300){
      _productListByCategoryProvider.fetchProductList(widget.categoryModel.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryModel.title)),
      body: ChangeNotifierProvider(
        create: (context) => _productListByCategoryProvider,
        child: Consumer<ProductListByCategoryProvider>(
          builder: (context, _, _) {
            if(_productListByCategoryProvider.initialLoading){
              return CenterCircularProgress();
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: _productListByCategoryProvider.productList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 0
                ),
                itemBuilder: (context, index) {
                  final product = _productListByCategoryProvider.productList[index];
                  return FittedBox(child: ProductCard(product: product, onTapFavourite: ()=> _onTapAddWishList(productId: product.id), fromWishList: false));
                },
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
