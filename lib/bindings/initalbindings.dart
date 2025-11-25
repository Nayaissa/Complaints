import 'package:complaint/controller/notification_controller.dart';
import 'package:complaint/core/class/diohelper.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioHelper());
    Get.put(NotificationController());

  }
}
