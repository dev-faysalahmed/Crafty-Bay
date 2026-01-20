import 'package:crafty_bay/features/cart/data/models/cart_model.dart';
import 'package:crafty_bay/features/cart/presentation/providers/cart_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/app_color.dart';
import '../../../app/assets_paths.dart';
import '../../../app/constants.dart';
import 'inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.model});

  final CartModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    var payableAmount = model.currentPrice * model.selectedQuantity;

    return Card(
      elevation: 3,
      shadowColor: AppColor.themeColor.withAlpha(50),
      color: Colors.white,
      child: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Image.network(model.photoUrl, height: 90, width: 70,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              model.title,
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: textTheme.bodyLarge,
                            ),
                            Text(
                              'Color: ${model.color ?? '_'}  Size: ${model.size ?? '_'}',
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text(
                        '${Constants.takaSign}$payableAmount',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: .w600,
                          color: AppColor.themeColor,
                        ),
                      ),
                      IncDecButton(onChange: (int value) {

                        context.read<CartListProvider>().updateCartItem(cartId: model.id, quantity: value);

                      }, quantity: model.selectedQuantity, maxValue: model.availableQuantity,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
