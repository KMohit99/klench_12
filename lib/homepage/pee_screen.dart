import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class PeeScreen extends StatefulWidget {
  const PeeScreen({Key? key}) : super(key: key);

  @override
  State<PeeScreen> createState() => _PeeScreenState();
}

class _PeeScreenState extends State<PeeScreen> {

  List urine_test_text = [
    "Doing ok, you're probably well hydrated",
    "Sample text here regarding the urine",
    "Doing ok, you're probably well hydrated",
    "Sample text here regarding the urine",
    "Doing ok, you're probably well hydrated",
  ];
  List urint_test_color = [
    HexColor('#EEF1AC'),
    HexColor('#E4E247'),
    HexColor('#E5DF2B'),
    HexColor('#CC9D2C'),
    HexColor('#B7752A'),
  ];

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

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds.remainder(60);
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
          decoration: (back_wallpaper ?
          BoxDecoration(
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
                AssetUtils.p_screen_back,
              ),
            ),
          ) : BoxDecoration()),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
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
              Textutils.pee,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_gold, family: 'PM'),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: ColorUtils.primary_gold,
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                children: [
                  AvatarGlow(
                    endRadius: 100.0,
                    showTwoGlows: true,
                    animate: (startStop ? false : true),
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
                            image: DecorationImage(
                                alignment: Alignment.center,
                                image: AssetImage(AssetUtils.home_button)),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'K',
                                  style: TextStyle(
                                      color:
                                          HexColor('#F5C921').withOpacity(0.2),
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
                                              ? 'Pee'
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
                    height: 25,
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(20.0),
                  //   child: Column(
                  //     children: <Widget>[
                  //       Text(elapsedTime, style: TextStyle(fontSize: 25.0,color: Colors.white)),
                  //       SizedBox(height: 20.0),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           FloatingActionButton(
                  //               heroTag: "btn1",
                  //               backgroundColor: Colors.red,
                  //               onPressed: () => startOrStop(),
                  //               child: Icon(Icons.pause)),
                  //           SizedBox(width: 20.0),
                  //           FloatingActionButton(
                  //               heroTag: "btn2",
                  //               backgroundColor: Colors.green,
                  //               onPressed: null, //resetWatch,
                  //               child: Icon(Icons.check)),
                  //         ],
                  //       )
                  //     ],
                  //   ),
                  // ),

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
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: 15, left: 15, top: 15, bottom: 20),
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
                                    blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24, top: 14),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Dehydration urine color chart',
                                  style: FontStyleUtility.h16(
                                      fontColor: HexColor('#DFDFDF'),
                                      family: 'PR'),
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 25, bottom: 15),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: urint_test_color.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.65),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                            colors: [
                                              HexColor("#020204")
                                                  .withOpacity(1),
                                              HexColor("#36393E")
                                                  .withOpacity(1),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: HexColor('#04060F'),
                                                offset: Offset(10, 10),
                                                blurRadius: 20)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 76,
                                              decoration: BoxDecoration(
                                                  color:
                                                      urint_test_color[index],
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Container(
                                              child: Flexible(
                                                child: Text(
                                                  urine_test_text[index],
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: FontStyleUtility.h13(
                                                      fontColor: Colors.white,
                                                      family: 'PR'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 15, left: 15, top: 15, bottom: 20),
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
                                    blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24, top: 14),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Results',
                                  style: FontStyleUtility.h16(
                                      fontColor: HexColor('#DFDFDF'),
                                      family: 'PR'),
                                ),
                              ),
                              Container(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(top: 25, bottom: 15),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: urint_test_color.length,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.65),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                            colors: [
                                              HexColor("#020204")
                                                  .withOpacity(1),
                                              HexColor("#36393E")
                                                  .withOpacity(1),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: HexColor('#04060F'),
                                                offset: Offset(10, 10),
                                                blurRadius: 20)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 76,
                                              decoration: BoxDecoration(
                                                  color:
                                                      urint_test_color[index],
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                            SizedBox(
                                              width: 9,
                                            ),
                                            Container(
                                              child: Flexible(
                                                child: Text(
                                                  urine_test_text[index],
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: FontStyleUtility.h13(
                                                      fontColor: Colors.white,
                                                      family: 'PR'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
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
      watch.stop();
      setTime_finish();
    });
    Fluttertoast.showToast(
      msg: "Plese review Performance",
      textColor: Colors.white,
      backgroundColor: Colors.red,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
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

    return "$minutesStr:$secondsStr";
  }
}
