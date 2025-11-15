import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;

  String userName = "أحمد علي";
  String profileImage =
      "https://i.pravatar.cc/300"; 

  void changeTab(int index) {
    currentIndex = index;
    update();
  }
}
