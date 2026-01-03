import 'package:crafty_bay/features/category/data/models/category_model.dart';
import 'package:crafty_bay/features/product/presentation/screens/product_list_by_category_screen.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_color.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoryModel});

  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductListByCategoryScreen.name, arguments: categoryModel);
      },
      child: Column(
        children: [
          Card(
            elevation: 0,
            color: AppColor.themeColor.withAlpha(30),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.network(
                categoryModel.icon,
                width: 28,
                height: 28,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 28, color: Colors.grey,);
                },
              ),
            ),
          ),
          Text(
            categoryModel.title,
            maxLines: 1,
            textAlign: .center,
            overflow: .ellipsis,
            style: TextStyle(
              color: AppColor.themeColor,
              fontWeight: .w500,
              letterSpacing: .6,
            ),
          ),
        ],
      ),
    );
  }
}
