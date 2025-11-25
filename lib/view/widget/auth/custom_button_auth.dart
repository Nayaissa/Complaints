import 'package:complaint/controller/auth/login_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class CustomButtonAuth extends GetView<LoginControllerImp> {
  const CustomButtonAuth( {super.key, this.onPressed,required this.label});
  final void Function()? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0C3C78),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child:
            controller.statusRequest == StatusRequest.loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                 label,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
      ),
    );
    ;
  }
}
