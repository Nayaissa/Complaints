import 'package:complaint/controller/home/Home_controller.dart';
import 'package:complaint/view/screen/home/complaints_page.dart';
import 'package:complaint/view/screen/home/home_screen.dart';
import 'package:complaint/view/screen/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageControllerImp>(
      init: HomePageControllerImp(),
      builder: (controller) {
        return Directionality(
  textDirection: TextDirection.rtl,
          child: Scaffold(
            body: IndexedStack(
              index: controller.currentIndex,
              children: [
                HomePage(),
                ComplaintsPage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              selectedItemColor: const Color(0xFF0C3C78),
              unselectedItemColor: Colors.grey,
              onTap: controller.changeTab,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "الصفحة الرئيسية",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.report),
                  label: "الشكاوى",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "الملف الشخصي",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
