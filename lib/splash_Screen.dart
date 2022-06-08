
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/front_page/FrontpageScreen.dart';
import 'package:klench_/utils/Asset_utils.dart';

import 'getx_pagination/binding_utils.dart';

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
      Get.to(FrontScreen());
    });
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
}
