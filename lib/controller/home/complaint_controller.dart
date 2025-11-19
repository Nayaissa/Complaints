import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/data/model/complaints_model.dart';
import 'package:get/get.dart';

abstract class ComplaintsController extends GetxController {
  getCop(String id);
}

class ComplaintsControllerImp extends ComplaintsController {
  GetComlaintsModel? getComlaintsModel;
  StatusRequest? statusRequest;

  final Map<String, String> statusIds = {
    "جديدة": "1",
    "قيد المعالجة": "2",
    "منجزة": "3",
    "مرفوضة": "4",
  };

  String selectedStatus = "جديدة";

  @override
  void onInit() {
    getCop(statusIds[selectedStatus]!);
    super.onInit();
  }

  void changeStatus(String status) {
    selectedStatus = status;
    final id = statusIds[status];
    if (id != null) {
      getCop(id);
    }
    update();
  }

  @override
  getCop(String id) {
    statusRequest = StatusRequest.loading;
    update();

    DioHelper.getDataa(url: 'complaints/status/$id')
        .then((value) {
      print('naya   ${value!.data}');
      if (value.statusCode == 200) {
        getComlaintsModel = GetComlaintsModel.fromJson(value.data);
        statusRequest = StatusRequest.success;
        update();
      }
    }).catchError((error) {
      print(error.toString());
      statusRequest = StatusRequest.serverfailure;
      update();
    });
  }
}


int? idComplaint;

// class MyComplaintsController extends GetxController {
//   String selectedStatus = "جديدة";

//   // List<ComplaintModel> complaints = [
//   //   ComplaintModel(
//   //     id: "C-1021",
//   //     category: "كهرباء",
//   //     description: "انقطاع التيار عن الحي منذ يومين",
//   //     date: "2025-11-10",
//   //     status: "جديدة",
//   //   ),
//   //   ComplaintModel(
//   //     id: "C-1022",
//   //     category: "مياه",
//   //     description: "انفجار أنبوب مياه رئيسي",
//   //     date: "2025-11-08",
//   //     status: "قيد المعالجة",
//   //   ),
//   //   ComplaintModel(
//   //     id: "C-1023",
//   //     category: "طرق",
//   //     description: "حفرة كبيرة وسط الطريق",
//   //     date: "2025-11-05",
//   //     status: "منجزة",
//   //   ),
//   //   ComplaintModel(
//   //     id: "C-1024",
//   //     category: "نظافة",
//   //     description: "تراكم نفايات في الشارع",
//   //     date: "2025-11-03",
//   //     status: "مرفوضة",
//   //   ),
//   // ];

//   // List<ComplaintModel> get filteredComplaints =>
//   //     complaints.where((c) => c.status == selectedStatus).toList();

//   void changeStatus(String status) {
//     selectedStatus = status;
//     update();
//   }
// }
