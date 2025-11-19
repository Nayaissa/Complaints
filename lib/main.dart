
import 'package:complaint/bindings/initalbindings.dart';
import 'package:complaint/core/class/diohelper.dart';
import 'package:complaint/core/localization/localChange.dart';
import 'package:complaint/core/localization/translation.dart';
import 'package:complaint/core/services/services.dart';
import 'package:complaint/routes.dart';
import 'package:complaint/view/screen/auth/login_screen.dart';
import 'package:complaint/view/screen/home/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initalSevices();
DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  
   @override
  Widget build(BuildContext context) {
    // LocalController controller = Get.put(LocalController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
    //  locale: controller.language,
      translations: MyTranslation(), 
      fallbackLocale: Locale('en'),   
    //  theme: controller.appTheme,
      initialBinding: InitialBinding(),
      initialRoute: '/',
     getPages: getPages,
  //
   //  home:MainPage() ,
    );
  }
}
