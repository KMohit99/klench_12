import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SignUp/SignUp_screen.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/Common_textfeild.dart';
import 'package:klench_/utils/TextStyle_utils.dart';
import 'package:klench_/utils/colorUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TexrUtils.dart';
import '../Forgot_pass/Forgot_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
          'Sign in',
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_grey, family: 'PM'),
        ),
        centerTitle: true,
      ),

      body: Container(
        color: Colors.transparent,
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
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
                      child: CommonTextFormField_text(
                        title: 'Username',
                        labelText: 'Enter Username',
                        iconData: IconButton(
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
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
                      child: CommonTextFormField_text_reversed(
                        title: 'Password',
                        labelText: 'Enter Password',
                        iconData: IconButton(
                          visualDensity: VisualDensity(vertical: -4,horizontal: -4),
                          icon: Image.asset(
                            AssetUtils.Face_unlock_icon,
                            color: HexColor("#606060"),

                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ForgotScreen());
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Forgot Password?',
                          style: FontStyleUtility.h13(
                              fontColor: ColorUtils.primary_grey, family: 'PM'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 52,
                    ),
                    common_button_gold(
                      onTap: () {
                        Get.to(DashboardScreen());
                      },
                      title_text: 'Sign In',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
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
                          offset: Offset(10,10),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    highlightColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: FontStyleUtility.h13(
                                  fontColor: ColorUtils.primary_grey,
                                  family: 'PR')),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(SignUpScreen());
                            },
                            child: Text(
                              "Sign Up!",
                              style: FontStyleUtility.h13(
                                  fontColor: ColorUtils.primary_gold,
                                  family: 'PB'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
