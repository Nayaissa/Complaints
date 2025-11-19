import 'dart:io';

import 'package:complaint/controller/home/sendcomplaint_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintFormPage extends StatelessWidget {
  final String categoryName;
  

  ComplaintFormPage({required this.categoryName});

  final List<String> departments = [
    "شركة الكهرباء",
    "مؤسسة المياه",
    "البلدية",
    "وزارة الاتصالات",
    "جهة أخرى",
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(ComplaintFormControllerImp());
    return GetBuilder<ComplaintFormControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              "إضافة شكوى — $categoryName",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF0C3C78),
          ),

          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                Text(
                  "اختر الجهة",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButton<String>(
                    hint: Text("اختر الجهة المسؤولة"),
                    value: controller.selectedDepartment,
                    isExpanded: true,
                    underline: SizedBox(),
                    items:
                        departments.map((d) {
                          return DropdownMenuItem(value: d, child: Text(d));
                        }).toList(),
                    onChanged: (value) {
                      controller.selectedDepartment = value;
                      controller.update();
                    },
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "الموقع",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),
                TextFormField(
                controller: controller.address ,
                  decoration: InputDecoration(
                    hintText: "اكتب الموقع بالتفصيل...",
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "وصف المشكلة",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 8),
                TextFormField(
                  maxLines: 5,
                controller: controller.description ,
                  decoration: InputDecoration(
                    hintText: "اكتب وصف الشكوى...",
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "إرفاق الصور",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: controller.pickImages,
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(color: const Color(0xFF0C3C78)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children:
                      controller.images.map((img) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(img.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                ),

                SizedBox(height: 20),
                Text(
                  "إرفاق الوثائق (PDF أو صور)",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10),
                GestureDetector(
                  onTap: controller.pickDocuments,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.attach_file,
                        size: 35,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Column(
                  children:
                      controller.documents.map((file) {
                        return ListTile(
                          leading: Icon(Icons.file_present),
                          title: Text(file.name),
                        );
                      }).toList(),
                ),

                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: controller.submitComplaint,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0C3C78),
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "إرسال الشكوى",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
