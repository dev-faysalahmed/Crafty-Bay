import 'package:crafty_bay/features/common/presentation/providers/add_wish_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_list_by_category_provider.dart';
import 'package:crafty_bay/features/wish_list/data/models/wish_list_model.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key, required this.productId, required this.onTapFavoriteIcon,
  });

  final String productId;
  final VoidCallback onTapFavoriteIcon;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {

  @override
  Widget build(BuildContext context) {





    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: .circular(4)
      ),
      color: AppColor.themeColor,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: GestureDetector(
            onTap: widget.onTapFavoriteIcon,
            child: Consumer<AddWishListProvider>(
              builder: (context, provider, _) {
                if(provider.addWishListInProgress){
                  if(provider.selectedId == widget.productId){
                    return SizedBox(
                        width: 18,
                        height: 18,
                        child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),));
                  }

                }
                return Consumer<WishListProvider>(
                  builder: (context, provider, _) {
                    if(provider.wishListItemDeleteInProgress){
                      if(provider.deleteProductId == widget.productId){
                        return SizedBox(
                            width: 18,
                            height: 18,
                            child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),));
                      }
                    }
                    return Icon(Icons.favorite_border_outlined, color: Colors.white, size: 18,);
                  }
                );
              }
            )),
      ),
    );
  }


}