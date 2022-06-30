import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:vibration/vibration.dart';

import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';

class KegelScreen extends StatefulWidget {
  const KegelScreen({Key? key}) : super(key: key);

  @override
  State<KegelScreen> createState() => _KegelScreenState();
}

class _KegelScreenState extends State<KegelScreen>
    with TickerProviderStateMixin {
  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';

  // updateTime(Timer timer) {
  //   if (watch.isRunning) {
  //     if (mounted) {
  //       setState(() {
  //         print("startstop Inside=$startStop");
  //         elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
  //         // percent += 1;
  //         // if (percent >= 100) {
  //         //   percent = 0.0;
  //         // }
  //         print(elapsedTime);
  //
  //         if (elapsedTime == '05') {
  //           stopWatch_finish();
  //           // _animationController_shadow1!.reverse();
  //           setState(() {
  //             elapsedTime = '00';
  //             percent = 0.0;
  //             watch.reset();
  //             CommonWidget().showToaster(msg: '${9 - counter} Times left');
  //             counter++;
  //             print(counter);
  //             // paused_time.clear();
  //           });
  //           Future.delayed(Duration(seconds: 2), () {
  //             if (counter == 4) {
  //               stopWatch_finish();
  //               setState(() {
  //                 elapsedTime = '00';
  //                 // watch.stop();
  //                 counter = 0;
  //               });
  //               sets++;
  //               print('Sets-------$sets');
  //               if (sets == 3) {
  //                 stopWatch_finish();
  //                 setState(() {
  //                   elapsedTime = '00';
  //                   percent = 0.0;
  //                   // watch.stop();
  //                   counter = 0;
  //                 });
  //                 CommonWidget().showToaster(msg: "Method Complete");
  //               }
  //             } else {
  //               startWatch();
  //             }
  //           });
  //         }
  //       });
  //     }
  //   }
  // }
  updateTime_Easy(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          print(elapsedTime);

          if (elapsedTime == '11') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              // paused_time.clear();
            });
            Future.delayed(Duration(seconds: 2), () {
              if (counter == 8) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                });
                sets++;
                print('Sets-------$sets');
                if (sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Normal");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                startWatch();
              }
            });
          }
        });
      }
    }
  }

  updateTime_Normal(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          print(elapsedTime);

          if (elapsedTime == '13') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = '00';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              // paused_time.clear();
            });
            Future.delayed(Duration(seconds: 2), () {
              if (counter == 10) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                });
                sets++;
                print('Sets-------$sets');
                if (sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Hard");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                startWatch();
              }
            });
          }
        });
      }
    }
  }

  int counter = 0;
  int sets = 0;

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
  AnimationController? _animationController_vibrate;
  Animation? _animation_vibrate;

  AnimationController? _animationController_button;
  Animation? _animation_button;

  // AnimationController? _animationController_textK;
  Animation? _animation_textK;

  // AnimationController? _animationController_textTime;
  Animation? _animation_textTime;

  bool animation_started = false;
  double button_height = 200;
  double text_k_size = 100;
  double text_time_size = 40;

  bool shadow_animation1_completed = false;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    vibration();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 25.0).animate(_animationController!)
      ..addStatusListener((status) {
        print(status);

        // shadow_animation1_completed = true;
      });

    // _animationController_vibrate =
    //     AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    // _animationController_vibrate!.repeat(reverse: true);
    // _animation_vibrate =
    //     Tween(begin: 25.0, end: 28.0).animate(_animationController_vibrate!)
    //       ..addListener(() {
    //         // print(status);
    //         // if (status == AnimationStatus.completed) {}
    //         // shadow_animation1_completed = true;
    //       });aa

    _animationController_button =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController_button!.forward();
    _animation_button =
        Tween(begin: 200.0, end: 120.0).animate(_animationController_button!)
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

  String? levels;

  @override
  dispose() {
    _animationController!.dispose(); // you need this
    _animationController_button!.dispose();
    _animationController_vibrate!.dispose();
    Vibration.cancel();
    // _animationController_textTime!.dispose();
    // _animationController_textK!.dispose();// you need this
    super.dispose();
  }

  @override
  void initState() {
    get_saved_data();
    super.initState();
  }

  get_saved_data() async {
    levels = await PreferenceManager().getPref(URLConstants.levels);
    print("Levels $levels");
    setState(() {});
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
            decoration:
                // (back_wallpaper ?
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
            fit: BoxFit.cover,
            image: AssetImage(
              AssetUtils.k_screen_back,
            ),
          ),
        )
            // : BoxDecoration()),
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
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetUtils.star_icon,
                        color:
                            (sets >= 1 ? ColorUtils.primary_gold : Colors.grey),
                        height: 22,
                        width: 22,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        AssetUtils.star_icon,
                        height: 22,
                        color:
                            (sets >= 2 ? ColorUtils.primary_gold : Colors.grey),
                        width: 22,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        AssetUtils.star_icon,
                        color:
                            (sets >= 3 ? ColorUtils.primary_gold : Colors.grey),
                        height: 22,
                        width: 22,
                      ),
                    ],
                  )),

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
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container(
                  //     margin: EdgeInsets.all(0),
                  //     alignment: Alignment.topCenter,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Image.asset(
                  //           AssetUtils.star_icon,
                  //           height: 22,
                  //           width: 22,
                  //         ),
                  //         SizedBox(
                  //           width: 7,
                  //         ),
                  //         Image.asset(
                  //           AssetUtils.star_icon,
                  //           height: 22,
                  //           width: 22,
                  //         ),
                  //         SizedBox(
                  //           width: 7,
                  //         ),
                  //         Image.asset(
                  //           AssetUtils.star_icon,
                  //           height: 22,
                  //           width: 22,
                  //         ),
                  //       ],
                  //     )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(

                      // color: Colors.white,
                      child: AvatarGlow(
                    endRadius: 100.0,
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
                      child: Container(
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
                                image: AssetImage(AssetUtils.home_button)),
                            boxShadow: [
                              BoxShadow(
                                color: (animation_started
                                    ? HexColor('#E64A9B')
                                    : Colors.transparent),
                                blurRadius:
                                    (animation_started ? _animation!.value : 0),
                                spreadRadius:
                                    (animation_started ? _animation!.value : 0),
                              )
                            ]),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'K',
                                style: TextStyle(
                                    color: HexColor('#E64A9B').withOpacity(0.4),
                                    fontSize: (animation_started
                                        ? _animation_textK!.value
                                        : text_k_size),
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
                                    fontSize: (animation_started
                                        ? _animation_textTime!.value
                                        : text_time_size),
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 28,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (started) {
                        startTimer();
                        Future.delayed(Duration(seconds: 3), () {
                          // start_animation();
                          // start_button_animation();
                          startWatch();
                        });
                      } else {
                        await stopWatch_finish();
                        Vibration.cancel();
                        setState(() {
                          elapsedTime = '00';
                          percent = 0.0;
                          back_wallpaper = true;
                          button_height = 120;
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
                    height: 12,
                  ),
                  Text(
                      (levels == 'Easy'
                          ? ('$counter/8')
                          : (levels == 'Normal'
                              ? ('$counter/10')
                              : ('$counter/4'))),
                      style: FontStyleUtility.h25(
                          fontColor: ColorUtils.primary_gold, family: 'PM')),
                  SizedBox(
                    height: 27,
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
                    width: MediaQuery.of(context).size.width,
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
                        Container(
                          margin: EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Level : $levels',
                            style: FontStyleUtility.h16(
                                fontColor: HexColor('#F2F2F2'), family: 'PR'),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, left: 27, right: 27),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  (levels == 'Easy'
                                      ? "Each exercise has a duration of 8 seconds and stop for 2 seconds (repeating the process 8 times is considered 1 set). \nUser needs to complete 3 sets per day"
                                      : (levels == 'Normal'
                                          ? "Each exercise has a duration of 10 seconds and stop for 2 seconds, repeating the process 10 times is considered 1 set. \nUser needs to complete 3 sets per day"
                                          : "kegel info")),
                                  textAlign: TextAlign.justify,
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
    start_animation();
    setState(() {
      startStop = false;
      started = false;
      watch.start();
      timer = Timer.periodic(
          Duration(milliseconds: 100),
          (levels == 'Easy ? '
              ? updateTime_Easy
              : (levels == 'Normal' ? updateTime_Normal : updateTime_Easy)));
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
      _animationController!.stop();
      _animationController_button!.stop();
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
    return secondsStr;
  }

  bool _canVibrate = true;

  Future<void> _init() async {
    bool? canVibrate = await Vibration.hasVibrator();
    setState(() {
      _canVibrate = canVibrate!;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  vibration() async {
    if (_canVibrate) {
      // Vibration.vibrate(
      //     // pattern: [100, 100,100, 100,100, 100,100, 100,],
      //     duration: 4000,
      //     intensities: [1, 255]);
      // print(
      //     "Vibration.hasCustomVibrationsSupport() ${Vibration.hasCustomVibrationsSupport()}");
      if (await Vibration.hasCustomVibrationsSupport() == true) {
        print("has support");
        Vibration.vibrate(
            // pattern: [100, 100,100, 100,100, 100,100, 100,],
            duration: (levels == 'Easy'
                ? 9000
                : levels == 'Normal'
                    ? 10000
                    : 9000),
            amplitude: 50
            // intensities: [1, 255]
            );
      } else {
        print("haddddd support");
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 500));
        Vibration.vibrate();
      }
      // Vibrate.defaultVibrationDuration;
      // Vibrate.defaultVibrationDuration;
      // Vibrate.vibrateWithPauses(pauses);
    } else {
      CommonWidget().showErrorToaster(msg: 'Device Cannot vibrate');
    }
  }
}
