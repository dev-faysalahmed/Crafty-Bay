import 'package:crafty_bay/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_model.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../common/presentation/widget/product_card.dart';
import '../../../common/presentation/widget/snack_bar_message.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<WishListProvider>().loadInitialWishList();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData(){
    if(context.read<WishListProvider>().moreLoading){
      return;
    }

    if(_scrollController.position.extentAfter < 300){
      context.read<WishListProvider>().fetchWishList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<MainNavContainerProvider>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(title: Row(
          children: [
            IconButton(onPressed: (){
              context.read<MainNavContainerProvider>().backToHome();
            }, icon: Icon(Icons.arrow_back_ios)),
            Text('Wish List'),
          ],
        )),
        body: Consumer<WishListProvider>(
          builder: (context, provider, _) {

            if(provider.initialLoading){
              return CenterCircularProgress();
            }

            return Column(
              children: [
                Expanded(
                  child: Consumer<WishListProvider>(
                    builder: (context, provider, _) {

                      if(provider.initialLoading){
                        return CenterCircularProgress();
                      }

                      return GridView.builder(
                        controller: _scrollController,
                        itemCount: provider.wishList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 0
                        ),
                        itemBuilder: (context, index) {
                          WishListModel model = provider.wishList[index];
                          return FittedBox(child: ProductCard(product: model.productModel, onTapFavourite: () => onTapFavouriteIcon(wishListId: model.id, deleteProductId: model.productModel.id), fromWishList: true, wishListId: model.id,));
                        },
                      );
                    }
                  ),
                ),
                if(context.read<WishListProvider>().moreLoading)
                  CenterCircularProgress(),
              ],
            );
          }
        ),
      ),
    );
  }

  Future<void> onTapFavouriteIcon({required String wishListId, required String deleteProductId}) async {
    bool isSuccess = await context.read<WishListProvider>().deleteWishListItem(wishListId: wishListId, deleteProductId: deleteProductId);

    if(isSuccess){
      showSnackBarMessage(context, 'Delete from Wishlist!');
      context.read<WishListProvider>().loadInitialWishList();
    }
  }
}
