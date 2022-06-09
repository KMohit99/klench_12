import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/SingIn/SigIn_screen.dart';
import 'package:klench_/notifications/notifications_screen.dart';
import 'package:klench_/setting_page/help_support.dart';
import 'package:klench_/setting_page/intro_video.dart';
import 'package:klench_/setting_page/privacy_policy_screen.dart';
import 'package:klench_/setting_page/qr_code_screen.dart';
import 'package:klench_/setting_page/refferal_link.dart';
import 'package:klench_/setting_page/terms_conditions.dart';

import '../front_page/FrontpageScreen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';
import 'About_us_screen.dart';
import 'FAQ.dart';
import 'Reset_Password.dart';
import 'contact_screen.dart';
import 'notification_settings.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List Icon_data = [
    AssetUtils.qrcode_icons,
    AssetUtils.privacy_icons,
    AssetUtils.FaQ_icons,
    AssetUtils.aboutUs_icons,
    AssetUtils.contact_icons,
    AssetUtils.terms_icons,
    AssetUtils.help_support_icons,
    AssetUtils.reset_pass_icons,
    AssetUtils.intro_video_icons,
    AssetUtils.referralLink_icons,
    AssetUtils.notification_icons,
    AssetUtils.logout_icons,
  ];

  List txt_list = [
    "My Qr",
    "Privacy Policy",
    "FAQ",
    "About us",
    "Contact us",
    "Terms & Conditions",
    "Help & support",
    "Reset password",
    "Intro video",
    "Referral link",
    "Notification",
    "Logout",
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: FontStyleUtility.h16(fontColor: Colors.white, family: 'PM'),
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  HexColor("#36393E").withOpacity(1),
                  HexColor("#020204").withOpacity(1),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: HexColor('#2A2A29'),
              //     offset: Offset(10, 10),
              //     blurRadius: 20,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 0, right: 8, left: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Icon_data.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        print(index);
                        (index == 0
                            ? Get.to(QrCodeScreen())
                            : (index == 1
                                ? Get.to(PrivacyPolicy())
                                : (index == 2
                                    ? Get.to(faq_screen())
                                    : (index == 3
                                        ? Get.to(AboutUs_Screen())
                                        : (index == 4
                                            ? Get.to(ContactScreen())
                                            : (index == 5
                                                ? Get.to(
                                                    TermsConditionsScreen())
                                                : (index == 6
                                                    ? Get.to(Help_Support())
                                                    : (index == 7
                                                        ? Get.to(
                                                            ResetPassword())
                                                        : (index == 8
                                                            ? Get.to(
                                                                Intro_videoScreen())
                                                            : (index == 9
                                                                ? Get.to(
                                                                    RefferalLinkScreen())
                                                                : (index == 10
                                                                    ? Get.to(
                                                                        NotificationSettings())
                                                                    : (index ==
                                                                            11
                                                                        ? Get.to(
                                                                            FrontScreen())
                                                                        : null))))))))))));
                        // if(index == 0){
                        //   Get.to(QrCodeScreen());
                        // }else if(index == 1){
                        //   Get.to(PrivacyPolicy());
                        // }else if(index == 2){
                        //   Get.to(faq_screen());
                        // }else if(index == 3){
                        //   Get.to(AboutUs_Screen());
                        // }else if(index == 4){
                        //   Get.to(ContactScreen());
                        // }
                      },
                      child: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity:
                              VisualDensity(horizontal: 0, vertical: -4),
                          leading: SizedBox(
                            height: 18,
                            width: 18,
                            child: Image.asset(
                              Icon_data[index],
                            ),
                          ),
                          title: Text(
                            txt_list[index],
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.primary_grey,
                                family: 'PR'),
                          ),
                          trailing: Icon(
                            Icons.navigate_next,
                            color: ColorUtils.dark_grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5, right: 0, left: 0),
                      height: 1,
                      color: ColorUtils.dark_grey.withOpacity(0.5),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }
}
