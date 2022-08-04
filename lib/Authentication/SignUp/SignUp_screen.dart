import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:age_calculator/age_calculator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../front_page/FrontpageScreen.dart';
import '../../setting_page/terms_conditions.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/Common_textfeild.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/UrlConstrant.dart';
import '../../utils/colorUtils.dart';
import 'package:intl/intl.dart';

import '../../utils/common_widgets.dart';
import 'Otp_verification.dart';
import 'controller/sign_up_controller.dart';
import 'model/checkUserModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool value = false;
  List<String> gender_list = <String>['Male', 'Female', 'Prefer not say'];
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var alpha_numeric =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');

  final SignUpScreenController _signUpScreenController = Get.put(
      SignUpScreenController(),
      tag: SignUpScreenController().toString());

  DateTime selectedDate = DateTime.now();
  DateDuration? duration;

  selectDoB(BuildContext context) async {
    DateTime? selected;
    // await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(1930),
    //   lastDate: DateTime(2025),
    //   builder: (context, child) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         colorScheme: ColorScheme.dark(
    //           primary: Colors.black,
    //           onPrimary: Colors.white,
    //           surface: ColorUtils.primary_grey,
    //           // onPrimary: Colors.black, // <-- SEE HERE
    //           onSurface: Colors.black,
    //         ),
    //         dialogBackgroundColor: ColorUtils.primary_gold,
    //         textButtonTheme: TextButtonThemeData(
    //           style: TextButton.styleFrom(
    //             primary: Colors.black, // button text color
    //           ),
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );
    // return Container(
    //   height: 200,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15),
    //       gradient: LinearGradient(
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter,
    //         colors: [
    //           HexColor("#000000").withOpacity(1),
    //           HexColor("#04060F").withOpacity(1),
    //           HexColor("#000000").withOpacity(1),
    //
    //         ],
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //             color: HexColor('#04060F'),
    //             offset: Offset(3, 3),
    //             blurRadius: 10)
    //       ]),
    //   child: Stack(
    //     children: [
    //       CupertinoTheme(
    //         data: CupertinoThemeData(
    //           brightness: Brightness.dark,
    //         ),
    //         child: CupertinoDatePicker(
    //           mode: CupertinoDatePickerMode.time,
    //           onDateTimeChanged: (DateTime value) {
    //             selected= value;
    //             print("${value.hour}:${value.minute}");
    //
    //             duration = AgeCalculator.age(selected!);
    //             print('Your age is $duration');

    //             setState(() {
    //               (duration!.years <= 50
    //                   ? _signUpScreenController.level = 'Normal'
    //                   : _signUpScreenController.level = 'Easy');
    //             });
    //
    //             print(_signUpScreenController.level);
    //
    //             if (selected != selectedDate) {
    //               setState(() {
    //                 _signUpScreenController.date_birth =
    //                     DateFormat('MM-dd-yyyy').format(selected!).toString();
    //                 _signUpScreenController.DoBController.text =
    //                     _signUpScreenController.date_birth.toString();
    //               });
    //             }
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
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
                        offset: const Offset(-10, 10),
                        blurRadius: 20)
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: const EdgeInsets.all(32),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              HexColor("#000000").withOpacity(1),
                              HexColor("#04060F").withOpacity(1),
                              HexColor("#000000").withOpacity(1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor('#04060F'),
                                offset: Offset(3, 3),
                                blurRadius: 10)
                          ]),
                      child: Stack(
                        children: [
                          CupertinoTheme(
                            data: CupertinoThemeData(
                              brightness: Brightness.dark,
                            ),
                            child: CupertinoDatePicker(
                              // use24hFormat: true,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime value) {
                                selected = value;
                                print("${value.hour}:${value.minute}");

                                if (selected != null) {
                                  final now = DateTime.now();
                                  var selectedDateTime = DateTime(
                                      now.year,
                                      now.month,
                                      now.day,
                                      selected!.hour,
                                      selected!.minute);
                                  duration = AgeCalculator.age(selected!);
                                  print('Your age is $duration');

                                  setModalState(() {
                                    (duration!.years <= 50
                                        ? _signUpScreenController.level = 'Normal'
                                        : _signUpScreenController.level = 'Easy');
                                  });

                                  print(_signUpScreenController.level);

                                  if (selected != selectedDate) {
                                    setModalState(() {
                                      _signUpScreenController.date_birth =
                                          DateFormat('MM-dd-yyyy').format(selected!).toString();
                                      _signUpScreenController.DoBController.text =
                                          _signUpScreenController.date_birth.toString();
                                    });
                                  }

                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  int? selectedRadio;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  select_gender(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              elevation: 0.0,
              // title: Center(child: Text("Evaluation our APP")),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 180,
                            width: 220,
                            decoration: BoxDecoration(
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
                                      blurRadius: 10)
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            // height: 122,
                            // width: 133,
                            // padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Selece Gender",
                                      style: FontStyleUtility.h15(
                                          fontColor: Colors.white,
                                          family: 'PM'),
                                    ),
                                    ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 0),
                                      itemCount: gender_list.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _signUpScreenController
                                                      .selected_gender =
                                                  gender_list[index];
                                              _signUpScreenController
                                                      .genderController.text =
                                                  _signUpScreenController
                                                      .selected_gender!;
                                              print(
                                                  "method_selected $_signUpScreenController.selected_gender");
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.5),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  gender_list[index],
                                                  style: FontStyleUtility.h15(
                                                      fontColor: ColorUtils
                                                          .primary_grey,
                                                      family: 'PM'),
                                                ),
                                              ),
                                              Radio(
                                                visualDensity: VisualDensity(
                                                    vertical: -4,
                                                    horizontal: -4),
                                                value: gender_list[index],
                                                groupValue:
                                                    _signUpScreenController
                                                        .selected_gender,
                                                activeColor:
                                                    ColorUtils.primary_gold,
                                                onChanged: (val) {
                                                  print("Radio $val");
                                                  setState(() {
                                                    _signUpScreenController
                                                            .selected_gender =
                                                        val as String?;
                                                    _signUpScreenController
                                                            .selected_gender =
                                                        gender_list[index];
                                                    _signUpScreenController
                                                            .genderController
                                                            .text =
                                                        _signUpScreenController
                                                            .selected_gender!;
                                                    Navigator.pop(context);
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          alignment: Alignment.topRight,
                          child: Container(
                              decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#36393E").withOpacity(1),
                                      HexColor("#020204").withOpacity(1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: HexColor('#04060F'),
                                        offset: Offset(0, 3),
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 13,
                                  color: ColorUtils.primary_grey,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        // resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
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
            'Sign up',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Container(
                      height: 49,
                      width: 170,
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      child: Image.asset(AssetUtils.Logo_white_icon)),
                ),
                Container(
                  decoration: Common_decoration(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 29, horizontal: 19),
                    child: Column(
                      children: [
                        Container(
                          child: CommonTextFormField(
                            controller:
                                _signUpScreenController.fullnameController,
                            labelText: 'Enter Full name',
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.signIN_user_icon,
                                color: HexColor("#606060"),
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
                          child: CommonTextFormField(
                            controller:
                                _signUpScreenController.usernameController,
                            labelText: 'Enter Username',
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.signIN_user_icon,
                                color: HexColor("#606060"),
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                            onChanged: (value) {
                              value = _signUpScreenController
                                  .usernameController.text;
                              CheckUserName(context);
                              setState(() {});
                            },
                            // errorText: checkUserModel!.message,
                            tap: () {
                              CheckUserName(context);
                            },
                          ),
                        ),
                        (username_error == false
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5),
                                  child: Text(
                                    checkUserModel!.message!,
                                    style: TextStyle(
                                        color: Colors.red, fontFamily: 'PR'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: (_signUpScreenController.imgFile == null
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.asset(
                                          AssetUtils.user_icon45,
                                          fit: BoxFit.fitWidth,
                                          height: 93,
                                          width: 106,
                                        ))
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        child: Image.file(
                                          _signUpScreenController.imgFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                              ),
                            ),
                            SizedBox(
                              width: 23,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text("Pick Image from"),
                                    actions: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              openCamera();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              // height: 45,
                                              // width:(width ?? 300) ,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  child: Text(
                                                    'Camera',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'PR',
                                                        fontSize: 16),
                                                  )),
                                            ),
                                          )),
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              openGallery();
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              // height: 45,
                                              // width:(width ?? 300) ,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  child: Text(
                                                    'Gallery',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'PR',
                                                        fontSize: 16),
                                                  )),
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'Upload image',
                                style: FontStyleUtility.h15(
                                    fontColor: ColorUtils.primary_grey,
                                    family: 'PM'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                    colors: [
                                      HexColor("#36393E").withOpacity(1),
                                      HexColor("#020204").withOpacity(1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(10, 10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: CountryCodePicker(
                                onChanged: (country) {
                                  setState(() {
                                    _signUpScreenController.dialCodedigits =
                                        country.dialCode!;
                                    print(
                                        _signUpScreenController.dialCodedigits);
                                  });
                                },
                                initialSelection: "IN",
                                textStyle: FontStyleUtility.h15(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PM'),
                                showCountryOnly: false,
                                showFlagMain: false,
                                padding: EdgeInsets.zero,
                                showFlag: true,
                                showOnlyCountryWhenClosed: false,
                                favorite: ["+1", "US", "+91", "IN"],
                                barrierColor: Colors.white,
                                backgroundColor: Colors.black,
                                dialogSize: Size.fromHeight(screenHeight / 2),
                              ),
                            ),
                            Container(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: CommonTextFormField(
                                  controller:
                                      _signUpScreenController.phoneController,
                                  labelText: 'Enter Mobile Number',
                                  iconData: IconButton(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    icon: Image.asset(
                                      AssetUtils.mobile_icons,
                                      height: 17,
                                      color: HexColor("#606060"),
                                      width: 15,
                                    ),
                                    onPressed: () {},
                                  ),
                                  onChanged: (value) {
                                    value = _signUpScreenController
                                        .phoneController.text;
                                    CheckPhoneName(context);
                                    setState(() {});
                                  },
                                  // errorText: checkUserModel!.message,
                                  tap: () {
                                    CheckPhoneName(context);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        (phone_error == false
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5),
                                  child: Text(
                                    checkPhoneModel!.message!,
                                    style: TextStyle(
                                        color: Colors.red, fontFamily: 'PR'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            controller: _signUpScreenController.emailController,
                            labelText: 'Email Address',
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.message_icons,
                                height: 17,
                                width: 15,
                                color: HexColor("#606060"),
                              ),
                              onPressed: () {},
                            ),
                            onChanged: (value) {
                              value =
                                  _signUpScreenController.emailController.text;
                              CheckEmailName(context);
                              setState(() {});
                            },
                            // errorText: checkUserModel!.message,
                            tap: () {
                              CheckEmailName(context);
                            },
                          ),
                        ),
                        (email_error == false
                            ? Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 1.0, horizontal: 5),
                                  child: Text(
                                    checkEmailModel!.message!,
                                    style: TextStyle(
                                        color: Colors.red, fontFamily: 'PR'),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            labelText: 'DOB',
                            controller: _signUpScreenController.DoBController,
                            tap: () {
                              selectDoB(context);
                            },
                            readOnly: true,
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.date_icons,
                                height: 17,
                                color: HexColor("#606060"),
                                width: 15,
                              ),
                              onPressed: () {
                                selectDoB(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            labelText: 'Gender',
                            controller:
                                _signUpScreenController.genderController,
                            tap: () {
                              select_gender(context);
                            },
                            readOnly: true,
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.arrow_down_icons,
                                color: HexColor("#606060"),
                                height: 13,
                                width: 13,
                              ),
                              onPressed: () {
                                select_gender(context);
                              },
                            ),
                          ),
                        ),
                        // Container(
                        //   width: screenWidth,
                        //   decoration: BoxDecoration(
                        //       // color: Colors.black.withOpacity(0.65),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.centerLeft,
                        //         end: Alignment.centerRight,
                        //         // stops: [0.1, 0.5, 0.7, 0.9],
                        //         colors: [
                        //           HexColor("#36393E").withOpacity(1),
                        //           HexColor("#020204").withOpacity(1),
                        //         ],
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: HexColor('#04060F'),
                        //           offset: Offset(10, 10),
                        //           blurRadius: 20,
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: FormField<String>(
                        //     builder: (FormFieldState<String> state) {
                        //       return DropdownButtonHideUnderline(
                        //         child: DropdownButton2(
                        //           isExpanded: true,
                        //           hint: Row(
                        //             children: [
                        //               SizedBox(
                        //                 width: 4,
                        //               ),
                        //               Expanded(
                        //                 child: Text(
                        //                   'Select gender',
                        //                   style: FontStyleUtility.h15(
                        //                       fontColor: ColorUtils.primary_grey,
                        //                       family: 'PM'),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           items: data
                        //               .map((item) => DropdownMenuItem<String>(
                        //                     value: item,
                        //                     child: Text(
                        //                       item,
                        //                       textAlign: TextAlign.center,
                        //                       style: FontStyleUtility.h15(
                        //                           fontColor:
                        //                               ColorUtils.primary_grey,
                        //                           family: 'PM'),
                        //                       overflow: TextOverflow.ellipsis,
                        //                     ),
                        //                   ))
                        //               .toList(),
                        //           value: selected_gender,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               selected_gender = value as String;
                        //             });
                        //             // print(contactdetailsController
                        //             //     .selectedValue);
                        //           },
                        //           iconSize: 25,
                        //           isDense: true,
                        //
                        //           icon: Image.asset(
                        //             AssetUtils.arrow_down_icons,
                        //             color: HexColor("#606060"),
                        //             height: 13,
                        //             width: 13,
                        //           ),
                        //
                        //           iconEnabledColor: Color(0xff007DEF),
                        //           iconDisabledColor: Color(0xff007DEF),
                        //           buttonHeight: 50,
                        //           buttonWidth: 160,
                        //           style: FontStyleUtility.h16(
                        //               fontColor: ColorUtils.primary_gold,
                        //               family: 'PM'),
                        //           buttonPadding:
                        //               const EdgeInsets.only(left: 15, right: 15),
                        //           buttonDecoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10),
                        //               color: Colors.transparent),
                        //           buttonElevation: 0,
                        //           itemHeight: 40,
                        //           itemPadding:
                        //               const EdgeInsets.only(left: 14, right: 14),
                        //           dropdownMaxHeight: 200,
                        //           // dropdownWidth: 200,
                        //           dropdownPadding: null,
                        //           dropdownDecoration: BoxDecoration(
                        //             // color: Colors.black.withOpacity(0.65),
                        //               gradient: LinearGradient(
                        //                 begin: Alignment.centerLeft,
                        //                 end: Alignment.centerRight,
                        //                 // stops: [0.1, 0.5, 0.7, 0.9],
                        //                 colors: [
                        //                   HexColor("#020204").withOpacity(1),
                        //                   HexColor("#36393E").withOpacity(1),
                        //                 ],
                        //               ),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: HexColor('#04060F'),
                        //                   offset: Offset(10,10),
                        //                   blurRadius: 20,
                        //                 ),
                        //               ],
                        //               borderRadius: BorderRadius.circular(10)),
                        //           dropdownElevation: 20,
                        //           scrollbarRadius: const Radius.circular(40),
                        //           scrollbarThickness: 6,
                        //           scrollbarAlwaysShow: true,
                        //           offset: const Offset(0, -5),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField_reversed(
                            controller:
                                _signUpScreenController.passwordController,
                            labelText: 'Password',
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.key_icons,
                                height: 17,
                                width: 15,
                                color: HexColor("#606060"),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   // width: 300,
                        //   decoration: BoxDecoration(
                        //     // color: Colors.black.withOpacity(0.65),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.centerLeft,
                        //         end: Alignment.centerRight,
                        //         // stops: [0.1, 0.5, 0.7, 0.9],
                        //         colors: [
                        //           HexColor("#020204").withOpacity(1),
                        //           HexColor("#36393E").withOpacity(1),
                        //         ],
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: HexColor('#04060F'),
                        //           offset: Offset(10, 10),
                        //           blurRadius: 20,
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: TextFormField(
                        //     maxLength: 6,
                        //     decoration: InputDecoration(
                        //         contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                        //         alignLabelWithHint: false,
                        //         isDense: true,
                        //         hintText: 'Password',
                        //         counterStyle: TextStyle(
                        //           height: double.minPositive,
                        //         ),
                        //         counterText: "",
                        //         filled: true,
                        //         border: InputBorder.none,
                        //         enabledBorder: const OutlineInputBorder(
                        //           borderSide: BorderSide(color: Colors.transparent, width: 1),
                        //           borderRadius: BorderRadius.all(Radius.circular(10)),
                        //         ),
                        //         hintStyle: FontStyleUtility.h15(
                        //             fontColor: ColorUtils.primary_grey, family: 'PM'),
                        //         suffixIcon: Container(
                        //             margin: EdgeInsets.all(4),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.red.withOpacity(0.65),
                        //                 gradient: LinearGradient(
                        //                   begin: Alignment.bottomLeft,
                        //                   end: Alignment.topRight,
                        //                   // stops: [0.1, 0.5, 0.7, 0.9],
                        //                   colors: [
                        //                     HexColor("#36393E").withOpacity(1),
                        //                     HexColor("#020204").withOpacity(1),
                        //                   ],
                        //                 ),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: HexColor('#04060F'),
                        //                     offset: Offset(3, 3),
                        //                     blurRadius: 20,
                        //                   ),
                        //                 ],
                        //                 borderRadius: BorderRadius.circular(50)),
                        //             child: IconButton(
                        //               visualDensity:
                        //               VisualDensity(horizontal: -4, vertical: -4),
                        //               icon: Image.asset(
                        //                 AssetUtils.key_icons,
                        //                 height: 17,
                        //                 width: 15,
                        //                 color: HexColor("#606060"),
                        //               ),
                        //               onPressed: () {},
                        //             ),)),
                        //     style: FontStyleUtility.h15(
                        //       fontColor: ColorUtils.primary_gold,
                        //       family: 'PM',
                        //     ),
                        //     controller:  _signUpScreenController.passwordController,
                        //     // keyboardType: keyboardType ?? TextInputType.multiline,
                        //   ),
                        // ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            controller: _signUpScreenController
                                .confirmPasswordController,
                            labelText: 'Confirm Password',
                            iconData: IconButton(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              icon: Image.asset(
                                AssetUtils.key_icons,
                                height: 17,
                                color: HexColor("#606060"),
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: ColorUtils.primary_gold,
                      ),
                      child: Checkbox(
                        checkColor: Colors.black,
                        activeColor: ColorUtils.primary_gold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        value: this.value,
                        onChanged: (value) {
                          setState(() {
                            this.value = value!;
                            print(value);
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(TermsConditionsScreen());
                      },
                      child: Container(
                        child: Text(
                          'Terms & Conditions',
                          style: FontStyleUtility.h15(
                              fontColor: ColorUtils.primary_gold, family: 'PM'),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                common_button_gold(
                  onTap: () async {
                    if (username_error == true &&
                        email_error == true &&
                        phone_error == true) {
                      if (value == false) {
                        CommonWidget().showErrorToaster(
                            msg: "Please agree Terms and Conditions");
                        return;
                      }
                      if (!reg.hasMatch(
                          _signUpScreenController.emailController.text)) {
                        CommonWidget()
                            .showErrorToaster(msg: "Invalid Email Address");
                        return;
                      }

                      if (_signUpScreenController
                              .passwordController.text.length <
                          6) {
                        CommonWidget().showErrorToaster(
                            msg:
                                "Your password must contain minimum 6 character");
                        return;
                      }

                      if (_signUpScreenController.passwordController.text !=
                          _signUpScreenController
                              .confirmPasswordController.text) {
                        CommonWidget()
                            .showErrorToaster(msg: "Password doesn't match");
                        return;
                      }

                      if (!alpha_numeric.hasMatch(
                          _signUpScreenController.passwordController.text)) {
                        CommonWidget().showErrorToaster(
                            msg: "Your password must be alpha numeric");
                        return;
                      }
                      if (_signUpScreenController.phoneController.text.length <
                          10) {
                        CommonWidget()
                            .showErrorToaster(msg: "Enter valid number");
                        return;
                      }
                      // if (_signUpScreenController.imgFile == null ) {
                      //   CommonWidget()
                      //       .showErrorToaster(msg: "Please upload Profile image");
                      //   return;
                      // }
                      await _signUpScreenController.SendOtpAPi(
                          context: context);
                    }
                  },
                  title_text: 'Next',
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final imgPicker = ImagePicker();

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _signUpScreenController.imgFile = File(imgGallery!.path);
      print(_signUpScreenController.imgFile!.path);
    });
  }

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      _signUpScreenController.imgFile = File(imgCamera!.path);
    });
  }

  CheckUserModel? checkUserModel;
  CheckUserModel? checkEmailModel;
  CheckUserModel? checkPhoneModel;
  bool username_error = true;
  bool email_error = true;
  bool phone_error = true;

  Future<dynamic> CheckUserName(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    Map data = {
      'username': _signUpScreenController.usernameController.text,
    };
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.CheckUserApi);
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
      var data = jsonDecode(response.body);
      checkUserModel = CheckUserModel.fromJson(data);
      print(checkUserModel);
      setState(() {
        username_error = checkUserModel!.error!;
      });
      if (checkUserModel!.error == false) {
        setState(() {});
        // Get.to(CreatorOtpVerification());
        // Get.to(OtpScreen(received_otp: otpModel!.user![0].body!,));
      } else {
        print('Please try again');
      }
    } else {
      print('Please try again');
    }
  }

  Future<dynamic> CheckEmailName(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    Map data = {
      'email': _signUpScreenController.emailController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.CheckUserApi);
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
      var data = jsonDecode(response.body);
      checkEmailModel = CheckUserModel.fromJson(data);
      print(checkEmailModel);
      setState(() {
        email_error = checkEmailModel!.error!;
      });
      if (checkEmailModel!.error == false) {
        setState(() {});
        // Get.to(CreatorOtpVerification());
        // Get.to(OtpScreen(received_otp: otpModel!.user![0].body!,));
      } else {
        print('Please try again');
      }
    } else {
      print('Please try again');
    }
  }

  Future<dynamic> CheckPhoneName(BuildContext context) async {
    debugPrint('0-0-0-0-0-0-0 username');
    Map data = {
      'phone': _signUpScreenController.phoneController.text,
    };
    print(data);
    // String body = json.encode(data);

    var url = (URLConstants.base_url + URLConstants.CheckUserApi);
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
      var data = jsonDecode(response.body);
      checkPhoneModel = CheckUserModel.fromJson(data);
      print(checkPhoneModel);
      setState(() {
        phone_error = checkPhoneModel!.error!;
      });
      if (checkPhoneModel!.error == false) {
        setState(() {});
        // Get.to(CreatorOtpVerification());
        // Get.to(OtpScreen(received_otp: otpModel!.user![0].body!,));
      } else {
        print('Please try again');
      }
    } else {
      print('Please try again');
    }
  }
}
