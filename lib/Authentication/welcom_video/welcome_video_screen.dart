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
            leading:  GestureDetector(
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
            title: Container(
              child: Container(
                  height: 40,
                  width: 170,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  child: Image.asset(AssetUtils.Logo_white_icon)),
            ),
            // Text(
            //   Textutils.appName,
            //   style: FontStyleUtility.h16(
            //       fontColor: ColorUtils.primary_grey, family: 'PM'),
            // ),
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
                    margin: const EdgeInsets.symmetric(vertical: 45),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: screenHeight / 4,
                                          width: screenWidth/1.3,
                                          child:
                                          Image.asset(AssetUtils.video_img,fit: BoxFit.fitWidth,),
                                        ),
                                        Container(
                                          child: Container(
                                            width: screenWidth/1.3,
                                            height: screenHeight / 4,
                                            color: HexColor('#000000')
                                                .withOpacity(0.65),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap:
                                      () {
                                    Navigator.pop(
                                        context);
                                  },
                                  child:
                                  Container(
                                    height: screenHeight / 4,
                                    width: screenWidth/1.3,
                                    margin: EdgeInsets.only(
                                        left:
                                        10,bottom: 10),
                                    alignment:
                                    Alignment.topRight,
                                    child:
                                    Container(
                                        decoration:
                                        BoxDecoration(
                                          // color: Colors.black.withOpacity(0.65),
                                            gradient:
                                            LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              // stops: [0.1, 0.5, 0.7, 0.9],
                                              colors: [
                                                HexColor("#36393E").withOpacity(1),
                                                HexColor("#020204").withOpacity(1),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)
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
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: FractionalOffset.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: ColorUtils.primary_gold),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                              ],
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
