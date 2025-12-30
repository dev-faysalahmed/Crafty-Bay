import 'package:flutter/material.dart';

import '../../../app/app_color.dart';
import '../../../app/assets_paths.dart';
import '../../../app/constants.dart';
import 'inc_dec_button.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Card(
      elevation: 3,
      shadowColor: AppColor.themeColor.withAlpha(50),
      color: Colors.white,
      child: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset(AssetsPaths.dummyImage, height: 90, width: 70,),
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
                              'Nike KH3434 - New Arrival Shoe',
                              maxLines: 1,
                              overflow: .ellipsis,
                              style: textTheme.bodyLarge,
                            ),
                            Text(
                              'Color: Black  Size: XL',
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
                        '${Constants.takaSign}100',
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: .w600,
                          color: AppColor.themeColor,
                        ),
                      ),
                      IncDecButton(onChange: (int value) {}),
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
