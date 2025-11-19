import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/class/statusrequest.dart';

abstract class ComplaintFormController extends GetxController {
  submitComplaint();
}

class ComplaintFormControllerImp extends ComplaintFormController {
  String? id;

  ComplaintFormControllerImp({this.id}); 
  String? selectedDepartment;
  late TextEditingController address;
  late TextEditingController description;

  List<XFile> images = [];
  List<XFile> documents = [];

  StatusRequest? statusRequest;

  final picker = ImagePicker();

  void pickImages() async {
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      images.addAll(picked);
      update();
    }
  }

  void pickDocuments() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      documents.add(file);
      update();
    }
  }

  @override
  void onInit() {
    address = TextEditingController();
    description = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    address.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  @override
submitComplaint() async {
  if (selectedDepartment == null || address.text.isEmpty || description.text.isEmpty) {
    Get.snackbar('Warning', 'يرجى تعبئة جميع الحقول المطلوبة');
    return;
  }

  statusRequest = StatusRequest.loading;
  update();

  try {
   
    dio.FormData formData = dio.FormData.fromMap({
      'type': selectedDepartment!,
      'address': address.text.trim(),
      'description': description.text.trim(),
      'agency_id': id
    });

    for (var img in images) {
      formData.files.add(
        MapEntry(
          'file',
          await dio.MultipartFile.fromFile(img.path, filename: img.name),
        ),
      );
    }

    for (var doc in documents) {
      formData.files.add(
        MapEntry(
          'documents[]',
          await dio.MultipartFile.fromFile(doc.path, filename: doc.name),
        ),
      );
    }

    final response = await DioHelper.dioClient!.post(
      'complaints/store', 
      data: formData,
      options: dio.Options(
        headers: {"Accept": "application/json"},
        validateStatus: (status) => true,
      ),
    );

    print("Status: ${response.statusCode}");
    print("Data: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      statusRequest = StatusRequest.success;
      Get.snackbar('Success', 'تم إرسال الشكوى بنجاح');
      selectedDepartment = null;
      address.clear();
      description.clear();
      images.clear();
      documents.clear();
      update();
    } else {
      statusRequest = StatusRequest.failure;
      Get.snackbar('Warning', response.data['message'] ?? 'حدث خطأ ما');
      update();
    }
  } catch (e) {
    print("Error submitting complaint: $e");
    statusRequest = StatusRequest.serverfailure;
    update();
  }
}

}
