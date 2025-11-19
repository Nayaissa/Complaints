import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/core/constant/routes.dart';
import 'package:complaint/data/model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

abstract class SignUpController extends GetxController {
  signUp();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  RegisterModel? registerModel;

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController userName;
  late TextEditingController passwordconfirmation;

  StatusRequest? statusRequest;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    userName = TextEditingController();
    passwordconfirmation = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    passwordconfirmation.dispose();
    userName.dispose();
    super.dispose();
  }

  @override
  signUp() async {
    var formdata = formstate.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        dio.FormData formData = dio.FormData.fromMap({
          "name": userName.text.trim(),
          "email": email.text.trim(),
          "password": password.text.trim(),
          "password_confirmation": passwordconfirmation.text.trim(),
        });

        final response = await DioHelper.dioClient!.post(
          'register',
          data: formData,
          options: dio.Options(
            headers: {"Accept": "application/json"},
            validateStatus: (status) => true,
          ),
        );

        print(" Status: ${response.statusCode}");
        print("Data: ${response.data}");

        registerModel = RegisterModel.fromJson(response.data);

        if (response.statusCode == 200 || response.statusCode == 201) {
          statusRequest = StatusRequest.success;

          Get.snackbar('Congratulations', registerModel?.message ?? '');

          final userId = registerModel?.data?.id;

          if (userId == null) {
            Get.snackbar("Error", "Server did not return a valid user ID!");
            update();
            return;
          }

          Get.offNamed(
            AppRoute.verfiyCodeSignUp,
            arguments: {'id': userId.toString()},
          );
        } else {
          statusRequest = StatusRequest.failure;
          Get.snackbar('Warning', registerModel?.message ?? "Unknown error");
        }
      } catch (e) {
        print("Error during signup: $e");
        statusRequest = StatusRequest.serverfailure;
      }

      update();
    }
  }
}
