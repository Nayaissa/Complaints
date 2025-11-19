import 'package:complaint/controller/home/Home_controller.dart';
import 'package:complaint/controller/home/sendcomplaint_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/view/screen/home/complaintform_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  final List<String> sliderImages = [
    "https://i.imgur.com/DaS3S8K.jpg",
    "https://i.imgur.com/j2ncq8I.jpg",
    "https://i.imgur.com/z8GJr8J.jpg",
  ];

  final List<Map<String, dynamic>> categories = [
    {"name": "كهرباء", "icon": Icons.electric_bolt, "color": Colors.yellow},
    {"name": "مياه", "icon": Icons.water_drop, "color": Colors.blue},
    {"name": "طرق", "icon": Icons.stacked_bar_chart, "color": Colors.orange},
    {"name": "نظافة", "icon": Icons.cleaning_services, "color": Colors.green},
    {"name": "اتصالات", "icon": Icons.network_check, "color": Colors.purple},
    {"name": "إنارة", "icon": Icons.light_mode, "color": Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());
    return GetBuilder<HomePageControllerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,

          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(controller.profileImage),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("مرحباً 👋", style: TextStyle(fontSize: 12)),
                    Text(
                      controller.userName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.search, color: Colors.black),
              ],
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 15),

                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    height: 180,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                  ),
                  items:
                      sliderImages.map((img) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(img, fit: BoxFit.cover),
                        );
                      }).toList(),
                ),

                SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "التصنيفات",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0C3C78),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child:
                      controller.statusRequest == StatusRequest.loading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: const Color.fromARGB(255, 74, 65, 205),
                            ),
                          )
                          : GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.categoriesModel?.data?.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                ),
                            itemBuilder: (context, index) {
                              final item =
                                  controller.categoriesModel?.data?[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ComplaintFormPage(
                                      categoryName: item?.name ?? '',
                                    ),
                                    binding: BindingsBuilder(() {
                                      Get.put(
                                        ComplaintFormControllerImp(
                                          id: item?.id.toString(),
                                        ),
                                      );
                                    }),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.black12,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        categories[index]["icon"],
                                        size: 35,
                                        color: categories[index]["color"],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        item?.name ?? '',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                ),

                SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
    );
  }
}
