import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/front_page/FrontpageScreen.dart';
import 'package:klench_/utils/Asset_utils.dart';
import 'package:klench_/utils/UrlConstrant.dart';
import 'package:local_auth/local_auth.dart';

import 'Authentication/SignUp/local_auth_api.dart';
import 'getx_pagination/binding_utils.dart';
import 'homepage/alarm_info.dart';
import 'homepage/controller/kegel_excercise_controller.dart';
import 'homepage/kegel_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      // Get.to(FrontScreen());
      init();
    });
  }

  init() async {

    String id_user = await PreferenceManager().getPref(URLConstants.id);
    (id_user == 'id' || id_user.isEmpty)
        ? Get.to(FrontScreen())
        : method();
  }

  method() async {
    bool auth = await PreferenceManager().getbool(URLConstants.authentication_enable);
    print(auth);

    if (auth== true) {
      final isAuthenticated = await LocalAuthApi.authenticate();

      if (isAuthenticated) {
        await _kegel_controller.alarm_notifications(context);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
      else{
        SystemNavigator.pop();
      }
    }else{
      await _kegel_controller.alarm_notifications(context);

     await Get.to(DashboardScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 86),
            child: Image.asset(AssetUtils.Logo_white_icon)),
      ),
    );
  }

  final Kegel_controller _kegel_controller =
  Get.put(Kegel_controller(), tag: Kegel_controller().toString());


  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }
}
