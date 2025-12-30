import 'package:crafty_bay/app/app_color.dart';
import 'package:crafty_bay/app/assets_paths.dart';
import 'package:crafty_bay/app/constants.dart';
import 'package:crafty_bay/features/cart/widget/inc_dec_button.dart';
import 'package:crafty_bay/features/common/presentation/providers/main_nav_container_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/cart_item.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {

    final textTheme = TextTheme.of(context);

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
            Text('Carts'),
          ],
        )),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: .symmetric(horizontal: 8),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                  return CartItem();
                }),
              ),
            ),
            _buildTotalPriceAndCheckoutSection(textTheme),
          ],
        ),
      ),
    );
  }

  Container _buildTotalPriceAndCheckoutSection(TextTheme textTheme) {
    return Container(
          padding: .all(16),
          decoration: BoxDecoration(
            color: AppColor.themeColor.withAlpha(40),
            borderRadius: .only(
              topRight: .circular(16),
              topLeft: .circular(16),
            )
          ),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text('Total Price', style: textTheme.bodyLarge,),
                  Text('${Constants.takaSign}1500', style: textTheme.titleLarge?.copyWith(
                    fontWeight: .w600,
                    color: AppColor.themeColor
                  ),),
                ],
              ),
              SizedBox(
                  width: 120,
                  child: FilledButton(onPressed: (){}, child: Text('Checkout')))
            ],
          ),
        );
  }
}


