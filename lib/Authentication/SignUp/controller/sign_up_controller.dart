import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/Authentication/SignUp/model/verifyOtpModel.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';

import '../../../utils/UrlConstrant.dart';
import '../../../utils/common_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../utils/page_loader.dart';
import '../Otp_verification.dart';
import '../model/sendOtpModel.dart';
import '../model/signUpmodel.dart';

class SignUpScreenController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController DoBController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController OtpController = TextEditingController();

  String? date_birth;
  String? selected_gender;

  SignUpModel? signUpModel;
  RxBool isLoading = false.obs;
  File? imgFile;

  // Future<dynamic> SignUpAPi({required BuildContext context}) async {
  //   debugPrint('0-0-0-0-0-0-0 username');
  //   isLoading(true);
  //   // showLoader(context);
  //   // username,phone,email,dob,gender,password,image
  //   Map data = {
  //     'username': usernameController.text,
  //     'phone': phoneController.text,
  //     'email': emailController.text,
  //     'dob': date_birth,
  //     'gender': selected_gender,
  //     'password': passwordController.text,
  //     'image': 'login_type',
  //   };
  //   print(data);
  //   // String body = json.encode(data);
  //
  //   var url = (URLConstants.base_url + URLConstants.signUpApi);
  //   print("url : $url");
  //   print("body : $data");
  //
  //   var response = await http.post(
  //     Uri.parse(url),
  //     body: data,
  //   );
  //   print(response.body);
  //   print(response.request);
  //   print(response.statusCode);
  //   // var final_data = jsonDecode(response.body);
  //
  //   // print('final data $final_data');
  //
  //   if (response.statusCode == 200) {
  //     isLoading(false);
  //     var data = jsonDecode(response.body);
  //     signUpModel = SignUpModel.fromJson(data);
  //     print(signUpModel);
  //     if (signUpModel!.error == false) {
  //       // await PreferenceManager()
  //       //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
  //       // await PreferenceManager()
  //       //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
  //       // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
  //       await CommonWidget().showToaster(msg: 'User Created');
  //       await Get.to(DashboardScreen());
  //       hideLoader(context);
  //     } else {
  //       hideLoader(context);
  //       CommonWidget().showErrorToaster(msg: "Invalid Details");
  //       print('Please try again');
  //       print('Please try again');
  //     }
  //   } else {}
  // }


  Future<dynamic> SignUpAPi({required BuildContext context}) async {
    showLoader(context);
    var url = (URLConstants.base_url + URLConstants.signUpApi);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    List<int> imageBytes = imgFile!.readAsBytesSync();
    String baseimage = base64Encode(imageBytes);
    var files = await http.MultipartFile(
        'image',
        File(imgFile!.path).readAsBytes().asStream(),
        File(imgFile!.path).lengthSync(),
        filename: imgFile!.path.split("/").last);
    request.files.add(files);
    request.fields['username'] = usernameController.text;
    request.fields['phone'] = phoneController.text;
    request.fields['email'] = emailController.text;
    request.fields['dob'] = date_birth!;
    request.fields['gender'] = selected_gender!;
    request.fields['password'] = passwordController.text;

    //userId,tagLine,description,address,postImage,uploadVideo,isVideo
    // request.files.add(await http.MultipartFile.fromPath(
    //     "image", widget.ImageFile.path));

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(responsed.body);
      signUpModel = SignUpModel.fromJson(data);
      print(signUpModel);
      if (signUpModel!.error == false) {
        await PreferenceManager()
            .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: 'User Created');
        // await Get.to(DashboardScreen());
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
        // print('Please try again');
        // print('Please try again');
      }
      hideLoader(context);
    } else {
      print("ERROR");
    }
  }

  SendOtpModel? sendOtpModel;
  RxBool sendOtpLoading = false.obs;

  Future<dynamic> SendOtpAPi({required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    sendOtpLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'email': emailController.text,
      'phone': phoneController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.sendOtpApi);
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
      sendOtpLoading(false);
      var data = jsonDecode(response.body);
      sendOtpModel = SendOtpModel.fromJson(data);
      print(sendOtpModel);
      if (sendOtpModel!.error == false) {
        await Get.to(VerifyOtp());
        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }

  VerifyOtpModel? verifyOtpModel;
  RxBool verifyOtpLoading = false.obs;

  Future<dynamic> VerifyOtpAPi({required BuildContext context}) async {
    debugPrint('0-0-0-0-0-0-0 username');
    verifyOtpLoading(true);
    showLoader(context);
    // username,phone,email,dob,gender,password,image
    Map data = {
      'otp': OtpController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.verifyOtpApi);
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
      verifyOtpLoading(false);
      var data = jsonDecode(response.body);
      verifyOtpModel = VerifyOtpModel.fromJson(data);
      print(verifyOtpModel);
      if (verifyOtpModel!.error == false) {
        await CommonWidget().showToaster(msg: "Otp Verified");
        // await SignUpAPi(context: context);
        await SignUpAPi(context: context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Otp");
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }
}
