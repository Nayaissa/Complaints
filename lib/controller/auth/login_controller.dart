import 'package:complaint/core/constant/routes.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  goTosignUp();
  login();
}

class LoginControllerImp extends LoginController {
  @override
  goTosignUp() {
    Get.toNamed(AppRoute.signUp);
  }

  @override
  login() {
   
  }
}
