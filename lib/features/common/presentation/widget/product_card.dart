import 'package:flutter/material.dart';

import '../../../../app/app_color.dart';
import '../../../../app/assets_paths.dart';
import '../../../../app/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 3,
        shadowColor: AppColor.themeColor.withAlpha(50),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: .circular(8)
        ),
        child: Column(
          children: [
            Container(
              width: 150,
              height: 90,
              decoration: BoxDecoration(
                  color: AppColor.themeColor.withAlpha(30),
                  borderRadius: .only(
                      topRight: .circular(8),
                      topLeft: .circular(8)
                  ),
                  image: DecorationImage(image: AssetImage(AssetsPaths.dummyImage))
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text('Nike Shoe RG4343 - New Arrival', maxLines: 1, overflow: .ellipsis,),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Text('${Constants.takaSign}2342', style: TextStyle(fontWeight: .w600, color: AppColor.themeColor),),
                      Wrap(
                        crossAxisAlignment: .center,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 20,),
                          Text('4.3'),
                        ],),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: .circular(4)
                        ),
                        color: AppColor.themeColor,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(Icons.favorite_border_outlined, color: Colors.white, size: 18,),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}