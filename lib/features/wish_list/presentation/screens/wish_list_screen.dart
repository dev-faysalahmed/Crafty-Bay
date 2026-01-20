import 'package:crafty_bay/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_model.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/get_wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/presentation/widget/product_card.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<GetWishListProvider>().getWishList();
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
        body: Consumer<GetWishListProvider>(
          builder: (context, provider, _) {

            if(provider.getWishListInProgress){
              return CenterCircularProgress();
            }

            return GridView.builder(
              itemCount: provider.wishList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 0
              ),
              itemBuilder: (context, index) {
                WishListModel model = provider.wishList[index];
                return FittedBox(child: ProductCard(product: model.productModel));
              },
            );
          }
        ),
      ),
    );
  }
}
