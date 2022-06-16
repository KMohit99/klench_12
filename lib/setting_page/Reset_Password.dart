import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/front_page/FrontpageScreen.dart';
import 'package:klench_/utils/Common_textfeild.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../Authentication/Forgot_pass/controller/forgot_password_controller.dart';
import '../utils/UrlConstrant.dart';
import '../utils/common_widgets.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final ForgotPasswordController _forgotPasswordController = Get.put(
      ForgotPasswordController(),
      tag: ForgotPasswordController().toString());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                width: 41,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                        begin: Alignment(-1.0, -4.0),
                        end: Alignment(1.0, 4.0),
                        colors: [HexColor('#020204'), HexColor('#36393E')])),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    AssetUtils.arrow_back,
                    height: 14,
                    width: 15,
                  ),
                )),
          ),
          title: Text(
            "Reset password",
            style: FontStyleUtility.h16(
                fontColor: ColorUtils.primary_grey, family: 'PM'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.65),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          HexColor("#36393E").withOpacity(1),
                          HexColor("#020204").withOpacity(1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 36, horizontal: 14),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    HexColor('#36393E'),
                                    HexColor('#020204'),
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                    color: HexColor('#04060F'),
                                    offset: Offset(3, 3),
                                    blurRadius: 10)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(27.0),
                            child: Image.asset(
                              AssetUtils.key_icons_big,
                              color: ColorUtils.primary_gold,
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              // color: Colors.black.withOpacity(0.65),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#020204").withOpacity(1),
                                  HexColor("#36393E").withOpacity(1),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#000000'),
                                  offset: Offset(10, 10),
                                  blurRadius: 20,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Reset password",
                                    style: FontStyleUtility.h16(
                                        fontColor: ColorUtils.primary_grey,
                                        family: 'PM'),
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                ),
                                Container(
                                  child: CommonTextFormField_text_reversed(
                                    title: 'Old password',
                                    labelText: 'xxxxxxxxx',
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.key_icons,
                                        color: ColorUtils.primary_grey,
                                        height: 17,
                                        width: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: CommonTextFormField_text_reversed(
                                    title: 'New password',
                                    labelText: 'xxxxxxxxxx',
                                    controller: _forgotPasswordController
                                        .newPasswordController,
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.key_icons,
                                        color: ColorUtils.primary_grey,
                                        height: 17,
                                        width: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  child: CommonTextFormField_text_reversed(
                                    title: 'Confirm New password',
                                    labelText: 'xxxxxxxxxx',
                                    controller: _forgotPasswordController
                                        .ConfirmNewPasswordController,
                                    iconData: IconButton(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      icon: Image.asset(
                                        AssetUtils.key_icons,
                                        color: ColorUtils.primary_grey,
                                        height: 17,
                                        width: 15,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                common_button_gold(
                                  onTap: () async {
                                    String id_user = await PreferenceManager()
                                        .getPref(URLConstants.id);
                                    if (_forgotPasswordController
                                            .newPasswordController.text !=
                                        _forgotPasswordController
                                            .ConfirmNewPasswordController.text) {
                                      CommonWidget().showErrorToaster(
                                          msg: "Password doesn't match");
                                      return;
                                    }

                                    await _forgotPasswordController
                                        .ResetPasswordAPi(
                                            context: context, id: id_user);
                                    if (_forgotPasswordController
                                            .passwordResetModel!.error ==
                                        false) {
                                      selectTowerBottomSheet(context);
                                    }
                                  },
                                  title_text: 'Save',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectTowerBottomSheet(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: StatefulBuilder(
            builder: (context, state) {
              return Container(
                height: screenheight * 0.445,
                width: screenwidth,
                decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.65),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    // stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      HexColor("#020204").withOpacity(1),
                      HexColor("#36393E").withOpacity(1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor('#04060F'),
                      offset: Offset(10, 10),
                      blurRadius: 20,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(33.9),
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          AssetUtils.happy_Face_icon,
                          color: ColorUtils.primary_grey,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 42),
                        child: Text('You have successfully reset password',
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR')),
                      ),
                      common_button_gold(
                        onTap: () {
                          Get.to(FrontScreen());
                        },
                        title_text: 'Go to Login',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
