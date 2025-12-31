import 'package:flutter/material.dart';

void showSnackBarMessage(BuildContext context, String sms){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(sms)));
}