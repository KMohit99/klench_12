import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';

import '../../../Dashboard/dashboard_screen.dart';
import '../../../profile_page/controller/profile_page_controller.dart';
import '../../../profile_page/model/userInfoModel.dart';
import '../../../utils/UrlConstrant.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/page_loader.dart';
import '../model/SignInModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

        // await PreferenceManager()
        //     .setPref(URLConstants.levels, userInfoModel!.data![0].levels!);
        print(singInModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: 'Successfully Loggedin');
        await clear_method();
        await GetUserInfo(context: context);
        await Get.to(DashboardScreen());

        hideLoader(context);
      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: "Invalid Details");
      }
    } else {}
  }


  RxBool isuserinfoLoading = true.obs;
  UserInfoModel? userInfoModel;
  var getUSerModelList = UserInfoModel().obs;
  int? level_rank;
  int selectedCard = 0;

  final Profile_page_controller _profile_page_controller = Get.put(
      Profile_page_controller(),
      tag: Profile_page_controller().toString());

  Future<dynamic> GetUserInfo({required BuildContext context}) async {
    print('Inside creator get email');
    showLoader(context);
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    print("UserID $id_user");
    String url =
    (URLConstants.base_url + URLConstants.getProfileApi + "?id=${id_user}");
    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }

    http.Response response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = convert.jsonDecode(response.body);
      userInfoModel = UserInfoModel.fromJson(data);
      getUSerModelList(userInfoModel);
      if (userInfoModel!.error == false) {
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${userInfoModel!.data!.length}');
        await PreferenceManager()
            .setPref(URLConstants.levels, userInfoModel!.data![0].levels!);

        _profile_page_controller.nameController.text =
        userInfoModel!.data![0].username!;
        _profile_page_controller.FullnameController.text =
        userInfoModel!.data![0].fullName!;
        _profile_page_controller.dialCodedigits =
        userInfoModel!.data![0].countryCode!;
        _profile_page_controller.phoneNumberController.text =
        userInfoModel!.data![0].phone!;
        _profile_page_controller.emailAddressController.text =
        userInfoModel!.data![0].email!;
        _profile_page_controller.dateOfbirthController.text =
        userInfoModel!.data![0].dob!;
        _profile_page_controller.genderController.text =
        userInfoModel!.data![0].gender!;

        (userInfoModel!.data![0].levels == 'Very Easy'
            ? level_rank = 0
            : (userInfoModel!.data![0].levels == 'Easy'
            ? level_rank = 1
            : (userInfoModel!.data![0].levels == 'Normal'
            ? level_rank = 2
            : (userInfoModel!.data![0].levels == 'Hard'
            ? level_rank = 3
            : (userInfoModel!.data![0].levels == 'ထ'
            ? level_rank = 4
            : level_rank = 0)))));

        print("Level : ${userInfoModel!.data![0].levels}");
        print('Rank level : $level_rank');

          isuserinfoLoading(false);
          selectedCard = level_rank!;
        hideLoader(context);
        return userInfoModel;
      } else {
          isuserinfoLoading(false);

        hideLoader(context);
        CommonWidget().showToaster(msg: 'Error');
        return null;
      }
    } else if (response.statusCode == 422) {
      // CommonWidget().showToaster(msg: msg.toString());
    } else if (response.statusCode == 401) {
      // CommonService().unAuthorizedUser();
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }
  }



  clear_method(){
    usernameController.clear();
    passwordController.clear();
  }
}