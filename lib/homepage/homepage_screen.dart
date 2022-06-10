import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/homepage/pee_screen.dart';
import 'package:klench_/homepage/swipe_screen.dart';
import 'package:klench_/homepage/warmpUp_screen.dart';

import '../front_page/FrontpageScreen.dart';
import '../notifications/notifications_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';
import 'kegel_screen.dart';
import 'm_screen.dart';
import 'm_screen_metal.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenHeight);
    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   // stops: [0.1, 0.5, 0.7, 0.9],
            //   colors: [
            //     HexColor("#000000").withOpacity(0.86),
            //     HexColor("#000000").withOpacity(0.81),
            //     HexColor("#000000").withOpacity(0.44),
            //     HexColor("#000000").withOpacity(1),
            //
            //   ],
            // ),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              image: AssetImage(
                AssetUtils.home_back,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Container(
                alignment: Alignment.center,
                child: Container(
                    width: 170,
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Image.asset(AssetUtils.Logo_white_icon)),
              ),
              centerTitle: true,
              actions: [
                // GestureDetector(
                //   onTap: (){
                //     Get.to(NotificationsScreen());
                //   },
                //   child: Container(
                //       width: 41,
                //       margin: EdgeInsets.all(8),
                //       decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.circular(100),
                //           gradient: LinearGradient(
                //               begin: Alignment(-1.0, -4.0),
                //               end: Alignment(1.0, 4.0),
                //               colors: [
                //                 HexColor('#020204'),
                //                 HexColor('#36393E')
                //               ])),
                //       child: Padding(
                //         padding: const EdgeInsets.all(10.0),
                //         child: Image.asset(
                //           AssetUtils.notification_icon,
                //           color: ColorUtils.primary_gold,
                //           height: 22,
                //           width: 18,
                //         ),
                //       )),
                // )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        margin: EdgeInsets.all(0),
                        alignment: Alignment.topCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              AssetUtils.star_icon,
                              height: 22,
                              width: 22,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Image.asset(
                              AssetUtils.star_icon,
                              height: 22,
                              width: 22,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Image.asset(
                              AssetUtils.star_icon,
                              height: 22,
                              width: 22,
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: (screenHeight >= 600 && screenHeight <= 700
                              ? 10
                              : (screenHeight >= 700 && screenHeight <= 800
                                  ? 75
                                  : (screenHeight >= 800 ? 100 : 0)))),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Get.to(KegelScreen());
                              final int page_no = 0;
                              Get.to(SwipeScreen(PageNo: page_no,));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 0),
                              height: 140,
                              width: 140,
                              // decoration: BoxDecoration(
                              //   gradient: RadialGradient(
                              //     center: const Alignment(0.0, 0.0),
                              //     radius: 0.5,
                              //     colors: [
                              //       ColorUtils.color1,
                              //       HexColor('#BF2777'),
                              //     ],
                              //   ),
                              //   boxShadow: [
                              //     BoxShadow(
                              //         color: ColorUtils.primary_grey
                              //             .withOpacity(0.5),
                              //         blurRadius: 5,
                              //         offset: Offset(0, 5))
                              //   ],
                              //   borderRadius: BorderRadius.circular(100),
                              // ),
                              child: Container(
                                height: 140,
                                width: 135,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      alignment: Alignment.center,
                                      image:
                                          AssetImage(AssetUtils.home_button)),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text('K',
                                      style: GoogleFonts.sourceSerifPro(
                                        textStyle: TextStyle(
                                            color: HexColor('#EE499E'),
                                            shadows: [
                                              Shadow(
                                                  color: HexColor('#EE499E'),
                                                  offset: Offset(0, 10),
                                                  blurRadius: 50)
                                            ],
                                            fontSize: 64,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final int page_no = 1;
                                  Get.to(SwipeScreen(PageNo: page_no,));

                                },
                                child: Container(
                                  height: 140,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        alignment: Alignment.center,
                                        image:
                                            AssetImage(AssetUtils.home_button)),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('W',
                                        style: GoogleFonts.sourceSerifPro(
                                          textStyle: TextStyle(
                                              color: HexColor('#3EA244'),
                                              shadows: [
                                                Shadow(
                                                    color: HexColor('#3EA244'),
                                                    offset: Offset(0, 10),
                                                    blurRadius: 50)
                                              ],
                                              fontSize: 64,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              GestureDetector(
                                onTap: () {
                                  final int page_no =2;
                                  Get.to(SwipeScreen(PageNo: page_no,));
                                },
                                child: Container(
                                  height: 140,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        alignment: Alignment.center,
                                        image:
                                            AssetImage(AssetUtils.home_button)),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('M',
                                        style: GoogleFonts.sourceSerifPro(
                                          textStyle: TextStyle(
                                              color: HexColor('#ED4A42'),
                                              shadows: [
                                                Shadow(
                                                    color: HexColor('#ED4A42'),
                                                    offset: Offset(0, 10),
                                                    blurRadius: 50)
                                              ],
                                              fontSize: 64,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              final int page_no = 3;
                              Get.to(SwipeScreen(PageNo: page_no,));
                              },
                            child: Container(
                              height: 140,
                              width: 135,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    alignment: Alignment.center,
                                    image: AssetImage(AssetUtils.home_button)),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text('P',
                                    style: GoogleFonts.sourceSerifPro(
                                      textStyle: TextStyle(
                                          color: HexColor('#F8D44D'),
                                          shadows: [
                                            Shadow(
                                                color: HexColor('#F8D44D'),
                                                offset: Offset(0, 10),
                                                blurRadius: 50)
                                          ],
                                          fontSize: 64,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Container(
            //           margin: EdgeInsets.all(0),
            //           alignment: Alignment.topCenter,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               Image.asset(
            //                 AssetUtils.star_icon,
            //                 height: 22,
            //                 width: 22,
            //               ),
            //               SizedBox(
            //                 width: 7,
            //               ),
            //               Image.asset(
            //                 AssetUtils.star_icon,
            //                 height: 22,
            //                 width: 22,
            //               ),
            //               SizedBox(
            //                 width: 7,
            //               ),
            //               Image.asset(
            //                 AssetUtils.star_icon,
            //                 height: 22,
            //                 width: 22,
            //               ),
            //             ],
            //           )),
            //
            //
            //       Container(
            //         margin: EdgeInsets.symmetric(vertical: 100),
            //         child: Column(
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Get.to(KegelScreen());
            //               },
            //               child: Container(
            //                   margin: EdgeInsets.only(top: 0),
            //                   height: 140,
            //                   width: 140,
            //                   // decoration: BoxDecoration(
            //                   //   gradient: RadialGradient(
            //                   //     center: const Alignment(0.0, 0.0),
            //                   //     radius: 0.5,
            //                   //     colors: [
            //                   //       ColorUtils.color1,
            //                   //       HexColor('#BF2777'),
            //                   //     ],
            //                   //   ),
            //                   //   boxShadow: [
            //                   //     BoxShadow(
            //                   //         color: ColorUtils.primary_grey
            //                   //             .withOpacity(0.5),
            //                   //         blurRadius: 5,
            //                   //         offset: Offset(0, 5))
            //                   //   ],
            //                   //   borderRadius: BorderRadius.circular(100),
            //                   // ),
            //                   child: Container(
            //                     height: 140,
            //                     width: 135,
            //                     decoration: BoxDecoration(
            //                       image: DecorationImage(
            //                           alignment: Alignment
            //                               .center,
            //                           image: AssetImage(AssetUtils.home_button)),
            //                     ),
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       child: Text('K',
            //                           style: GoogleFonts.sourceSerifPro(
            //                             textStyle: TextStyle(
            //                                 color: HexColor('#EE499E'),
            //                                 shadows: [
            //                                   Shadow(
            //                                       color: HexColor('#EE499E'),
            //                                       offset: Offset(0,10),
            //                                       blurRadius: 30
            //                                   )
            //                                 ],
            //                                 fontSize: 64,
            //                                 fontWeight: FontWeight.w600),
            //                           )),
            //                     ),
            //                   ),
            //               ),
            //             ),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 GestureDetector(
            //                   onTap: () {
            //                     Get.to(WarmUpScreen());
            //                   },
            //                   child: Container(
            //                     height: 140,
            //                     width: 135,
            //                     decoration: BoxDecoration(
            //                       image: DecorationImage(
            //                           alignment: Alignment
            //                               .center,
            //                           image: AssetImage(AssetUtils.home_button)),
            //                     ),
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       child: Text('W',
            //                           style: GoogleFonts.sourceSerifPro(
            //                             textStyle: TextStyle(
            //                                 color: HexColor('#3EA244'),
            //                                 shadows: [
            //                                   Shadow(
            //                                       color: HexColor('#3EA244'),
            //                                       offset: Offset(0,10),
            //                                       blurRadius: 30
            //                                   )
            //                                 ],
            //                                 fontSize: 64,
            //                                 fontWeight: FontWeight.w600),
            //                           )),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   width: 70,
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     Get.to(M_ScreenMetal());
            //                   },
            //                   child: Container(
            //                     height: 140,
            //                     width: 135,
            //                     decoration: BoxDecoration(
            //                       image: DecorationImage(
            //                           alignment: Alignment
            //                               .center,
            //                           image: AssetImage(AssetUtils.home_button)),
            //                     ),
            //                     child: Container(
            //                       alignment: Alignment.center,
            //                       child: Text('M',
            //                           style: GoogleFonts.sourceSerifPro(
            //                             textStyle: TextStyle(
            //                                 color: HexColor('#ED4A42'),
            //                                 shadows: [
            //                                   Shadow(
            //                                       color: HexColor('#ED4A42'),
            //                                       offset: Offset(0,10),
            //                                       blurRadius: 30
            //                                   )
            //                                 ],
            //                                 fontSize: 64,
            //                                 fontWeight: FontWeight.w600),
            //                           )),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             GestureDetector(
            //               onTap: () {
            //                 Get.to(PeeScreen());
            //               },
            //               child: Container(
            //                 height: 140,
            //                 width: 135,
            //                 decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                       alignment: Alignment
            //                           .center,
            //                       image: AssetImage(AssetUtils.home_button)),
            //                 ),
            //                 child: Container(
            //                   alignment: Alignment.center,
            //                   child: Text('P',
            //                       style: GoogleFonts.sourceSerifPro(
            //                         textStyle: TextStyle(
            //                             color: HexColor('#F8D44D'),
            //                             shadows: [
            //                               Shadow(
            //                                   color: HexColor('#F8D44D'),
            //                                   offset: Offset(0,10),
            //                                   blurRadius: 30
            //                               )
            //                             ],
            //                             fontSize: 64,
            //                             fontWeight: FontWeight.w600),
            //                       )),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //
            //
            //     ],
            //   ),
            // ),
          ),
        ),
      ],
    );
  }
}
