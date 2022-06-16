import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';

import '../../../Dashboard/dashboard_screen.dart';
import '../../../utils/UrlConstrant.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/page_loader.dart';
import '../model/SignInModel.dart';
import 'package:http/http.dart' as http;

class SignInScreenController extends GetxController {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  SingInModel? singInModel;
  RxBool isLoading = false.obs;
  Future<dynamic> SignUpAPi(
      {required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    isLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'username': usernameController.text,
      'password': passwordController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.loginApi);
    print("url : $url");
    print("body : $data");

    var response = await http.post(
      Uri.parse(url),
      body: data,
    );
    print(response.body);
    print(response.request);
    print(response.statusCode);
    // var final_data = jsonDecode(response.body);

    // print('final data $final_data');

    if (response.statusCode == 200) {
      isLoading(false);
      var data = jsonDecode(response.body);
      singInModel = SingInModel.fromJson(data);
      print(singInModel);
      if (singInModel!.error == false) {
        await PreferenceManager()
            .setPref(URLConstants.id, singInModel!.user![0].id!);
        await PreferenceManager()
            .setPref(URLConstants.username, singInModel!.user![0].username!);
        print(singInModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: 'Successfully Loggedin');
        await clear_method();
        await Get.to(DashboardScreen());

        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
      }
    } else {}
  }

  clear_method(){
    usernameController.clear();
    passwordController.clear();
  }
}