

import 'package:get/get.dart';

import '../splash_Screen.dart';
import 'Bindings_class.dart';
import 'binding_utils.dart';

class AppPages {
  static final getPageList = [
    GetPage(
      name: BindingUtils.splashRoute,
      page: () => SplashScreen(),
      binding: Splash_Bindnig(),
    ),
 GetPage(
      name: BindingUtils.FrontpageScreenScreenRoute,
      page: () => SplashScreen(),
      binding: Frontpage_Bindnig(),
    ),

  ];
}
