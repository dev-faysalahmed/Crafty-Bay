import 'package:crafty_bay/features/common/presentation/providers/add_wish_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/screens/sign_up_screen.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key, required this.productId,
  });

  final String productId;

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
            onTap: onTap,
            child: Consumer<AddWishListProvider>(
              builder: (context, provider, _) {
                if(provider.addWishListInProgress){
                  return SizedBox(
                      width: 18,
                      height: 18,
                      child: Center(child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),));
                }
                return Icon(Icons.favorite_border_outlined, color: Colors.white, size: 18,);
              }
            )),
      ),
    );
  }

  Future<void> onTap() async {
    if(await AuthController.isAlreadyLoggedIn()){
    final bool isSuccess = await context.read<AddWishListProvider>().addWishList(productId: widget.productId);
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