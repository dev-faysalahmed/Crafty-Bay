import 'package:flutter/material.dart';

import '../../../../app/app_color.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 0,
            color: AppColor.themeColor.withAlpha(30),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(Icons.computer, size: 28, color: AppColor.themeColor,),
            )
        ),
        Text('Computer', style: TextStyle(
            color: AppColor.themeColor,
            fontWeight: .w500,
            letterSpacing: .6
        ),)
      ],
    );
  }
}