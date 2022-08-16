import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:klench_/utils/page_loader.dart';

import '../../utils/UrlConstrant.dart';
import '../../utils/common_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/kegel_get_model.dart';
import '../model/kegel_post_model.dart';

class Kegel_controller extends GetxController {


  int sets = 0;

  RxBool isuserinfoLoading = true.obs;
  KegelGetModel? kegelGetModel;
  var getUSerModelList = KegelGetModel().obs;

  Future<dynamic> Kegel_get_API(BuildContext context) async {
    isuserinfoLoading(true);
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    String url = "${URLConstants.base_url}${URLConstants.kegel_get}?userId=$id_user";
    showLoader(context);

    var response = await http.get(Uri.parse(url));

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      // var data = convert.jsonDecode(response.body);
      Map<String, dynamic> data =
      json.decode(response.body.replaceAll('}[]', '}'));
      kegelGetModel = KegelGetModel.fromJson(data);
      // getUSerModelList(userInfoModel_email);
      if (kegelGetModel!.error == false) {
        hideLoader(context);
        debugPrint(
            '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${kegelGetModel!.data!.length}');
        // CommonWidget().showToaster(msg: breathingGetModel!.message!);
        // CommonWidget().showToaster(msg: data["success"].toString());
        // await Get.to(Dashboard());
        isuserinfoLoading(false);

        return kegelGetModel;
      } else {
        hideLoader(context);

        // CommonWidget().showToaster(msg: kegelGetModel!.message!);
        return null;
      }
    } else if (response.statusCode == 422) {

      hideLoader(context);

      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else if (response.statusCode == 401) {

      hideLoader(context);
      CommonWidget().showToaster(msg: kegelGetModel!.message!);
    } else {
      // CommonWidget().showToaster(msg: msg.toString());
    }


  }

  KegelPostModel? kegelPostModel;
  Future<dynamic> Kegel_post_API(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    // try {
    //
    // } catch (e) {
    //   print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    // }
    // isLoading(true);
    showLoader(context);
    String id_user = await PreferenceManager().getPref(URLConstants.id);

    Map data = {
      'userId': id_user,
      'sets': sets.toString(),
      'createdDate' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'startTime' :'',
      'finishTime' :'',
      'pause' :'',
      'alarm' :'',
      'repeate' :'',
      'sound' :'',
      'kegel_info' :'',
      // 'type': login_type,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.kegel_post);
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
      // isLoading(false);
      var data = jsonDecode(response.body);
      // kegelPostModel = KegelPostModel.fromJson(data);
      // print(kegelPostModel);
      if (data["error"] == false) {
        CommonWidget().showToaster(msg: data["message"]);

        hideLoader(context);

      } else {
        hideLoader(context);
        CommonWidget().showErrorToaster(msg: data["message"]);
        print('Please try again');
        print('Please try again');
      }
    } else {}
  }




}