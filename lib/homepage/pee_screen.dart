import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vibration/vibration.dart';

import '../utils/Asset_utils.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';

class PeeScreen extends StatefulWidget {
  const PeeScreen({Key? key}) : super(key: key);

  @override
  State<PeeScreen> createState() => _PeeScreenState();
}

class _PeeScreenState extends State<PeeScreen> with TickerProviderStateMixin {
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

  String elapsedTime = '00';
  String? levels;
  int counter = 0;
  int sets = 0;


  updateTime_normal(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          // percent += 1;
          // if (percent >= 100) {
          //   percent = 0.0;
          // }
          if (elapsedTime == '08') {
            stopWatch_finish();
            // _animationController_shadow1!.reverse();
            setState(() {
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              // CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              // paused_time.clear();
            });
            Future.delayed(Duration(seconds: 4), () {
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
                _animationController!.reverse();
                _animationController_button!.reverse();
                startWatch();
              // }
            });
          }


        });
      }
    }
  }

  double percent = 0.0;

  bool back_wallpaper = false;

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 3);

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
  double text_time_size = 40;

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
      ..addListener(() {});

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

  @override
  dispose() {
    _animationController!.dispose(); // you need this
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
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AssetUtils.p_screen_back,
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
              Textutils.pee,
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.primary_grey, family: 'PM'),
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
                children: [
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
                        // startOrStop();
                      },
                      child:
                      // CircularPercentIndicator(
                      //   circularStrokeCap: CircularStrokeCap.round,
                      //   percent: percent / 100,
                      //   animation: true,
                      //   animateFromLastPercent: true,
                      //   radius: 61,
                      //   lineWidth: 0,
                      //   progressColor: Colors.transparent,
                      //   backgroundColor: Colors.transparent,
                      //   center:
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
                                  image: AssetImage(AssetUtils.home_button)),
                              boxShadow: [
                                BoxShadow(
                                  color: (animation_started
                                      ? HexColor('#F5C921')
                                      : Colors.transparent),
                                  blurRadius: (animation_started
                                      ? _animation!.value
                                      : 0),
                                  spreadRadius: (animation_started
                                      ? _animation!.value
                                      : 0),
                                )
                              ]),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'P',
                                  style: TextStyle(
                                      color:
                                          HexColor('#F5C921').withOpacity(0.2),
                                      fontSize: (animation_started
                                          ? _animation_textK!.value
                                          : text_k_size),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  elapsedTime,
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
                      // ),
                    ),
                    glowColor: Colors.white,
                  ),
                  SizedBox(
                    height: 28,
                  ),

                  GestureDetector(
                    onTap: () async {
                      if (started) {
                        start_animation();
                        startWatch();
                      } else {
                        await stopWatch_finish();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Pee Info',
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
                        Container(
                          margin: EdgeInsets.only(top: 0, left: 27, right: 27),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  (levels == 'Easy'
                                      ? "The device will vibrate for 3 seconds and stop for 4 seconds, \ncontinuing the same process until user presses the finish button."
                                      : (levels == 'Normal'
                                      ? "The device will vibrate for 4 seconds and stop for 3 seconds, \ncontinuing the same process until user presses the finish button."
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
    start_animation();

    setState(() {
      elapsedTime = "00";


      startStop = false;
      started = false;
      watch.start();
      timer = Timer.periodic(Duration(milliseconds: 100), updateTime_normal);
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
    Fluttertoast.showToast(
      msg: "Plese review Performance",
      textColor: Colors.white,
      backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
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
                ? 4000
                : levels == 'Normal'
                ? 5000
                : 5000),
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
}
