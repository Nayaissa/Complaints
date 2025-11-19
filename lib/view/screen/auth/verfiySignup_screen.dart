import 'package:complaint/controller/auth/verfiysignup_controller.dart';
import 'package:complaint/core/class/statusrequest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args == null || args['id'] == null) {
      // Get.snackbar('Error', 'معرف المستخدم غير موجود');
      Future.delayed(Duration(seconds: 1), () => Get.back());
      return const SizedBox();
    }

    VerfiySignUpImp controller = Get.put(VerfiySignUpImp(), permanent: true);
    controller.id = args['id'];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F7FF),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C3C78),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.mark_email_read_outlined,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  "تأكيد البريد الإلكتروني",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0C3C78),
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  "لقد أرسلنا رمز التحقق إلى بريدك الإلكتروني.\nيرجى إدخال الرمز للمتابعة.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: controller.otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 32),

                GetBuilder<VerfiySignUpImp>(
                  builder: (_) {
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
                          controller.verfiySignUp();
                        },
                        child:
                            controller.statusRequest == StatusRequest.loading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : const Text(
                                  "تأكيد الرمز",
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

                GestureDetector(
                  onTap: () {
                   controller. reSendCode();
                  },
                  child: const Text(
                    "إعادة إرسال الرمز",
                    style: TextStyle(
                      color: Color(0xFF0C3C78),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    "العودة",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
