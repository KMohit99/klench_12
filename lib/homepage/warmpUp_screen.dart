import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/main.dart';
import 'package:klench_/utils/TexrUtils.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import 'alarm_info.dart';

class WarmUpScreen extends StatefulWidget {
  const WarmUpScreen({Key? key}) : super(key: key);

  @override
  State<WarmUpScreen> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen>
    with TickerProviderStateMixin {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';
  double percent = 0.0;
  bool four_started = false;

  updateTime(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);

          if (elapsedTime == '11') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'HOLD';
              percent = 0.0;
              watch.reset();
              four_started = true;
            });
            startWatch2();

            Future.delayed(Duration(seconds: 11), () {
              // if (counter == 10) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     // watch.stop();
              //     counter = 0;
              //   });
              // sets++;
              // print('Sets-------$sets');
              // if (sets == 3) {
              //   stopWatch_finish();
              //   setState(() {
              //     elapsedTime = '00';
              //     percent = 0.0;
              //     // watch.stop();
              //     counter = 0;
              //   });
              //   CommonWidget().showToaster(msg: "Method Complete");
              //   Future.delayed(Duration(seconds: 5), () {
              //     CommonWidget().showErrorToaster(
              //         msg:
              //         "After one month it will automatically switch to Hard");
              //   });
              // }
              // } else {
              _animationController!.forward();
              _animationController_button!.forward();
              setState(() {
                elapsedTime = '00';
                four_started = false;
                watch.reset();
              });
              startTimer2();
              startWatch();

              // startWatch();
              // }
            });
          }
        });
      }
    }
  }

  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 3);
  bool timer_started = false;
  Timer? countdownTimer2;
  Duration myDuration2 = Duration(seconds: 10);
  bool reverse_started = false;

  void startTimer() {
    setState(() {
      timer_started = true;
    });
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          print('timesup');
          startWatch();

        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }
  void startTimer2() {
    setState(() {
      reverse_started = true;
    });
    countdownTimer2 =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown2());
  }

  void setCountDown2() {
    final reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration2.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer2!.cancel();
          reverse_started = false;
          print('timesup');
        } else {
          myDuration2 = Duration(seconds: seconds);
        }
      });
    }
  }

  AnimationController? _animationController;
  Animation? _animation;

  AnimationController? _animationController_button;
  Animation? _animation_button;

  // AnimationController? _animationController_textK;
  Animation? _animation_textK;

  // AnimationController? _animationController_textTime;
  Animation? _animation_textTime;

  bool animation_started = false;
  double button_height = 200;
  double text_k_size = 100;
  double text_time_size = 35;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 65.0).animate(_animationController!)
      ..addListener(() {});

    _animationController_button =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController_button!.forward();
    _animation_button =
        Tween(begin: 200.0, end: 150.0).animate(_animationController_button!)
          ..addStatusListener((status) {
            // print(status);
            // if (status == AnimationStatus.completed) {
            //   setState(() {});
            //   _animationController_button!.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   setState(() {});
            //   _animationController_button!.forward();
            // }
          });

    // _animationController_textK =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textK!.forward();
    _animation_textK =
        Tween(begin: 100.0, end: 70.0).animate(_animationController_button!)
          ..addStatusListener((status) {
            // print(status);
            // if (status == AnimationStatus.completed) {
            //   setState(() {});
            //   _animationController_button!.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   setState(() {});
            //   _animationController_button!.forward();
            // }
          });

    // _animationController_textTime =
    //     AnimationController(vsync: this, duration: Duration(seconds: 5));
    // _animationController_textTime!.forward();
    _animation_textTime =
        Tween(begin: 40.0, end: 25.0).animate(_animationController_button!)
          ..addStatusListener((status) {
            // print(status);
            // if (status == AnimationStatus.completed) {
            //   setState(() {});
            //   _animationController_button!.reverse();
            // } else if (status == AnimationStatus.dismissed) {
            //   setState(() {});
            //   _animationController_button!.forward();
            // }
          });
  }

  AnimationController? _animationController_middle;
  Animation? _animation_middle;
  bool animation_started_middle = false;
  Animation? _animation_middle2;
  Animation? _animation_middle3;
  Animation? _animation_middle4;

  middle_animation() {
    setState(() {
      animation_started_middle = true;
    });
    _animationController_middle = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animationController_middle!.forward();
    _animation_middle =
        Tween(begin: 15.0, end: 50.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle2 =
        Tween(begin: 15.0, end: 40.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle3 =
        Tween(begin: 15.0, end: 120.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");
            // shadow_animation1_completed = true;
          });
    _animation_middle4 =
        Tween(begin: 15.0, end: 100.0).animate(_animationController_middle!)
          ..addStatusListener((status) {
            print("status $status");

            // shadow_animation1_completed = true;
          });
  }

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose();
      _animationController_button!.dispose();
    }
    if (animation_started_middle == true) {
      _animationController_middle!.dispose();
    }
