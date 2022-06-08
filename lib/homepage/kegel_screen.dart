import 'package:avatar_glow/avatar_glow.dart';
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

class KegelScreen extends StatefulWidget {
  const KegelScreen({Key? key}) : super(key: key);

  @override
  State<KegelScreen> createState() => _KegelScreenState();
}

class _KegelScreenState extends State<KegelScreen>
    with SingleTickerProviderStateMixin {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00:00';

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

  start_animation() {
    setState((){
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 15.0)
        .animate(_animationController!)
        ..addListener(() {
    });
  }
  @override
  dispose() {
    _animationController!.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds.remainder(60);

    return Stack(
      children: [
        Container(
          color: Colors.black,
          height: MediaQuery
              .of(context)
              .size
              .height,
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
              ? BoxDecoration(
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
                AssetUtils.k_screen_back,
              ),
            ),
          )
              : BoxDecoration()),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
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
              Textutils.kegel,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
            ),
            centerTitle: true,
            actions: [
              Container(
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
                      AssetUtils.notification_icon,
                      color: ColorUtils.primary_gold,
                      height: 14,
                      width: 15,
                    ),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(
                    height: 15,
                  ),
                  AvatarGlow(
                    endRadius: 100.0,
                    showTwoGlows: true,
                    animate: false,
                    // (startStop ? false : true),
                    duration: Duration(milliseconds: 900),
                    repeat: true,
                    child: GestureDetector(
                      onTap: () {
                        print('helllllllooooooooooooooo');
                        startOrStop();
                      },
                      child: CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        percent: percent / 100,
                        animation: true,
                        animateFromLastPercent: true,
                        radius: 61,
                        lineWidth: 0,
                        progressColor: Colors.white,
                        backgroundColor: Colors.transparent,
                        center: Container(
                          height: 125,
                          width: 125,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(AssetUtils.home_button)),
                              boxShadow: [
                                BoxShadow(
                                    color: HexColor('#E64A9B'),
                                    blurRadius: (animation_started?_animation!.value : 0),
                                    spreadRadius: (animation_started ?_animation!.value: 0),
                                )
                              ]),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'K',
                                  style: TextStyle(
                                      color:
                                      HexColor('#E64A9B').withOpacity(0.4),
                                      fontSize: 70,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  ('$seconds' == '3'
                                      ? 'Ready'
                                      : ('$seconds' == '2'
                                      ? 'Set'
                                      : ('$seconds' == '1'
                                      ? 'Kegel'
                                      : elapsedTime))),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    glowColor: Colors.white,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (started) {
                        startTimer();
                        Future.delayed(Duration(seconds: 3), () {
                          start_animation();
                          startWatch();
                        });
                      } else {
                        await stopWatch_finish();
                        setState(() {
                          elapsedTime = '00:00';
                          percent = 0.0;
                          back_wallpaper = true;
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Kegel Info',
                            style: FontStyleUtility.h16(
                                fontColor: HexColor('#F2F2F2'), family: 'PR'),
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
                                  'Sample text regarding Kegel info',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PR'),
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                child: Text(
                                  'Sample text regarding Kegel info',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PR'),
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                child: Text(
                                  'Sample text regarding Kegel info',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PR'),
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                child: Text(
                                  'Sample text regarding Kegel info',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
                                      family: 'PR'),
                                ),
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Container(
                                child: Text(
                                  'Sample text regarding Kegel info',
                                  style: FontStyleUtility.h16(
                                      fontColor: ColorUtils.primary_grey,
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
    setState(() {
      startStop = false;
      started = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
    });
  }

  stopWatch() {
    setState(() {
      startStop = true;
      started = false;
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

    // return "$hoursStr:$minutesStr:$secondsStr";
    return "$minutesStr:$secondsStr";
  }
}
