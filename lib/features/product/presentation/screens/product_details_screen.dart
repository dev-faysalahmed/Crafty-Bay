import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:crafty_bay/features/cart/widget/inc_dec_button.dart';
import 'package:crafty_bay/features/common/presentation/providers/add_to_cart_provider.dart';
import 'package:crafty_bay/features/common/presentation/providers/add_wish_list_provider.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/favourite_button.dart';
import 'package:crafty_bay/features/common/presentation/widget/rating_view.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_details_provider.dart';
import 'package:crafty_bay/features/product/widgets/color_picker.dart';
import 'package:crafty_bay/features/product/widgets/product_image_slider.dart';
import 'package:crafty_bay/features/product/widgets/size_picker.dart';
import 'package:crafty_bay/features/product_review/presentation/screens/review_screen.dart';
import 'package:crafty_bay/features/wish_list/presentation/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../../app/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId, required this.fromWishList, this.wishListId});

  static const String name = '/product-details';

  final String productId;
  final bool fromWishList;
  final String? wishListId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsProvider _productDetailsProvider =
      ProductDetailsProvider();

  int quantity = 1;

  final AddToCartProvider _addToCartProvider = AddToCartProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _productDetailsProvider.getProductDetails(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _productDetailsProvider,),
          ChangeNotifierProvider(create: (context) => _addToCartProvider,),
        ],
        child: Consumer<ProductDetailsProvider>(
          builder: (context, _, _) {
            if (_productDetailsProvider.getProductDetailsInProgress) {
              return CenterCircularProgress();
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      children: [
                        ProductImageSlider(
                          imagesUrls:
                              _productDetailsProvider
                                  .productDetailsModel
                                  ?.photos ??
                              [],
                        ),
                        Padding(
                          padding: .symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                crossAxisAlignment: .start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _productDetailsProvider
                                              .productDetailsModel
                                              ?.title ??
                                          '',
                                      style: textTheme.titleMedium,
                                    ),
                                  ),
                                  IncDecButton(
                                    maxValue:
                                        _productDetailsProvider
                                            .productDetailsModel
                                            ?.quantity ??
                                        20,
                                    onChange: (newValue) {
                                      quantity = newValue;
                                    }, quantity: quantity,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  RatingView(),
                                  TextButton(
                                    onPressed: () {
                                      _onTapReviewButton();
                                    },
                                    child: Text('Reviews'),
                                  ),
                                  FavouriteButton(productId: widget.productId, onTapFavoriteIcon: _onTapAddWishList,),
                                ],
                              ),
                              if (_productDetailsProvider.productDetailsModel?.colors.isNotEmpty ?? false)
                                Text('Color', style: textTheme.titleMedium),
                              if (_productDetailsProvider.productDetailsModel?.colors.isNotEmpty ?? false)
                                const SizedBox(height: 8),
                              ColorPicker(
                                colors:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.colors ??
                                    [],
                                onChange: (selectedColor) {},
                              ),
                              if (_productDetailsProvider.productDetailsModel?.sizes.isNotEmpty ?? false)

                                const SizedBox(height: 16),
                              if (_productDetailsProvider
                                      .productDetailsModel
                                      ?.sizes
                                      .isNotEmpty ??
                                  false)
                                Text('Size', style: textTheme.titleMedium),
                              if (_productDetailsProvider.productDetailsModel?.sizes.isNotEmpty ?? false)
                                const SizedBox(height: 8),
                              SizePicker(
                                sizes:
                                    _productDetailsProvider
                                        .productDetailsModel
                                        ?.sizes ??
                                    [],
                                onChange: (selectedSize) {},
                              ),
                              const SizedBox(height: 16),
                              Text('Description', style: textTheme.titleMedium),
                              const SizedBox(height: 8),
                              Text(
                                _productDetailsProvider
                                        .productDetailsModel
                                        ?.description ??
                                    '',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildPriceAndAddToCartSection(textTheme),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(TextTheme textTheme) {
    return Container(
      padding: .all(16),
      decoration: BoxDecoration(
        color: AppColor.themeColor.withAlpha(40),
        borderRadius: .only(topRight: .circular(16), topLeft: .circular(16)),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              Text('Price', style: textTheme.bodyLarge),
              Text(
                '${Constants.takaSign}${_productDetailsProvider.productDetailsModel?.price ?? ''}',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: .w600,
                  color: AppColor.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: Consumer<AddToCartProvider>(
              builder: (context, _, _) {
                if(_addToCartProvider.addToCartInProgress){
                  return CenterCircularProgress();
                }
                return FilledButton(onPressed: _onTapAddToCartButton, child: Text('Add to Cart'));
              }
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onTapAddToCartButton() async {
      if(await AuthController.isAlreadyLoggedIn()){
        // TODO: call add to cart api
        final bool isSuccess = await _addToCartProvider.addToCart(widget.productId, quantity);
        if(isSuccess){
          showSnackBarMessage(context, 'Added to cart!');
        }else{
          showSnackBarMessage(context, _addToCartProvider.errorMessage!);
        }
      }else{
        Navigator.pushNamed(context, SignUpScreen.name);
      }

  }

  Future<void> _onTapAddWishList() async {

    if(widget.fromWishList){
      bool isSuccess = await context.read<WishListProvider>().deleteWishListItem(wishListId: widget.wishListId!, deleteProductId: widget.productId,);
      if(isSuccess){
        showSnackBarMessage(context, 'Delete from Wishlist!');
        context.read<WishListProvider>().loadInitialWishList();
        Navigator.pop(context);
      }
    }else{
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

  void _onTapReviewButton(){
    Navigator.pushNamed(context, ReviewScreen.name, arguments: widget.productId);
  }



}
