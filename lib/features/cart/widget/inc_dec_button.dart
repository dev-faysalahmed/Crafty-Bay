import 'package:crafty_bay/app/app_color.dart';
import 'package:flutter/material.dart';

class IncDecButton extends StatefulWidget {
  const IncDecButton({super.key, required this.onChange, this.maxValue = 100, required this.quantity});

  final Function(int) onChange;
  final int maxValue;
  final int quantity;

  @override
  State<IncDecButton> createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: .spaceBetween,
      children: [

        _buildGestureDetector(onTap: () {
          if(currentValue > 1){
            currentValue--;
            widget.onChange(currentValue);
            setState(() {});
          }
        }, icon: Icons.remove),

        Text('$currentValue', style: TextTheme.of(context).titleMedium,),

        _buildGestureDetector(onTap: () {
          if(widget.maxValue > currentValue) {
            currentValue++;
            widget.onChange(currentValue);
            setState(() {});
          }
        }, icon: Icons.add),
      ],
    );
  }

  Widget _buildGestureDetector({required VoidCallback onTap, required IconData icon}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: .all(4),
          decoration: BoxDecoration(
            color: AppColor.themeColor,
            borderRadius: .circular(4),
          ),
          child: Icon(icon, size: 20, color: Colors.white,),
        ),
      );
  }
}
