import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Authentication/subscription_plan/subscription_plan_screen.dart';
import 'package:klench_/utils/TexrUtils.dart';

import '../../front_page/FrontpageScreen.dart';
import '../../utils/Asset_utils.dart';
import '../../utils/Common_buttons.dart';
import '../../utils/Common_container_color.dart';
import '../../utils/TextStyle_utils.dart';
import '../../utils/colorUtils.dart';

class WelcomeVideoScreen extends StatefulWidget {
  const WelcomeVideoScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeVideoScreen> createState() => _WelcomeVideoScreenState();
}

class _WelcomeVideoScreenState extends State<WelcomeVideoScreen> {
  // BetterPlayerController? _betterPlayerController;
  //
  // better_player_code() {
  //   BetterPlayerConfiguration betterPlayerConfiguration =
  //       const BetterPlayerConfiguration(
  //     aspectRatio: 16 / 9,
  //     fit: BoxFit.contain,
  //   );
  //   BetterPlayerDataSource dataSource = BetterPlayerDataSource(
  //       BetterPlayerDataSourceType.network,
  //       "http://techslides.com/demos/sample-videos/small.mp4",
  //       useAsmsSubtitles: true,
  //       useAsmsTracks: true);
  //   _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
  //   _betterPlayerController!.setupDataSource(dataSource);
  // }

  @override
  void initState() {
    // video_code();
    // better_player_code();
    super.initState();
  }

  @override
  void dispose() {
    // _videoPlayerController!.dispose();
    // _betterPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          decoration: Common_decoration(),
          height: MediaQuery
              .of(context)
              .size
              .height,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorUtils.primary_gold,
              ),
            ),
            title: Text(
              Textutils.appName,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
            ),
            centerTitle: true,
            actions: [
              GestureDetector(
                onTap: (){
                  Get.to(SubscriptionScreen());

                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 30),
                  child: Text(
                    'Skip',
                    textAlign: TextAlign.center,
                    style:
                    FontStyleUtility.h14(fontColor: Colors.white, family: 'PR'),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(left: 20, right: 20, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: Text(
                      'Welcome video',
                      style: FontStyleUtility.h15(
                          fontColor: ColorUtils.primary_grey, family: 'PM'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Container(
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
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: screenHeight / 3.5,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    child: Image.asset(AssetUtils.video_img),
                                  ),
                                  Container(
                                    color: HexColor('#E1C26B').withOpacity(0.5),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: FractionalOffset.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.black),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.play_arrow,
                                        color: ColorUtils.primary_gold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(12),
                          //   child: AspectRatio(
                          //     aspectRatio: 16 / 9,
                          //     child: BetterPlayer(
                          //         controller: _betterPlayerController!),
                          //   ),
                          // ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 29),
                            child: common_button_gold(
                              onTap: () {
                                Get.to(SubscriptionScreen());
                              },
                              title_text: 'Done',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
}
