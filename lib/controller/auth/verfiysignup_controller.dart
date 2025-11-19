import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/core/constant/routes.dart';
import 'package:complaint/data/model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class VerfiySignUp extends GetxController {
  verfiySignUp();
  reSendCode();
}

class VerfiySignUpImp extends VerfiySignUp {
  String? id;
  late List<TextEditingController> otpControllers;
  StatusRequest? statusRequest;
  StatusRequest? restatusRequest;

  RegisterModel? registerModel;

  @override
  void onInit() {
    id = Get.arguments['id'];
    otpControllers = List.generate(6, (index) => TextEditingController());
    super.onInit();
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  verfiySignUp() {
    String otpCode = otpControllers.map((c) => c.text.trim()).join();

    if (otpCode.length < 6) {
      Get.snackbar('Warning', 'يرجى إدخال جميع أرقام الرمز');
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    DioHelper.postsData(
          url: 'verify-otp',
          data: {'user_id': id, 'code': otpCode},
        )
        .then((value) {
          print(value!.data);
          if (value.statusCode == 200) {
            registerModel = RegisterModel.fromJson(value.data);
            Get.snackbar('Congratulations', registerModel!.message!);
            Get.offNamed(AppRoute.successSignUp);
            statusRequest = StatusRequest.success;
          } else {
            registerModel = RegisterModel.fromJson(value.data);
            Get.snackbar('Warning', registerModel!.message!);
            statusRequest = StatusRequest.failure;
          }
          update();
        })
        .catchError((error) {
          print(error.toString());
          statusRequest = StatusRequest.serverfailure;
          update();
        });

    update();
  }

  @override
  reSendCode() {
    restatusRequest = StatusRequest.loading;
     update();

    DioHelper.postsData(
          url: 'resend-otp',
          data: {'user_id': id},
        )
        .then((value) {
          print(value!.data);
          if (value.statusCode == 200) {
            registerModel = RegisterModel.fromJson(value.data);
            Get.snackbar('Congratulations', registerModel!.message!);
            Get.offNamed(AppRoute.successSignUp);
            statusRequest = StatusRequest.success;
          } else {
            registerModel = RegisterModel.fromJson(value.data);
            Get.snackbar('Warning', registerModel!.message!);
            statusRequest = StatusRequest.failure;
          }
          update();
        })
        .catchError((error) {
          print(error.toString());
          statusRequest = StatusRequest.serverfailure;
          update();
        });

    update();
  }
}
