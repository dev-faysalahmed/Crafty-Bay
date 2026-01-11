import 'package:crafty_bay/features/cart/widget/inc_dec_button.dart';
import 'package:crafty_bay/features/common/presentation/widget/favourite_button.dart';
import 'package:crafty_bay/features/common/presentation/widget/rating_view.dart';
import 'package:crafty_bay/features/product/presentation/providers/product_details_provider.dart';
import 'package:crafty_bay/features/product/widgets/color_picker.dart';
import 'package:crafty_bay/features/product/widgets/product_image_slider.dart';
import 'package:crafty_bay/features/product/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_color.dart';
import '../../../../app/constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final ProductDetailsProvider _productDetailsProvider = ProductDetailsProvider();

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return ChangeNotifierProvider(
      create: (context) => _productDetailsProvider,
      child: Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: Column(children: [
                ProductImageSlider(),
                Padding(
                  padding: .symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        crossAxisAlignment: .start,
                        children: [
                          Expanded(child: Text('Nike Shoe NK3434 - All New Edition 2026', style: textTheme.titleMedium,)),
                          IncDecButton(onChange: (int value) {  },),
                        ],
                      ),
                      Row(
                        children: [
                          RatingView(),
                          TextButton(onPressed: (){}, child: Text('Reviews')),
                          FavouriteButton(),
                        ],
                      ),
                      Text('Color', style: textTheme.titleMedium,),
                      SizedBox(height: 8,),
                      ColorPicker(colors: ['Black', 'Blue', 'White', 'Red'], onChange: (selectedColor) {  },),
                      SizedBox(height: 16,),
                      Text('Size', style: textTheme.titleMedium,),
                      SizedBox(height: 8,),
                      SizePicker(sizes: ['M', 'L', 'XL', 'XXL'], onChange: (selectedSize) {  },),
                      SizedBox(height: 16,),
                      Text('Description', style: textTheme.titleMedium,),
                      Text('''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.''',
                      style: TextStyle(
                        color: Colors.grey
                      ),)
                    ],
                  ),
                )
              ])),
            ),
            _buildPriceAndAddToCartSection(textTheme),
          ],
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
                '${Constants.takaSign}500',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: .w600,
                  color: AppColor.themeColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {}, child: Text('Add to Cart')),
          ),
        ],
      ),
    );
  }
}
