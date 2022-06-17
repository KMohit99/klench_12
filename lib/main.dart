
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:klench_/splash_Screen.dart';
import 'package:local_auth/local_auth.dart';

import 'getx_pagination/Bindings_class.dart';
import 'getx_pagination/binding_utils.dart';
import 'getx_pagination/page_route.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final style = SystemUiOverlayStyle(
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    return GetMaterialApp(
      // navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Klench_12',
      initialRoute: BindingUtils.initialRoute,
      initialBinding: Splash_Bindnig(),
      getPages: AppPages.getPageList,
      // home: (Token == '_' ||
      //         Token.toString() == 'null' ||
      //         Token.toString().isEmpty ||
      //         roles == '_' ||
      //         roles == 'null' ||
      //         roles.toString().isEmpty)
      //     ? loginScreen()
      //     : (roles == "company")
      //         ? addCompanyScreen()
      //         : (roles == "plan")
      //             ? subscription_Screen()
      //             : DashBoardScreen(),

      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
        dividerColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),

      ),
    );
  }



}
