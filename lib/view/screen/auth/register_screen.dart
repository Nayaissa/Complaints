import 'package:complaint/controller/auth/signup_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:complaint/core/constant/routes.dart';
import 'package:complaint/view/widget/auth/customformfiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpControllerImp controller = Get.put(SignUpControllerImp());

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
                  // logo
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0C3C78),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.handshake_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "إنشاء حساب جديد",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C3C78),
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    "قم بملء المعلومات التالية لإنشاء حساب",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),

                  // full name
                  CustomFormFiled(
                    label: "الاسم الكامل",
                    controller: controller.userName,
                    icon: Icons.person_2_outlined,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return "الرجاء إدخال الاسم";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

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
                  GetBuilder<SignUpControllerImp>(
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

                  const SizedBox(height: 16),

                  // confirm password
                  CustomFormFiled(
                    label: "تأكيد كلمة المرور",
                    controller: controller.passwordconfirmation,
                    icon: Icons.lock_outline,
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return "الرجاء تأكيد كلمة المرور";
                      if (val != controller.password.text)
                        return "كلمة المرور غير متطابقة";
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // submit button
                  GetBuilder<SignUpControllerImp>(
                    builder: (controller) {
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
                          onPressed: () {
                            controller.signUp();
                          },
                          child:
                              controller.statusRequest == StatusRequest.loading
                                  ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : const Text(
                                    "إنشاء الحساب",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("هل لديك حساب بالفعل؟ "),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(AppRoute.login);
                        },
                        child: const Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            color: Color(0xFF0C3C78),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
