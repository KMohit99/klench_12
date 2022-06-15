import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:klench_/utils/page_loader.dart';
import 'dart:convert' as convert;

import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import '../model/userInfoModel.dart';

class Profile_page_controller extends GetxController {

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


}