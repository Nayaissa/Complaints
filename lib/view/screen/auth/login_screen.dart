import 'package:complaint/controller/auth/login_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/view/widget/auth/custom_appar_auth.dart';
import 'package:complaint/view/widget/auth/custom_button_auth.dart';
import 'package:complaint/view/widget/auth/customformfiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F7FF),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Form(
              key: controller.formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomApparAuth(),
                  const SizedBox(height: 24),
                  const Text(
                    "نظام الشكاوي الذكي",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C3C78),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "يرجى تسجيل الدخول للمتابعة",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),

                  // email
                  CustomFormFiled(
                    label: "البريد الإلكتروني",
                    controller: controller.email,
                    icon: Icons.email_outlined,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return "الرجاء إدخال البريد الإلكتروني";
                      if (!val.contains("@"))
                        return "البريد الإلكتروني غير صالح";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // password
                  GetBuilder<LoginControllerImp>(
                    builder: (_) {
                      return CustomFormFiled(
                        label: "كلمة المرور",
                        controller: controller.password,
                        icon: Icons.lock_outline,
                        //  obscureText: !controller.showPassword,
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return "الرجاء إدخال كلمة المرور";
                          if (val.length < 6)
                            return "يجب أن تكون كلمة المرور 6 أحرف على الأقل";
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  GetBuilder<LoginControllerImp>(
                    builder: (controller) {
                      return CustomButtonAuth(
                        onPressed: () {
                          controller.login();
                        },
                        label: "تسجيل الدخول",
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("أو"),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 8),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
