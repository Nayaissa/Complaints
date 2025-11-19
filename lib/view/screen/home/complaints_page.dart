import 'package:complaint/controller/home/complaint_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/data/model/complaints_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsControllerImp>(
      init: ComplaintsControllerImp(),
      builder: (controller) {
        return Directionality(
  textDirection: TextDirection.rtl,child:  Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              title: Text(
                "متابعة الشكاوى",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF0C3C78),
            ),
          
            body: Column(
              children: [
                SizedBox(height: 15),
                _buildStatusFilter(controller),
          
                SizedBox(height: 15),
          
                Expanded(
                  child:controller.statusRequest== StatusRequest.loading ? Center(child: CircularProgressIndicator(color:const Color(0xFF0C3C78) ,)): ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.getComlaintsModel?.data?.length,
                    itemBuilder: (context, index) {
                      var c = controller.getComlaintsModel!.data![index];
                      return _buildComplaintCard(c);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
Widget _buildStatusFilter(ComplaintsControllerImp controller) {
  final statuses = ["جديدة", "قيد المعالجة", "منجزة", "مرفوضة"];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: statuses.map((status) {
        final bool isSelected = controller.selectedStatus == status;

        return GestureDetector(
          onTap: () => controller.changeStatus(status), // فقط نمرر الحالة
          child: Container(
            margin: EdgeInsets.only(right: 12),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF0C3C78) : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}


  Widget _buildComplaintCard(Data c) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.blue.shade50,
            child: Icon(Icons.report_problem, color: Colors.blue),
          ),

          SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.type!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 3),

                Text(
                  c.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54),
                ),

                SizedBox(height: 8),

                Text(
                  "رقم الشكوى: ${c.id}",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),

                Text(
                  "التاريخ: ${c.updatedAt}",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

         // _buildStatusTag(c.status),
        ],
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color color;

    switch (status) {
      case "جديدة":
        color = Colors.blue;
        break;
      case "قيد المعالجة":
        color = Colors.orange;
        break;
      case "منجزة":
        color = Colors.green;
        break;
      case "مرفوضة":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
