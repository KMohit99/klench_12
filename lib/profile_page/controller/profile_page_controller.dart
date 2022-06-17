import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:klench_/utils/page_loader.dart';
import 'dart:convert' as convert;

import '../../Authentication/SignUp/model/signUpmodel.dart';
import '../../Dashboard/dashboard_screen.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../model/Editprofile.dart';
import '../model/userInfoModel.dart';

class Profile_page_controller extends GetxController {

  TextEditingController FullnameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController dateOfbirthController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  RxBool isuserinfoLoading = true.obs;
  UserInfoModel? userInfoModel;
  var getUSerModelList = UserInfoModel().obs;

  Future<dynamic> GetUserInfo({required BuildContext context}) async {
    print('Inside creator get email');
    // showLoader(context);
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    print("UserID $id_user");
    String url = (URLConstants.base_url +
        URLConstants.getProfileApi +
        "?id=${id_user}");
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
        nameController.text = userInfoModel!.data![0].username!;
        FullnameController.text = userInfoModel!.data![0].fullName!;
        phoneNumberController.text = userInfoModel!.data![0].phone!;
        emailAddressController.text = userInfoModel!.data![0].email!;
        dateOfbirthController.text = userInfoModel!.data![0].dob!;
        genderController.text = userInfoModel!.data![0].gender!;

        isuserinfoLoading(false);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // hideLoader(context);
        return userInfoModel;
      } else {
        isuserinfoLoading(false);

        // hideLoader(context);
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


  EditProfile? editProfile;
  RxBool isLoading = false.obs;
  File? imgFile;

  Future<dynamic> Editprofile({required BuildContext context}) async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    showLoader(context);
    var url = (URLConstants.base_url + URLConstants.EditProfileApi);
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (imgFile != null) {
      var files = await http.MultipartFile(
          'image',
          File(imgFile!.path).readAsBytes().asStream(),
          File(imgFile!.path).lengthSync(),
          filename: imgFile!.path.split("/").last);
      request.files.add(files);
    }
    request.fields['id'] = id_user;
    request.fields['fullName'] = id_user;
    request.fields['username'] = nameController.text;
    request.fields['phone'] = phoneNumberController.text;
    request.fields['email'] = emailAddressController.text;


    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final data = json.decode(responsed.body);
      editProfile = EditProfile.fromJson(data);
      print(editProfile);
      print(data);
      if (editProfile!.error == false) {
        // await PreferenceManager()
        //     .setPref(URLConstants.id, signUpModel!.user![0].id!);
        // await PreferenceManager()
        //     .setPref(URLConstants.type, signUpModel!.user![0].type!);
        // await CreatorgetUserInfo_Email(UserId: signUpModel!.user![0].id!);
        await CommonWidget().showToaster(msg: 'User Updated');
        await Get.to(DashboardScreen());
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





}