import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/Common_textfeild.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/colorUtils.dart';
import 'package:intl/intl.dart';

import 'Otp_verification.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool value = false;
  final List<String> data = <String>['Male', 'Female', 'Prefer not say'];
  String? selected_gender;
  DateTime selectedDate = DateTime.now();
  String showInvoiceDate = '';
  TextEditingController dobcontroller = new TextEditingController();

  selectDoB(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: ColorUtils.primary_grey,
              // onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: ColorUtils.primary_gold,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        showInvoiceDate = DateFormat('MM-dd-yyyy').format(selected).toString();
        dobcontroller.text = showInvoiceDate.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 29, horizontal: 19),
                  child: Column(
                    children: [
                      Container(
                        child: CommonTextFormField(
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
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                child: Image.asset(
                              AssetUtils.user_icon4,
                              height: 93,
                              width: 106,
                            )),
                          ),
                          SizedBox(
                            width: 23,
                          ),
                          Text(
                            'Upload image',
                            style: FontStyleUtility.h15(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PM'),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: CommonTextFormField(
                          labelText: 'Enter Mobile Number',
                          iconData: IconButton(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            icon: Image.asset(
                              AssetUtils.mobile_icons,
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
                      Container(
                        child: CommonTextFormField(
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
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: CommonTextFormField(
                          labelText: 'DOB',
                          controller: dobcontroller,
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
                            onPressed: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: screenWidth,
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
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select gender',
                                        style: FontStyleUtility.h15(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PM'),
                                      ),
                                    ),
                                  ],
                                ),
                                items: data
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            textAlign: TextAlign.center,
                                            style: FontStyleUtility.h15(
                                                fontColor:
                                                    ColorUtils.primary_grey,
                                                family: 'PM'),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selected_gender,
                                onChanged: (value) {
                                  setState(() {
                                    selected_gender = value as String;
                                  });
                                  // print(contactdetailsController
                                  //     .selectedValue);
                                },
                                iconSize: 25,
                                isDense: true,

                                icon: Image.asset(
                                  AssetUtils.arrow_down_icons,
                                  color: HexColor("#606060"),
                                  height: 13,
                                  width: 13,
                                ),

                                iconEnabledColor: Color(0xff007DEF),
                                iconDisabledColor: Color(0xff007DEF),
                                buttonHeight: 50,
                                buttonWidth: 160,
                                style: FontStyleUtility.h16(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PM'),
                                buttonPadding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent),
                                buttonElevation: 0,
                                itemHeight: 40,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                // dropdownWidth: 200,
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
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
                                        offset: Offset(10,10),
                                        blurRadius: 20,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10)),
                                dropdownElevation: 20,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 6,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(0, -5),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: CommonTextFormField_reversed(
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: CommonTextFormField(
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
                  Container(
                    child: Text(
                      'Terms & Conditions',
                      style: FontStyleUtility.h15(
                          fontColor: ColorUtils.primary_gold, family: 'PM'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              common_button_gold(
                onTap: () {
                  Get.to(VerifyOtp());
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
    );
  }
}
