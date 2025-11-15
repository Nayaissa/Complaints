import 'package:complaint/core/constant/routes.dart';
import 'package:complaint/core/middleware/mymiddleware.dart';
import 'package:complaint/view/screen/auth/login_screen.dart';
import 'package:complaint/view/screen/auth/register_screen.dart';
import 'package:complaint/view/screen/auth/verfiySignup_screen.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>>? getPages = [
  // intro.....
  GetPage(name: '/', page: () => VerificationPage(), middlewares: [MyMiddleWare()]),
  // Auth
  GetPage(name: AppRoute.signUp, page: () => RegisterPage()),
  // // Auth
  // GetPage(name: AppRoute.login, page: () => LoginScreen()),
  // GetPage(name: AppRoute.signUp, page: () => SignupScreen()),
  // GetPage(name: AppRoute.forgetPassword, page: () => ForegetpassswordScreen()),
  // GetPage(name: AppRoute.verfiyCode, page: () => VerfiyCodeScreen()),

  // // GetPage(name: AppRoute.verfiyCodeSignUp, page: () => VerfiyCodeSignUp()),
  // GetPage(name: AppRoute.resetPassword, page: () => ResetPasswordScreen()),
  // GetPage(name: AppRoute.successReset, page: () => SuccessResetPassword()),
  // GetPage(name: AppRoute.successSignUp, page: () => SuccessSignUp()),
];
