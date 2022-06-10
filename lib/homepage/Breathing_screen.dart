import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Dashboard/dashboard_screen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({Key? key}) : super(key: key);

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;

  String elapsedTime = '00';

  updateTime(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          percent += 1;
          if (percent >= 100) {
            percent = 0.0;
          }
        });
      }
    }
  }

  double percent = 0.0;
  bool back_wallpaper = false;

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 3);

  void startTimer() {
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
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }

  AnimationController? _animationController;
  Animation? _animation;
  bool animation_started = false;
  String _status = 'Hold';

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animationController!.forward();
    setState(() {
      _status = 'Inhale';
      print(_status);
    });
    _animation = Tween(begin: 150.0, end: 170.0).animate(_animationController!)
      ..addStatusListener((status) {
        print(status);
        if (status == AnimationStatus.completed) {
          setState(() {
            _status = 'Hold';
            print(_status);
          });
          Future.delayed(Duration(seconds: 4), () {
            _animationController!.reverse();
            setState(() {
              _status = 'Exhale';
              print(_status);
            });
          });
        }
        else if (status == AnimationStatus.dismissed) {
          setState(() {
            _status = 'Hold';
            print(_status);
          });
          Future.delayed(Duration(seconds: 4), () {
            _animationController!.forward();
            setState(() {
              _status = 'Inhale';
              print(_status);
            });
          });
        }

      });


    print(_animationController!.status);
  }

  @override
  dispose() {
    _animationController!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Colors.black.withOpacity(0.5), BlendMode.dst),
              image: AssetImage(
                AssetUtils.b_screen_back,
              ),
            ),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Text(
              Textutils.breathing,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
            ),
            centerTitle: true,
            actions: [
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.notifications_none_rounded,
              //       color: ColorUtils.primary_gold,
              //     ))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  // CircularPercentIndicator(
                  //   circularStrokeCap: CircularStrokeCap.round,
                  //   percent: percent / 100,
                  //   animation: true,
                  //   animateFromLastPercent: true,
                  //   radius: 67,
                  //   lineWidth: 0,
                  //   progressColor: Colors.white,
                  //   backgroundColor: Colors.transparent,
                  //   center: Container(
                  //     decoration: BoxDecoration(
                  //         border: Border.all(color: ColorUtils.primary_gold, width: 10),
                  //         borderRadius: BorderRadius.circular(100)),
                  //     child: Container(
                  //       height: 130,
                  //       width: 130,
                  //       decoration: BoxDecoration(
                  //           color: ColorUtils.primary_gold,
                  //           border: Border.all(color: Colors.black, width: 10),
                  //           borderRadius: BorderRadius.circular(100)),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           IconButton(
                  //             alignment: Alignment.center,
                  //             // visualDensity:
                  //             //     VisualDensity(vertical: -4, horizontal: -4),
                  //             padding: EdgeInsets.only(left: 0.0),
                  //             icon: Image.asset(AssetUtils.breathe_icon,
                  //                 color:
                  //                 Colors.black,
                  //                 height: 40,
                  //                 width: 40),
                  //             onPressed: () {
                  //
                  //             },
                  //           ),
                  //           Container(
                  //             alignment: Alignment.center,
                  //             child: CircleAvatar(
                  //               maxRadius: 20,
                  //               backgroundColor: Colors.black,
                  //               child: Text(
                  //                 elapsedTime,
                  //                 style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontSize: 20,
                  //                     fontFamily: 'PR',
                  //                     fontWeight: FontWeight.w900),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //
                  // ),

                  Container(
                    height: (animation_started? _animation!.value : 150),
                    width: (animation_started ? _animation!.value : 150),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorUtils.primary_gold, width: 10),
                        borderRadius: BorderRadius.circular(100)),
                    child: Container(
                       decoration: BoxDecoration(
                          color: ColorUtils.primary_gold,
                          border: Border.all(color: Colors.black, width: 10),
                          borderRadius: BorderRadius.circular(100)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // IconButton(
                          //   alignment: Alignment.center,
                          //   // visualDensity:
                          //   //     VisualDensity(vertical: -4, horizontal: -4),
                          //   padding: EdgeInsets.only(left: 0.0),
                          //   icon: Image.asset(AssetUtils.breathe_icon,
                          //       color: Colors.black, height: 40, width: 40),
                          //   onPressed: () {},
                          // ),
                          Text(_status,style: FontStyleUtility.h18(fontColor: Colors.black,family: 'PSB'),),
                          Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              maxRadius: 20,
                              backgroundColor: Colors.black,
                              child: Text(
                                elapsedTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'PR',
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:15),
                  Container(
                    decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.58),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            // stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              HexColor("#020204").withOpacity(0.8),
                              // HexColor("#151619").withOpacity(0.63),
                              HexColor("#36393E").withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal:8 ),
                      child: Column(
                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  // Get.to(SignUpScreen());
                                },
                                child: Container(
                                  height: 50,
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
                                          offset: Offset(10,10),
                                          blurRadius: 20,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10)),

                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(),
                                      child: Text(
                                        'Breathing information',
                                        style: FontStyleUtility.h15(
                                            fontColor: HexColor('#AAAAAA'), family: 'PM'),
                                      )),
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.65),
                                  //   gradient: LinearGradient(
                                  //     begin: Alignment.centerLeft,
                                  //     end: Alignment.centerRight,
                                  //     // stops: [0.1, 0.5, 0.7, 0.9],
                                  //     colors: [
                                  //       HexColor("#020204").withOpacity(1),
                                  //       HexColor("#36393E").withOpacity(1),
                                  //     ],
                                  //   ),
                                  //   boxShadow: [
                                  //     BoxShadow(
                                  //       color: HexColor('#04060F'),
                                  //       offset: Offset(10,10),
                                  //       blurRadius: 20,
                                  //     ),
                                  //   ],
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 17,vertical: 24),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          '1. Inhale 3',
                                          style: FontStyleUtility.h15(
                                              fontColor: HexColor('#DCDCDC'), family: 'PR'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Container(
                                        child: Text(
                                          '2. Hold 4 sec',
                                          style: FontStyleUtility.h15(
                                              fontColor: HexColor('#DCDCDC'), family: 'PR'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Container(
                                        child: Text(
                                          '3. Exhale 3 sec',
                                          style: FontStyleUtility.h15(
                                              fontColor: HexColor('#DCDCDC'), family: 'PR'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 17,
                                      ),
                                      Container(
                                        child: Text(
                                          '4. Repeat process 10 times is consider 1 set',
                                          style: FontStyleUtility.h15(
                                              fontColor: HexColor('#DCDCDC'), family: 'PR'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              startOrStop();

                            },
                            child: Container(
                              height: 65,
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
                                  boxShadow: [
                                    BoxShadow(
                                      color: HexColor('#04060F'),
                                      offset: Offset(10,10),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    (startStop ? 'Start' : 'Finish'),
                                    style: FontStyleUtility.h16(
                                        fontColor: Colors.black, family: 'PM'),
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 80,)

                ],
              ),
            ),
          ),
        ),
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
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      animation_started = false;
      _animationController!.dispose();
      watch.stop();
      percent = 0.0;
      setTime();
    });
  }

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
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
}