// you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds.remainder(60);
    final seconds2 = myDuration2.inSeconds.remainder(60);
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
          // decoration: BoxDecoration(
          //
          //   image: DecorationImage(
          //     image: AssetImage(AssetUtils.backgroundImage), // <-- BACKGROUND IMAGE
          //     fit: BoxFit.cover,
          //   ),
          // ),
          decoration: (back_wallpaper
              ? const BoxDecoration(
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
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AssetUtils.w_screen_back,
                    ),
                  ),
                )
              : BoxDecoration()),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   automaticallyImplyLeading: false,
            //   leading: GestureDetector(
            //     onTap: () {
            //
            //       (started
            //           ? Navigator.pop(context)
            //           : CommonWidget().showErrorToaster(msg: "Please finish the method"));
            //       },
            //     child: Container(
            //         width: 41,
            //         margin: EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(100),
            //             gradient: LinearGradient(
            //                 begin: Alignment(-1.0, -4.0),
            //                 end: Alignment(1.0, 4.0),
            //                 colors: [HexColor('#020204'), HexColor('#36393E')])),
            //         child: Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: Image.asset(
            //             AssetUtils.arrow_back,
            //             height: 14,
            //             width: 15,
            //           ),
            //         )),
            //   ),
            //   title: Text(
            //     Textutils.warmup,
            //     style: FontStyleUtility.h16(
            //         fontColor: ColorUtils.primary_grey, family: 'PM'),
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     // Container(
            //     //     width: 41,
            //     //     margin: EdgeInsets.all(8),
            //     //     decoration: BoxDecoration(
            //     //         color: Colors.white,
            //     //         borderRadius: BorderRadius.circular(100),
            //     //         gradient: LinearGradient(
            //     //             begin: Alignment(-1.0, -4.0),
            //     //             end: Alignment(1.0, 4.0),
            //     //             colors: [HexColor('#020204'), HexColor('#36393E')])),
            //     //     child: Padding(
            //     //       padding: const EdgeInsets.all(10.0),
            //     //       child: Image.asset(
            //     //         AssetUtils.notification_icon,
            //     //         color: ColorUtils.primary_gold,
            //     //         height: 14,
            //     //         width: 15,
            //     //       ),
            //     //     ))
            //   ],
            // ),
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    snap: false,
                    pinned: false,
                    stretch: false,
                    floating: false,
                    leading: GestureDetector(
                      onTap: () {
                        (started
                            ? Navigator.pop(context)
                            : CommonWidget().showErrorToaster(
                                msg: "Please finish the method"));
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
                                  colors: [
                                    HexColor('#020204'),
                                    HexColor('#36393E')
                                  ])),
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
                      Textutils.warmup,
                      style: FontStyleUtility.h16(
                          fontColor: ColorUtils.primary_grey, family: 'PM'),
                    ),
                    centerTitle: true,
                    actions: [
                      // Container(
                      //     width: 41,
                      //     margin: EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(100),
                      //         gradient: LinearGradient(
                      //             begin: Alignment(-1.0, -4.0),
                      //             end: Alignment(1.0, 4.0),
                      //             colors: [HexColor('#020204'), HexColor('#36393E')])),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(10.0),
                      //       child: Image.asset(
                      //         AssetUtils.notification_icon,
                      //         color: ColorUtils.primary_gold,
                      //         height: 14,
                      //         width: 15,
                      //       ),
                      //     ))
                    ],
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   height: (animation_started_middle ? _animation_middle!.value : 15),
                      // ),
                      Container(
                        height: (screenHeight >= 600 && screenHeight <= 700
                            ? (animation_started_middle
                                ? _animation_middle2!.value
                                : 15)
                            : (screenHeight >= 700 && screenHeight <= 800
                                ? (animation_started_middle
                                    ? _animation_middle!.value
                                    : 15)
                                : (screenHeight >= 800 && screenHeight <= 850
                                    ? (animation_started_middle
                                        ? _animation_middle4!.value
                                        : 15)
                                    : (screenHeight >= 850
                                        ? (animation_started_middle
                                            ? _animation_middle3!.value
                                            : 15)
                                        : 0)))),
                      ),

                      Container(
                        child: AvatarGlow(
                          endRadius: 170.0,
                          showTwoGlows: true,
                          animate: false,
                          // (startStop ? false : true),
                          duration: Duration(milliseconds: 900),
                          repeat: true,
                          child: GestureDetector(
                            onTap: () {
                              print('helllllllooooooooooooooo');
                              // startOrStop();
                            },
                            child: Stack(
                              alignment: Alignment.center,

                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                      boxShadow: [
                                        BoxShadow(
                                          color: (animation_started
                                              ? HexColor('#409C46')
                                              : Colors.transparent),
                                          blurRadius: (animation_started
                                              ? _animation!.value
                                              : 0),
                                          spreadRadius: (animation_started
                                              ? _animation!.value
                                              : 0),
                                        )
                                      ]),
                                ),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 340,
                                    width: 340,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 330,
                                    width: 330,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 320,
                                    width: 320,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 310,
                                    width: 310,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 300,
                                    width: 300,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 290,
                                    width: 290,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 280,
                                    width: 280,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 270,
                                    width: 270,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 260,
                                    width: 260,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 250,
                                    width: 250,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 240,
                                    width: 240,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 230,
                                    width: 230,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 220,
                                    width: 220,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 210,
                                    width: 210,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 190,
                                    width: 190,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 180,
                                    width: 180,
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 170,
                                    width: 170,
                                    padding: EdgeInsets.all(5),
                                  ),
                                )
                                    : SizedBox.shrink()),
                                (animation_started
                                    ? DottedBorder(
                                  borderType: BorderType.Circle,
                                  strokeWidth: 3,
                                  dashPattern: [0, 10],
                                  strokeCap: StrokeCap.round,
                                  radius: Radius.circular(100),
                                  padding: EdgeInsets.all(0),
                                  color: Colors.black,
                                  child: Container(
                                    height: 160,
                                    width: 160,
                                    padding: EdgeInsets.all(5),
                                  ),
                                )
                                    : SizedBox.shrink()),

                                Container(
                                  height: (animation_started
                                      ? _animation_button!.value
                                      : button_height),
                                  width: (animation_started
                                      ? _animation_button!.value
                                      : button_height),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          alignment: Alignment.center,
                                          image:
                                          AssetImage(AssetUtils.home_button)),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: (animation_started
                                      //         ? HexColor('#409C46')
                                      //         : Colors.transparent),
                                      //     blurRadius: (animation_started
                                      //         ? _animation!.value
                                      //         : 0),
                                      //     spreadRadius: (animation_started
                                      //         ? _animation!.value
                                      //         : 0),
                                      //   )
                                      // ]
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'W',
                                          style: TextStyle(
                                              color: HexColor('#409C46')
                                                  .withOpacity(0.4),
                                              fontSize: (animation_started
                                                  ? _animation_textK!.value
                                                  : text_k_size),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child:(four_started
                                            ? Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "HOLD",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: (animation_started
                                                      ? _animation_textTime!
                                                      .value
                                                      : text_time_size),
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Text(
                                              elapsedTime,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: (animation_started
                                                      ? _animation_textTime!
                                                      .value
                                                      : text_time_size),
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ],
                                        )
                                            : Text(
                                          (reverse_started ? '$seconds2' :
                                          (timer_started
                                              ? ('$seconds' == '3'
                                              ? 'Ready'
                                              : ('$seconds' == '2'
                                              ? 'Set'
                                              : ('$seconds' == '1'
                                              ? 'WarmUp'
                                              : elapsedTime)))
                                              : '')),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: (animation_started
                                                  ? _animation_textTime!.value
                                                  : text_time_size),
                                              fontWeight: FontWeight.w900),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          glowColor: Colors.white,
                        ),
                      ),
                      // SizedBox(
                      //   height: 28,
                      // ),
                      Container(
                        height: (screenHeight >= 600 && screenHeight <= 700
                            ? (animation_started_middle
                                ? _animation_middle2!.value
                                : 15)
                            : (screenHeight >= 700 && screenHeight <= 800
                                ? (animation_started_middle
                                    ? _animation_middle!.value
                                    : 15)
                                : (screenHeight >= 800 && screenHeight <= 850
                                    ? (animation_started_middle
                                        ? _animation_middle4!.value
                                        : 15)
                                    : (screenHeight >= 850
                                        ? (animation_started_middle
                                            ? _animation_middle3!.value
                                            : 15)
                                        : 0)))),
                      ),

                      (timer_started
                          ? Column(
                            children: [
                              Row(
                        children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.red,
                                  child: ('$seconds' == '3'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Text(
                                              'Set',
                                              style:
                                              FontStyleUtility.h18(
                                                  fontColor: Colors
                                                      .transparent,
                                                  family: "PR"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 0.5)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                8.0),
                                            child: Text(
                                              'Ready',
                                              textAlign:
                                              TextAlign.center,
                                              style: FontStyleUtility.h22(
                                                  fontColor: ColorUtils
                                                      .primary_gold,
                                                  family: "PM"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : ('$seconds' == '2'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(8.0),
                                                child: Text(
                                                  'Ready',
                                                  style: FontStyleUtility
                                                      .h16(
                                                      fontColor:
                                                      Colors
                                                          .white,
                                                      family:
                                                      "PR"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(10),
                                              border: Border.all(
                                                  color:
                                                  Colors.white,
                                                  width: 0.5)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Text(
                                              'Set',
                                              textAlign:
                                              TextAlign.center,
                                              style: FontStyleUtility.h22(
                                                  fontColor: ColorUtils
                                                      .primary_gold,
                                                  family: "PM"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : ('$seconds' == '1'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: [
                                            Container(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .all(
                                                    8.0),
                                                child: Text(
                                                  'Set',
                                                  style: FontStyleUtility.h16(
                                                      fontColor:
                                                      Colors
                                                          .white,
                                                      family:
                                                      "PR"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10),
                                              border: Border.all(
                                                  color: Colors
                                                      .white,
                                                  width: 0.5)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(8.0),
                                            child: Text(
                                              'Squeeze',
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: FontStyleUtility.h22(
                                                  fontColor:
                                                  ColorUtils
                                                      .primary_gold,
                                                  family: "PM"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : (four_started
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .end,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: [
                                            Container(
                                              child:
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    4.0),
                                                child: Text(
                                                  'Set',
                                                  style: FontStyleUtility.h14(
                                                      fontColor: Colors
                                                          .transparent,
                                                      family:
                                                      "PR"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child:
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    4.0),
                                                child: Text(
                                                  'Squeeze',
                                                  style: FontStyleUtility.h16(
                                                      fontColor: Colors
                                                          .white,
                                                      family:
                                                      "PR"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10),
                                              border: Border.all(
                                                  color: Colors
                                                      .white,
                                                  width:
                                                  0.5)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(
                                                8.0),
                                            child: Text(
                                              'HOLD',
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: FontStyleUtility.h22(
                                                  fontColor:
                                                  ColorUtils
                                                      .primary_gold,
                                                  family:
                                                  "PM"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .end,
                                          children: [
                                            Container(
                                              child:
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    8.0),
                                                child: Text(
                                                  'Set',
                                                  style: FontStyleUtility.h16(
                                                      fontColor: Colors
                                                          .white,
                                                      family:
                                                      "PR"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  10),
                                              border: Border.all(
                                                  color: Colors
                                                      .white,
                                                  width:
                                                  0.5)),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets
                                                .all(
                                                8.0),
                                            child: Text(
                                              'Squeeze',
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: FontStyleUtility.h22(
                                                  fontColor:
                                                  ColorUtils
                                                      .primary_gold,
                                                  family:
                                                  "PM"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))))),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  // color: Colors.red,
                                  child: ('$seconds' == '3'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Set',
                                            style: FontStyleUtility.h16(
                                                fontColor: Colors.white,
                                                family: "PR"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : ('$seconds' == '2'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              8.0),
                                          child: Text(
                                            'Squeeze',
                                            style: FontStyleUtility
                                                .h16(
                                                fontColor:
                                                Colors
                                                    .white,
                                                family: "PR"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : ('$seconds' == '1'
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(8.0),
                                          child: Text(
                                            'Finish',
                                            style: FontStyleUtility
                                                .h16(
                                                fontColor:
                                                Colors
                                                    .white,
                                                family:
                                                "PR"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : (four_started
                                      ? Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(4.0),
                                          child: Text(
                                            'Ready',
                                            style: FontStyleUtility.h18(
                                                fontColor:
                                                Colors
                                                    .white,
                                                family:
                                                "PR"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .all(8.0),
                                          child: Text(
                                            'Finish',
                                            style: FontStyleUtility.h16(
                                                fontColor:
                                                Colors
                                                    .white,
                                                family:
                                                "PR"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))))),
                                ),
                              )
                        ],
                      ),
                              // Container(
                              //   // color: Colors.red,
                              //   child: ('$seconds' == '3'
                              //       ? SizedBox(
                              //       height : 40
                              //   )
                              //       : ('$seconds' == '2'
                              //       ? SizedBox(                                  height : 40
                              //   )
                              //       :('$seconds' == '1'?
                              //   Container(
                              //     child: Padding(
                              //       padding:
                              //       const EdgeInsets
                              //           .all(8.0),
                              //       child: Text(
                              //         'Squeeze',
                              //         textAlign:
                              //         TextAlign
                              //             .center,
                              //         style: FontStyleUtility.h16(
                              //             fontColor: Colors
                              //                 .white,
                              //             family:
                              //             "PR"),
                              //       ),
                              //     ),
                              //   )  : (four_started
                              //       ? Container(
                              //     height : 40,
                              //
                              //     child: Text(
                              //       'HOLD',
                              //       textAlign:
                              //       TextAlign
                              //           .center,
                              //       style: FontStyleUtility.h16(
                              //           fontColor: Colors.white,
                              //           family:
                              //           "PM"),
                              //     ),
                              //   )
                              //       : Container(
                              //     height : 40,
                              //     child: Padding(
                              //       padding:
                              //       const EdgeInsets
                              //           .all(8.0),
                              //       child: Text(
                              //         'Squeeze',
                              //         textAlign:
                              //         TextAlign
                              //             .center,
                              //         style: FontStyleUtility.h16(
                              //             fontColor: Colors
                              //                 .white,
                              //             family:
                              //             "PR"),
                              //       ),
                              //     ),
                              //   ) )))),
                              // ),
                            ],
                          )
                          : SizedBox(
                        height: 0,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (started) {
                            back_wallpaper = false;
                            // startTimer();
                            // startWatch();
                            middle_animation();
                            Future.delayed(const Duration(seconds: 1), () {
                              startTimer();
                            });
                            Future.delayed(const Duration(seconds: 4),
                                () async {
                              await startWatch();
                            });
                          } else {
                            await stopWatch_finish();
                            await click_alarm();
                            await _animationController_middle!.reverse();

                            setState(() {
                              timer_started = false;
                              elapsedTime = '00';
                              percent = 0.0;
                              back_wallpaper = true;
                              button_height = 150;
                              text_k_size = 70;
                              text_time_size = 25;
                              watch.reset();
                              // paused_time.clear();
                            });
                            // print('method_time : ${method_time[0].total_time}');
                            // print('method_name : ${method_time[0].method_name}');
                          }
                        },
                        child: Container(
                          height: 65,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          // height: 45,
                          // width:(width ?? 300) ,
                          decoration: BoxDecoration(
                              color: ColorUtils.primary_gold,
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#ECDD8F").withOpacity(0.90),
                                  HexColor("#E5CC79").withOpacity(0.90),
                                  HexColor("#CE952F").withOpacity(0.90),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                (started ? 'Start' : 'Finish'),
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
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
                                  blurRadius: 20)
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 8, left: 27),
                              child: Text(
                                'What to do before sex?',
                                style: FontStyleUtility.h16(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PR'),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 0, left: 27),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      'Sample text from admin ',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DCDCDC'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Container(
                                    child: Text(
                                      'Admin will put the text here',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DCDCDC'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Container(
                                    child: Text(
                                      'Sample text from admin',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DCDCDC'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                  Container(
                                    child: Text(
                                      'Admin will put the text here',
                                      style: FontStyleUtility.h16(
                                          fontColor: HexColor('#DCDCDC'),
                                          family: 'PR'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  startWatch() {
    start_animation();
    setState(() {
      startStop = false;
      started = false;
      watch.start();
      timer = Timer.periodic(Duration(microseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      started = false;
      animation_started = false;

      watch.stop();
      setTime();
    });
  }

  stopWatch_finish() {
    setState(() {
      startStop = true;
      started = true;
      animation_started = false;
      watch.stop();
      setTime_finish();
    });
  }

  startWatch2() {
    // start_animation();
    setState(() {
      startStop = false;
      started = false;
      elapsedTime = "00";
      watch.start();
      timer = Timer.periodic(
          const Duration(milliseconds: 100),
      updateTime);
    });
  }


  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    print("elapsedTime $elapsedTime");
  }

  setTime_finish() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    // paused_time.add(elapsedTime);
    print("elapsedTime $elapsedTime");
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return secondsStr;
  }

  DateTime? _alarmTime;

  Future<void> click_alarm() async {
    _alarmTime = DateTime.now();
    DateTime arch = DateTime.parse("2022-08-15 00:25:24");
    print(DateFormat('EEEE').format(arch)); // Sunday

    DateTime scheduleAlarmDateTime;
    // if (_alarmTime!.isAfter(DateTime.now())) {
    scheduleAlarmDateTime = DateTime.now().add(Duration(seconds: 3));
    // } else {
    //   scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    // }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: 1,
      title: "Would you like to do breathing exercises ?",
    );
    // _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    // Alarm_title.clear();
    // Navigator.pop(context);
    // loadAlarms();
  }

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound("a_long_cold_sting.wav"),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: "a_long_cold_sting.wav",
        presentAlert: true,
        presentBadge: true,
        threadIdentifier: 'thread_id',
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Klench Exercise',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
