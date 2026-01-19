
import 'package:flutter/widgets.dart';

class MainNavContainerProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Future<void> changeItem(int index) async {
    if(_selectedIndex == index) return;

    _selectedIndex = index;
    notifyListeners();
  }

  void changeToCategories(){
    changeItem(1);
  }
  void backToHome(){
    changeItem(0);
  }
}