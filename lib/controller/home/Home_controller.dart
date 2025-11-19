import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/data/model/category_model.dart';
import 'package:get/get.dart';

abstract class HomePageController extends GetxController {
  getCat();
}

class HomePageControllerImp extends HomePageController {
  int currentIndex = 0;
  StatusRequest? statusRequest;
  CategoriesModel? categoriesModel;
  String userName = "أحمد علي";
  int? id;
  String profileImage = "https://i.pravatar.cc/300";

  void changeTab(int index) {
    currentIndex = index;
    update();
  }

  @override
  void onInit() {
    userName = Get.arguments['name'];
    id = Get.arguments['id'];
    getCat();
    super.onInit();
  }

  @override
  getCat() {
    statusRequest = StatusRequest.loading;
    update();

    DioHelper.getDataa(url: 'agencies')
        .then((value) {
          print('naya   ${value!.data}');
          if (value.statusCode == 200) {
            categoriesModel = CategoriesModel.fromJson(value.data);
            statusRequest = StatusRequest.success;

            // if (mostPuplarServicesModel!.popularServices!.isEmpty ||
            //     mostPuplarServicesModel!.popularServices!.isEmpty) {
            //   servicepupstate = StatusRequest.noData;
            update();
            // }
          }
        })
        .catchError((error) {
          print(error.toString());
          statusRequest = StatusRequest.serverfailure;
          update();
        });
  }
}
