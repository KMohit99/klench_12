import 'dart:async';
import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/Dashboard/dashboard_screen.dart';
import 'package:klench_/homepage/controller/kegel_excercise_controller.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/homepage/theme_data.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibration/vibration.dart';

import '../main.dart';
import '../utils/Asset_utils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import 'TESTALARMPAGE.dart';
import 'alarm_helper.dart';
import 'alarm_info.dart';

class KegelScreen extends StatefulWidget {
  const KegelScreen({Key? key}) : super(key: key);

  @override
  State<KegelScreen> createState() => _KegelScreenState();
}

class _KegelScreenState extends State<KegelScreen>
    with TickerProviderStateMixin {
  final Kegel_controller _kegel_controller =
      Get.put(Kegel_controller(), tag: Kegel_controller().toString());

  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;

  String elapsedTime = '00';
  TextEditingController Alarm_title = new TextEditingController();
  List Alarm_title_list = [];

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
              elapsedTime = 'PUSH';
              percent = 0.0;
              watch.reset();
              CommonWidget().showToaster(msg: '${7 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;

              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 5), () {
              print('indise 4 seconds');
              if (counter == 8) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                });
                _kegel_controller.sets++;
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Normal");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                startWatch();
              }
            });
          }
        });
      }
    }
  }

  bool four_started = false;

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
              CommonWidget().showToaster(msg: '${9 - counter} Times left');
              counter++;
              print(counter);
              four_started = true;
              // paused_time.clear();
            });
            startWatch2();

            Future.delayed(const Duration(seconds: 5), () async {
              if (counter == 10) {
                stopWatch_finish();
                setState(() {
                  elapsedTime = '00';
                  // watch.stop();
                  counter = 0;
                });
                _kegel_controller.sets++;
                await _kegel_controller.Kegel_post_API(context);
                if (_kegel_controller.kegelPostModel!.error == false) {
                  await getdata();
                }
                print('Sets-------$_kegel_controller.sets');
                if (_kegel_controller.sets == 3) {
                  stopWatch_finish();
                  setState(() {
                    elapsedTime = '00';
                    percent = 0.0;
                    // watch.stop();
                    counter = 0;
                  });
                  CommonWidget().showToaster(msg: "Method Complete");
                  Future.delayed(const Duration(seconds: 5), () {
                    CommonWidget().showErrorToaster(
                        msg:
                            "After one month it will automatically switch to Hard");
                  });
                }
              } else {
                _animationController!.reverse();
                _animationController_button!.reverse();
                stopWatch_finish();
                // _animationController_shadow1!.reverse();
                setState(() {
                  elapsedTime = '00';
                  four_started = false;
                  watch.reset();
                });
                startWatch();
              }
            });
          }
        });
      }
    }
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                if (value != null && value != selectedDate)
                  setState(() {
                    selectedDate = value;
                  });
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2019,
              maximumYear: 2021,
            ),
          );
        });
  }

  int counter = 0;

  double percent = 0.0;

  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 3);
  bool timer_started = false;

  void startTimer() {
    setState(() {
      timer_started = true;
    });
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
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
  // AnimationController? _animationController_vibrate;
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

  bool get wantKeepAlive => true;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    vibration();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
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
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
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
    if (animation_started == true) {
      _animationController!.dispose(); // you need this
      _animationController_button!.dispose();
    }
    Vibration.cancel();
    // _animationController_textTime!.dispose();
    // _animationController_textK!.dispose();// you need this
    super.dispose();
  }

  @override
  void initState() {
    // getdata();
    //
    init();
    // _alarmTime = DateTime.now();
    // _alarmHelper.initializeDatabase().then((value) {
    //   print('------database intialized');
    //   loadAlarms();
    // });
    // get_saved_data();
    super.initState();
  }
  init() async {
    await getdata();
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) async {
      print('------database intialized');
      await loadAlarms();
    });
  }

  DateTime? _alarmTime;
  String? _alarmTimeString;
  final AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  Future loadAlarms() async {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }


  get_saved_data() async {
    // print("Levels $levels");
    // print("Dateformat ${DateFormat('yyyy-MM-dd').format(DateTime.now())}");
    // setState(() {});
  }

  Future getdata() async {
    levels = await PreferenceManager().getPref(URLConstants.levels);
    setState(() {});
    await _kegel_controller.Kegel_get_API(context);
      if (_kegel_controller.kegelGetModel!.error == false) {
        setState(() {
          _kegel_controller.sets =
              int.parse(_kegel_controller.kegelGetModel!.data![0].sets!);
        });
      }

    print("Setssss : ${_kegel_controller.sets}");
  }

  DateTime selectedDate = DateTime.now();

  String? selected_date_sets = '';
  String? selected_date = '';
  var selected_time;

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
          decoration: (back_wallpaper
              ? const BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topCenter,`
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
                  image: const DecorationImage(
                    fit: BoxFit.cover,
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
                (started
                    ? Navigator.pop(context)
                    : CommonWidget()
                        .showErrorToaster(msg: "Please finish the method"));
              },
              child: Container(
                  width: 41,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          begin: const Alignment(-1.0, -4.0),
                          end: const Alignment(1.0, 4.0),
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
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetUtils.star_icon,
                        color: (_kegel_controller.sets >= 1
                            ? ColorUtils.primary_gold
                            : Colors.grey),
                        height: 22,
                        width: 22,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        AssetUtils.star_icon,
                        height: 22,
                        color: (_kegel_controller.sets >= 2
                            ? ColorUtils.primary_gold
                            : Colors.grey),
                        width: 22,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        AssetUtils.star_icon,
                        color: (_kegel_controller.sets >= 3
                            ? ColorUtils.primary_gold
                            : Colors.grey),
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
          body: Container(
            margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      // color: Colors.white,
                      child: AvatarGlow(
                    endRadius: 100.0,
                    showTwoGlows: true,
                    animate: false,
                    // (startStop ? false : true),
                    duration: const Duration(milliseconds: 900),
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
                            image: const DecorationImage(
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
                              child: (four_started
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "PUSH",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: (animation_started
                                                  ? _animation_textTime!.value
                                                  : text_time_size),
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          elapsedTime,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: (animation_started
                                                  ? _animation_textTime!.value
                                                  : text_time_size),
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      (timer_started
                                          ? ('$seconds' == '3'
                                              ? 'Ready'
                                              : ('$seconds' == '2'
                                                  ? 'Set'
                                                  : ('$seconds' == '1'
                                                      ? 'Kegel'
                                                      : elapsedTime)))
                                          : ''),
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
                    ),
                  )),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (started) {
                        startTimer();
                        back_wallpaper = false;

                        Future.delayed(const Duration(seconds: 3), () {
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
                      margin: const EdgeInsets.symmetric(horizontal: 15),
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
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Text(
                            (started ? 'Start' : 'Finish'),
                            style: FontStyleUtility.h16(
                                fontColor: Colors.black, family: 'PM'),
                          )),
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 27,
                  ),
                  Obx(() => _kegel_controller.isuserinfoLoading.value == false
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          // height: 45,
                          // width:(width ?? 300) ,
                          decoration: BoxDecoration(
                              // color: Colors.black.withOpacity(0.65),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#36393E").withOpacity(0.9),
                                  HexColor("#020204").withOpacity(0.9),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TableCalendar(
                              // initialCalendarFormat: CalendarFormat.week,
                              calendarStyle: CalendarStyle(
                                defaultTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.white),
                                todayTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: ColorUtils.dark_grey),
                                todayDecoration: BoxDecoration(
                                    color: HexColor("#ffffff").withOpacity(1),
                                    borderRadius: BorderRadius.circular(100)),
                                // todayColor: Colors.orange,
                                selectedTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.green),
                                weekendTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.white),
                                isTodayHighlighted: true,
                                selectedDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),

                              headerStyle: HeaderStyle(
                                leftChevronIcon: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorUtils.primary_gold,
                                  size: 15,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: ColorUtils.primary_gold,
                                  size: 15,
                                ),
                                formatButtonVisible: false,
                                titleTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                                // centerHeaderTitle: true,
                                formatButtonDecoration: BoxDecoration(
                                  color: ColorUtils.primary_gold,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                formatButtonTextStyle:
                                    const TextStyle(color: Colors.black),
                                formatButtonShowsNext: false,
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.white),
                                  weekendStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                      color: Colors.white)),
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (date, events) async {
                                // print(date);
                                // print(DateFormat('yyyy-MM-dd').format(date));
                                //
                                // Data? person = await _peeScreenController
                                //     .peeGetModel!.data!
                                //     .firstWhereOrNull(
                                //   (element) =>
                                //       element.createdDate ==
                                //       DateFormat('yyyy-MM-dd').format(date),
                                // );
                                // // print("person  $person");
                                // if (person != null) {
                                //   print("person ${person.sets}");
                                //   print(
                                //       "User peed ${person.sets} on ${person.createdDate}");
                                // } else {
                                //   print("no data found");
                                // }
                              },
                              // builders: CalendarBuilders(
                              //   selectedDayBuilder: (context, date, events) => Container(
                              //       margin: const EdgeInsets.all(4.0),
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //           color: Theme.of(context).primaryColor,
                              //           borderRadius: BorderRadius.circular(10.0)),
                              //       child: Text(
                              //         date.day.toString(),
                              //         style: TextStyle(color: Colors.white),
                              //       )),
                              //   todayDayBuilder: (context, date, events) => Container(
                              //       margin: const EdgeInsets.all(4.0),
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //           color: Colors.orange,
                              //           borderRadius: BorderRadius.circular(10.0)),
                              //       child: Text(
                              //         date.day.toString(),
                              //         style: TextStyle(color: Colors.white),
                              //       )),

                              calendarBuilders: CalendarBuilders(
                                markerBuilder:
                                    (BuildContext context, date, events) {
                                  for (var i = 0;
                                      i <
                                          _kegel_controller
                                              .kegelGetModel!.data!.length;
                                      i++) {
                                    if (DateFormat('yyyy-MM-dd').format(date) ==
                                        _kegel_controller.kegelGetModel!
                                            .data![i].createdDate) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected_date_sets =
                                                _kegel_controller.kegelGetModel!
                                                    .data![i].sets!;
                                            selected_date = _kegel_controller
                                                .kegelGetModel!
                                                .data![i]
                                                .createdDate!;
                                          });
                                          print(selected_date_sets);
                                          print(selected_date);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: ColorUtils.primary_gold,
                                                width: 2),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  // return ListView.builder(
                                  //     shrinkWrap: true,
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: events.length,
                                  //     itemBuilder: (context, index) {
                                  //       return Container(
                                  //         margin: const EdgeInsets.only(top: 20),
                                  //         padding: const EdgeInsets.all(1),
                                  //         child: Container(
                                  //           // height: 7,
                                  //           width: 5,
                                  //           decoration: BoxDecoration(
                                  //               shape: BoxShape.circle,
                                  //               color: Colors.primaries[Random()
                                  //                   .nextInt(Colors.primaries.length)]),
                                  //         ),
                                  //       );
                                  //     });
                                },
                              ),

                              calendarFormat: CalendarFormat.month,
                              // calendarController: _controller,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                            ),
                          ),
                        )
                      : SizedBox.shrink()),
                  const SizedBox(
                    height: 10,
                  ),
                  (selected_date_sets!.isEmpty
                      ? SizedBox.shrink()
                      : Container(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Text(
                              'Exercise perormed ${selected_date_sets} times on ${selected_date}',
                              style: FontStyleUtility.h14(
                                  fontColor: HexColor('#FFFFFF'), family: 'PM'),
                            ),
                          ),
                        )),
                  const SizedBox(
                    height: 10,
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
                              offset: const Offset(10, 10),
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        // if (_currentAlarms!.length < 5)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          child: ListTile(
                            leading: Container(
                              margin: EdgeInsets.only(left: 0),
                              child: Text(
                                "Add Alarm",
                                style: FontStyleUtility.h16(
                                    fontColor: ColorUtils.primary_gold,
                                    family: 'PM'),
                              ),
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: GestureDetector(
                                  onTap: () {
                                    _alarmTimeString = DateFormat('HH:mm')
                                        .format(selectedDate);
                                    showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      clipBehavior: Clip.antiAlias,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
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
                                                        color:
                                                            HexColor('#04060F'),
                                                        offset: const Offset(
                                                            -10, 10),
                                                        blurRadius: 20)
                                                  ],
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          topRight:
                                                              Radius.circular(
                                                                  20))),
                                              padding: const EdgeInsets.all(32),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    // FlatButton(
                                                    //   onPressed:
                                                    //       () async {
                                                    //     // var selectedTime = await showTimePicker(
                                                    //     //   context: context,
                                                    //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                                                    //     //   initialEntryMode: TimePickerEntryMode.dial,
                                                    //     //   initialTime: TimeOfDay.now(),
                                                    //     //   builder: (context, child) {
                                                    //     //     return Theme(
                                                    //     //       data: Theme.of(
                                                    //     //               context)
                                                    //     //           .copyWith(
                                                    //     //         colorScheme:
                                                    //     //             ColorScheme
                                                    //     //                 .dark(
                                                    //     //           primary:
                                                    //     //               Colors.black,
                                                    //     //           onPrimary:
                                                    //     //               Colors.white,
                                                    //     //           surface:
                                                    //     //               ColorUtils.primary_gold,
                                                    //     //           // onPrimary: Colors.black, // <-- SEE HERE
                                                    //     //           onSurface:
                                                    //     //               Colors.black,
                                                    //     //         ),
                                                    //     //         dialogBackgroundColor:
                                                    //     //             ColorUtils
                                                    //     //                 .primary_gold,
                                                    //     //         textButtonTheme:
                                                    //     //             TextButtonThemeData(
                                                    //     //           style: TextButton
                                                    //     //               .styleFrom(
                                                    //     //             primary:
                                                    //     //                 Colors.black, // button text color
                                                    //     //           ),
                                                    //     //         ),
                                                    //     //       ),
                                                    //     //       child:
                                                    //     //           child!,
                                                    //     //     );
                                                    //     //   },
                                                    //     // );
                                                    //     // if (selectedTime !=
                                                    //     //     null) {
                                                    //     //   final now =
                                                    //     //       DateTime
                                                    //     //           .now();
                                                    //     //   var selectedDateTime = DateTime(
                                                    //     //       now.year,
                                                    //     //       now.month,
                                                    //     //       now.day,
                                                    //     //       selectedTime
                                                    //     //           .hour,
                                                    //     //       selectedTime
                                                    //     //           .minute);
                                                    //     //   _alarmTime =
                                                    //     //       selectedDateTime;
                                                    //     //   setModalState(
                                                    //     //       () {
                                                    //     //     _alarmTimeString =
                                                    //     //         DateFormat(
                                                    //     //                 'HH:mm')
                                                    //     //             .format(
                                                    //     //                 selectedDateTime);
                                                    //     //   });
                                                    //     // }
                                                    //   },
                                                    //   child: Text(
                                                    //       _alarmTimeString!,
                                                    //       style: FontStyleUtility.h35(
                                                    //           fontColor:
                                                    //               ColorUtils
                                                    //                   .primary_gold,
                                                    //           family:
                                                    //               'PM')),
                                                    // ),
                                                    Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                            colors: [
                                                              HexColor(
                                                                      "#000000")
                                                                  .withOpacity(
                                                                      1),
                                                              HexColor(
                                                                      "#04060F")
                                                                  .withOpacity(
                                                                      1),
                                                              HexColor(
                                                                      "#000000")
                                                                  .withOpacity(
                                                                      1),
                                                            ],
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: HexColor(
                                                                    '#04060F'),
                                                                offset: Offset(
                                                                    3, 3),
                                                                blurRadius: 10)
                                                          ]),
                                                      child: Stack(
                                                        children: [
                                                          CupertinoTheme(
                                                            data:
                                                                CupertinoThemeData(
                                                              brightness:
                                                                  Brightness
                                                                      .dark,
                                                            ),
                                                            child:
                                                                CupertinoDatePicker(
                                                              // use24hFormat: true,
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .time,
                                                              onDateTimeChanged:
                                                                  (DateTime
                                                                      value) {
                                                                selected_time =
                                                                    value;
                                                                print(
                                                                    "${value.hour}:${value.minute}");

                                                                if (selected_time !=
                                                                    null) {
                                                                  final now =
                                                                      DateTime
                                                                          .now();
                                                                  var selectedDateTime = DateTime(
                                                                      now.year,
                                                                      now.month,
                                                                      now.day,
                                                                      selected_time
                                                                          .hour,
                                                                      selected_time
                                                                          .minute);
                                                                  _alarmTime =
                                                                      selectedDateTime;
                                                                  setModalState(
                                                                      () {
                                                                    _alarmTimeString = DateFormat(
                                                                            'HH:mm')
                                                                        .format(
                                                                            selectedDateTime);
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    ListTile(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            double width =
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width;
                                                            double height =
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height;
                                                            return BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX:
                                                                          10,
                                                                      sigmaY:
                                                                          10),
                                                              child:
                                                                  AlertDialog(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      elevation:
                                                                          0.0,
                                                                      // title: Center(child: Text("Evaluation our APP")),
                                                                      content:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Container(
                                                                                  decoration:
                                                                                      BoxDecoration(
                                                                                          // color: Colors.black.withOpacity(0.65),
                                                                                          gradient:
                                                                                              LinearGradient(
                                                                                            begin: Alignment.centerLeft,
                                                                                            end: Alignment.centerRight,
                                                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                                                            colors: [
                                                                                              HexColor("#020204").withOpacity(1),
                                                                                              HexColor("#36393E").withOpacity(1),
                                                                                            ],
                                                                                          ),
                                                                                          boxShadow: [
                                                                                            BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                                                          ],
                                                                                          borderRadius: BorderRadius.circular(15)),
                                                                                  child: Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Column(
                                                                                          children: [
                                                                                            SizedBox(
                                                                                              height: 0,
                                                                                            ),

                                                                                            Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Container(
                                                                                                  margin: EdgeInsets.only(left: 18),
                                                                                                  child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 11,
                                                                                                ),
                                                                                                Container(
                                                                                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                                                                                  // width: 300,
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
                                                                                                      boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                                                                                                      borderRadius: BorderRadius.circular(20)),

                                                                                                  child: TextFormField(
                                                                                                    maxLength: 150,
                                                                                                    decoration: InputDecoration(
                                                                                                      contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                                                                                                      alignLabelWithHint: false,
                                                                                                      isDense: true,
                                                                                                      hintText: 'Add alarm title',
                                                                                                      counterStyle: TextStyle(
                                                                                                        height: double.minPositive,
                                                                                                      ),
                                                                                                      counterText: "",
                                                                                                      filled: true,
                                                                                                      border: InputBorder.none,
                                                                                                      enabledBorder: const OutlineInputBorder(
                                                                                                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                                                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                                                      ),
                                                                                                      hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                                                                                                    ),
                                                                                                    style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                                                                                    controller: Alarm_title,
                                                                                                    keyboardType: TextInputType.text,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: 10,
                                                                                            ),
                                                                                            GestureDetector(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  Alarm_title_list.add(Alarm_title.text);
                                                                                                  Navigator.pop(context);
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                alignment: Alignment.topRight,
                                                                                                child: Text(
                                                                                                  'Add',
                                                                                                  style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                            // common_button_gold(
                                                                                            //   onTap: () {
                                                                                            //     Get
                                                                                            //         .to(
                                                                                            //         DashboardScreen());
                                                                                            //   },
                                                                                            //   title_text: 'Go to Dashboard',
                                                                                            // ),
                                                                                          ],
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                              ),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(right: 10),
                                                                                  alignment: Alignment.topRight,
                                                                                  child: Container(
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
                                                                                          boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
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
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      )),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      title: Text('Title',
                                                          style: FontStyleUtility.h14(
                                                              fontColor: ColorUtils
                                                                  .primary_grey,
                                                              family: 'PR')),
                                                      trailing: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 15,
                                                          color: Colors.white),
                                                    ),
                                                    ListTile(
                                                      title: Text(
                                                        'Repeat',
                                                        style: FontStyleUtility.h14(
                                                            fontColor: ColorUtils
                                                                .primary_gold,
                                                            family: 'PR'),
                                                      ),
                                                      trailing: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        print('object');

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            double width =
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width;
                                                            double height =
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height;
                                                            return AlertDialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                elevation: 0.0,
                                                                // title: Center(child: Text("Evaluation our APP")),
                                                                content: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Stack(
                                                                      children: [
                                                                        Container(
                                                                          // height: 150,
                                                                          // height: double.maxFinite,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 4,
                                                                          width:
                                                                              double.maxFinite,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                                  // color: Colors.black.withOpacity(0.65),
                                                                                  gradient:
                                                                                      LinearGradient(
                                                                                    begin: Alignment.centerLeft,
                                                                                    end: Alignment.centerRight,
                                                                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                                                                    colors: [
                                                                                      HexColor("#020204").withOpacity(1),
                                                                                      HexColor("#36393E").withOpacity(1),
                                                                                    ],
                                                                                  ),
                                                                                  boxShadow: [
                                                                                    BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                                                  ],
                                                                                  borderRadius: BorderRadius.circular(20)),
                                                                          margin: EdgeInsets.symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 10),
                                                                          // height: 122,
                                                                          // width: 133,
                                                                          // padding: const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                // color: Colors.white,
                                                                                alignment: Alignment.center,
                                                                                child: ListView.builder(
                                                                                  padding: EdgeInsets.only(bottom: 0),

                                                                                  // physics: NeverScrollableScrollPhysics(),
                                                                                  itemCount: list_alarm.length,
                                                                                  shrinkWrap: true,
                                                                                  itemBuilder: (BuildContext context, int index) {
                                                                                    return GestureDetector(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          Selected_sound = list_alarm[index];
                                                                                          print("method_selected $Selected_sound");
                                                                                        });
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Container(
                                                                                        margin: EdgeInsets.symmetric(vertical: 8.5),
                                                                                        alignment: Alignment.center,
                                                                                        child: Text(
                                                                                          list_alarm[index],
                                                                                          style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 0),
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child: Container(
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
                                                                                    boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                                                                                    borderRadius: BorderRadius.circular(20)),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.all(4.0),
                                                                                  child: Icon(
                                                                                    Icons.cancel_outlined,
                                                                                    size: 20,
                                                                                    color: ColorUtils.primary_grey,
                                                                                  ),
                                                                                )),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ));
                                                          },
                                                        );
                                                      },
                                                      child: ListTile(
                                                        title: Text('Sound',
                                                            style: FontStyleUtility.h14(
                                                                fontColor:
                                                                    ColorUtils
                                                                        .primary_gold,
                                                                family: 'PR')),
                                                        trailing: const Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 15,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        if (Alarm_title
                                                            .text.isEmpty) {
                                                          CommonWidget()
                                                              .showErrorToaster(
                                                                  msg:
                                                                      "Enter Alarm title");
                                                          return;
                                                        } else {
                                                          await onSaveAlarm();
                                                        }
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            border: Border.all(
                                                                color: ColorUtils
                                                                    .primary_grey,
                                                                width: 1)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      12.0,
                                                                  horizontal:
                                                                      8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Icon(
                                                                Icons.alarm,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                'Save',
                                                                style: FontStyleUtility.h16(
                                                                    fontColor:
                                                                        ColorUtils
                                                                            .primary_gold,
                                                                    family:
                                                                        'PR'),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                    // scheduleAlarm();
                                  },
                                  child: Container(
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
                                              offset: const Offset(10, 10),
                                              blurRadius: 20)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.add_circle_outline,
                                        color: ColorUtils.primary_grey,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 16, vertical: 0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.only(left: 16),
                        //         child: Text(
                        //           "Add Alarm",
                        //           style: FontStyleUtility.h16(
                        //               fontColor: ColorUtils.primary_gold,
                        //               family: 'PM'),
                        //         ),
                        //       ),
                        //       FlatButton(
                        //           padding: const EdgeInsets.symmetric(
                        //               horizontal: 32, vertical: 10),
                        //           onPressed: () {
                        //             _alarmTimeString = DateFormat('HH:mm')
                        //                 .format(selectedDate);
                        //             showModalBottomSheet(
                        //               useRootNavigator: true,
                        //               context: context,
                        //               clipBehavior: Clip.antiAlias,
                        //               shape: const RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.vertical(
                        //                   top: Radius.circular(24),
                        //                 ),
                        //               ),
                        //               builder: (context) {
                        //                 return StatefulBuilder(
                        //                   builder: (context, setModalState) {
                        //                     return Container(
                        //                       decoration: BoxDecoration(
                        //                           // color: Colors.black.withOpacity(0.65),
                        //                           gradient: LinearGradient(
                        //                             begin:
                        //                                 Alignment.centerLeft,
                        //                             end:
                        //                                 Alignment.centerRight,
                        //                             // stops: [0.1, 0.5, 0.7, 0.9],
                        //                             colors: [
                        //                               HexColor("#020204")
                        //                                   .withOpacity(1),
                        //                               HexColor("#36393E")
                        //                                   .withOpacity(1),
                        //                             ],
                        //                           ),
                        //                           boxShadow: [
                        //                             BoxShadow(
                        //                                 color: HexColor(
                        //                                     '#04060F'),
                        //                                 offset: const Offset(
                        //                                     -10, 10),
                        //                                 blurRadius: 20)
                        //                           ],
                        //                           borderRadius:
                        //                               const BorderRadius.only(
                        //                                   topLeft:
                        //                                       Radius.circular(
                        //                                           20),
                        //                                   topRight:
                        //                                       Radius.circular(
                        //                                           20))),
                        //                       padding:
                        //                           const EdgeInsets.all(32),
                        //                       child: SingleChildScrollView(
                        //                         child: Column(
                        //                           children: [
                        //                             // FlatButton(
                        //                             //   onPressed:
                        //                             //       () async {
                        //                             //     // var selectedTime = await showTimePicker(
                        //                             //     //   context: context,
                        //                             //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                        //                             //     //   initialEntryMode: TimePickerEntryMode.dial,
                        //                             //     //   initialTime: TimeOfDay.now(),
                        //                             //     //   builder: (context, child) {
                        //                             //     //     return Theme(
                        //                             //     //       data: Theme.of(
                        //                             //     //               context)
                        //                             //     //           .copyWith(
                        //                             //     //         colorScheme:
                        //                             //     //             ColorScheme
                        //                             //     //                 .dark(
                        //                             //     //           primary:
                        //                             //     //               Colors.black,
                        //                             //     //           onPrimary:
                        //                             //     //               Colors.white,
                        //                             //     //           surface:
                        //                             //     //               ColorUtils.primary_gold,
                        //                             //     //           // onPrimary: Colors.black, // <-- SEE HERE
                        //                             //     //           onSurface:
                        //                             //     //               Colors.black,
                        //                             //     //         ),
                        //                             //     //         dialogBackgroundColor:
                        //                             //     //             ColorUtils
                        //                             //     //                 .primary_gold,
                        //                             //     //         textButtonTheme:
                        //                             //     //             TextButtonThemeData(
                        //                             //     //           style: TextButton
                        //                             //     //               .styleFrom(
                        //                             //     //             primary:
                        //                             //     //                 Colors.black, // button text color
                        //                             //     //           ),
                        //                             //     //         ),
                        //                             //     //       ),
                        //                             //     //       child:
                        //                             //     //           child!,
                        //                             //     //     );
                        //                             //     //   },
                        //                             //     // );
                        //                             //     // if (selectedTime !=
                        //                             //     //     null) {
                        //                             //     //   final now =
                        //                             //     //       DateTime
                        //                             //     //           .now();
                        //                             //     //   var selectedDateTime = DateTime(
                        //                             //     //       now.year,
                        //                             //     //       now.month,
                        //                             //     //       now.day,
                        //                             //     //       selectedTime
                        //                             //     //           .hour,
                        //                             //     //       selectedTime
                        //                             //     //           .minute);
                        //                             //     //   _alarmTime =
                        //                             //     //       selectedDateTime;
                        //                             //     //   setModalState(
                        //                             //     //       () {
                        //                             //     //     _alarmTimeString =
                        //                             //     //         DateFormat(
                        //                             //     //                 'HH:mm')
                        //                             //     //             .format(
                        //                             //     //                 selectedDateTime);
                        //                             //     //   });
                        //                             //     // }
                        //                             //   },
                        //                             //   child: Text(
                        //                             //       _alarmTimeString!,
                        //                             //       style: FontStyleUtility.h35(
                        //                             //           fontColor:
                        //                             //               ColorUtils
                        //                             //                   .primary_gold,
                        //                             //           family:
                        //                             //               'PM')),
                        //                             // ),
                        //                             Container(
                        //                               height: 150,
                        //                               decoration:
                        //                                   BoxDecoration(
                        //                                       borderRadius:
                        //                                           BorderRadius
                        //                                               .circular(
                        //                                                   15),
                        //                                       gradient: LinearGradient(
                        //                                         begin: Alignment
                        //                                             .topCenter,
                        //                                         end: Alignment
                        //                                             .bottomCenter,
                        //                                         colors: [
                        //                                           HexColor(
                        //                                                   "#000000")
                        //                                               .withOpacity(
                        //                                                   1),
                        //                                           HexColor(
                        //                                                   "#04060F")
                        //                                               .withOpacity(
                        //                                                   1),
                        //                                           HexColor(
                        //                                                   "#000000")
                        //                                               .withOpacity(
                        //                                                   1),
                        //                                         ],
                        //                                       ),
                        //                                       boxShadow: [
                        //                                     BoxShadow(
                        //                                         color: HexColor(
                        //                                             '#04060F'),
                        //                                         offset:
                        //                                             Offset(
                        //                                                 3, 3),
                        //                                         blurRadius:
                        //                                             10)
                        //                                   ]),
                        //                               child: Stack(
                        //                                 children: [
                        //                                   CupertinoTheme(
                        //                                     data:
                        //                                         CupertinoThemeData(
                        //                                       brightness:
                        //                                           Brightness
                        //                                               .dark,
                        //                                     ),
                        //                                     child:
                        //                                         CupertinoDatePicker(
                        //                                       // use24hFormat: true,
                        //                                       mode:
                        //                                           CupertinoDatePickerMode
                        //                                               .time,
                        //                                       onDateTimeChanged:
                        //                                           (DateTime
                        //                                               value) {
                        //                                         selected_time =
                        //                                             value;
                        //                                         print(
                        //                                             "${value.hour}:${value.minute}");
                        //
                        //                                         if (selected_time !=
                        //                                             null) {
                        //                                           final now =
                        //                                               DateTime
                        //                                                   .now();
                        //                                           var selectedDateTime = DateTime(
                        //                                               now
                        //                                                   .year,
                        //                                               now
                        //                                                   .month,
                        //                                               now.day,
                        //                                               selected_time
                        //                                                   .hour,
                        //                                               selected_time
                        //                                                   .minute);
                        //                                           _alarmTime =
                        //                                               selectedDateTime;
                        //                                           setModalState(
                        //                                               () {
                        //                                             _alarmTimeString = DateFormat(
                        //                                                     'HH:mm')
                        //                                                 .format(
                        //                                                     selectedDateTime);
                        //                                           });
                        //                                         }
                        //                                       },
                        //                                     ),
                        //                                   ),
                        //                                 ],
                        //                               ),
                        //                             ),
                        //
                        //                             ListTile(
                        //                               onTap: () {
                        //                                 showDialog(
                        //                                   context: context,
                        //                                   builder:
                        //                                       (BuildContext
                        //                                           context) {
                        //                                     double width =
                        //                                         MediaQuery.of(
                        //                                                 context)
                        //                                             .size
                        //                                             .width;
                        //                                     double height =
                        //                                         MediaQuery.of(
                        //                                                 context)
                        //                                             .size
                        //                                             .height;
                        //                                     return BackdropFilter(
                        //                                       filter: ImageFilter
                        //                                           .blur(
                        //                                               sigmaX:
                        //                                                   10,
                        //                                               sigmaY:
                        //                                                   10),
                        //                                       child:
                        //                                           AlertDialog(
                        //                                               backgroundColor:
                        //                                                   Colors
                        //                                                       .transparent,
                        //                                               contentPadding:
                        //                                                   EdgeInsets
                        //                                                       .zero,
                        //                                               elevation:
                        //                                                   0.0,
                        //                                               // title: Center(child: Text("Evaluation our APP")),
                        //                                               content:
                        //                                                   Column(
                        //                                                 mainAxisAlignment:
                        //                                                     MainAxisAlignment.center,
                        //                                                 children: [
                        //                                                   Stack(
                        //                                                     children: [
                        //                                                       Padding(
                        //                                                         padding: const EdgeInsets.all(8.0),
                        //                                                         child: Container(
                        //                                                           decoration:
                        //                                                               BoxDecoration(
                        //                                                                   // color: Colors.black.withOpacity(0.65),
                        //                                                                   gradient:
                        //                                                                       LinearGradient(
                        //                                                                     begin: Alignment.centerLeft,
                        //                                                                     end: Alignment.centerRight,
                        //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                        //                                                                     colors: [
                        //                                                                       HexColor("#020204").withOpacity(1),
                        //                                                                       HexColor("#36393E").withOpacity(1),
                        //                                                                     ],
                        //                                                                   ),
                        //                                                                   boxShadow: [
                        //                                                                     BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                        //                                                                   ],
                        //                                                                   borderRadius: BorderRadius.circular(15)),
                        //                                                           child: Align(
                        //                                                               alignment: Alignment.center,
                        //                                                               child: Padding(
                        //                                                                 padding: const EdgeInsets.all(8.0),
                        //                                                                 child: Column(
                        //                                                                   children: [
                        //                                                                     SizedBox(
                        //                                                                       height: 0,
                        //                                                                     ),
                        //
                        //                                                                     Column(
                        //                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                        //                                                                       children: [
                        //                                                                         Container(
                        //                                                                           margin: EdgeInsets.only(left: 18),
                        //                                                                           child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                        //                                                                         ),
                        //                                                                         SizedBox(
                        //                                                                           height: 11,
                        //                                                                         ),
                        //                                                                         Container(
                        //                                                                           margin: EdgeInsets.symmetric(horizontal: 10),
                        //                                                                           // width: 300,
                        //                                                                           decoration: BoxDecoration(
                        //                                                                               // color: Colors.black.withOpacity(0.65),
                        //                                                                               gradient: LinearGradient(
                        //                                                                                 begin: Alignment.centerLeft,
                        //                                                                                 end: Alignment.centerRight,
                        //                                                                                 // stops: [0.1, 0.5, 0.7, 0.9],
                        //                                                                                 colors: [
                        //                                                                                   HexColor("#36393E").withOpacity(1),
                        //                                                                                   HexColor("#020204").withOpacity(1),
                        //                                                                                 ],
                        //                                                                               ),
                        //                                                                               boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                        //                                                                               borderRadius: BorderRadius.circular(20)),
                        //
                        //                                                                           child: TextFormField(
                        //                                                                             maxLength: 150,
                        //                                                                             decoration: InputDecoration(
                        //                                                                               contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                        //                                                                               alignLabelWithHint: false,
                        //                                                                               isDense: true,
                        //                                                                               hintText: 'Add alarm title',
                        //                                                                               counterStyle: TextStyle(
                        //                                                                                 height: double.minPositive,
                        //                                                                               ),
                        //                                                                               counterText: "",
                        //                                                                               filled: true,
                        //                                                                               border: InputBorder.none,
                        //                                                                               enabledBorder: const OutlineInputBorder(
                        //                                                                                 borderSide: BorderSide(color: Colors.transparent, width: 1),
                        //                                                                                 borderRadius: BorderRadius.all(Radius.circular(10)),
                        //                                                                               ),
                        //                                                                               hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                        //                                                                             ),
                        //                                                                             style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                        //                                                                             controller: Alarm_title,
                        //                                                                             keyboardType: TextInputType.text,
                        //                                                                           ),
                        //                                                                         ),
                        //                                                                       ],
                        //                                                                     ),
                        //                                                                     SizedBox(
                        //                                                                       height: 10,
                        //                                                                     ),
                        //                                                                     GestureDetector(
                        //                                                                       onTap: () {
                        //                                                                         setState(() {
                        //                                                                           Alarm_title_list.add(Alarm_title.text);
                        //                                                                           Navigator.pop(context);
                        //                                                                         });
                        //                                                                       },
                        //                                                                       child: Container(
                        //                                                                         alignment: Alignment.topRight,
                        //                                                                         child: Text(
                        //                                                                           'Add',
                        //                                                                           style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                        //                                                                         ),
                        //                                                                       ),
                        //                                                                     )
                        //                                                                     // common_button_gold(
                        //                                                                     //   onTap: () {
                        //                                                                     //     Get
                        //                                                                     //         .to(
                        //                                                                     //         DashboardScreen());
                        //                                                                     //   },
                        //                                                                     //   title_text: 'Go to Dashboard',
                        //                                                                     // ),
                        //                                                                   ],
                        //                                                                 ),
                        //                                                               )),
                        //                                                         ),
                        //                                                       ),
                        //                                                       GestureDetector(
                        //                                                         onTap: () {
                        //                                                           Navigator.pop(context);
                        //                                                         },
                        //                                                         child: Container(
                        //                                                           margin: EdgeInsets.only(right: 10),
                        //                                                           alignment: Alignment.topRight,
                        //                                                           child: Container(
                        //                                                               decoration: BoxDecoration(
                        //                                                                   // color: Colors.black.withOpacity(0.65),
                        //                                                                   gradient: LinearGradient(
                        //                                                                     begin: Alignment.centerLeft,
                        //                                                                     end: Alignment.centerRight,
                        //                                                                     // stops: [0.1, 0.5, 0.7, 0.9],
                        //                                                                     colors: [
                        //                                                                       HexColor("#36393E").withOpacity(1),
                        //                                                                       HexColor("#020204").withOpacity(1),
                        //                                                                     ],
                        //                                                                   ),
                        //                                                                   boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                        //                                                                   borderRadius: BorderRadius.circular(20)),
                        //                                                               child: Padding(
                        //                                                                 padding: const EdgeInsets.all(4.0),
                        //                                                                 child: Icon(
                        //                                                                   Icons.cancel_outlined,
                        //                                                                   size: 13,
                        //                                                                   color: ColorUtils.primary_grey,
                        //                                                                 ),
                        //                                                               )),
                        //                                                         ),
                        //                                                       )
                        //                                                     ],
                        //                                                   ),
                        //                                                 ],
                        //                                               )),
                        //                                     );
                        //                                   },
                        //                                 );
                        //                               },
                        //                               title: Text('Title',
                        //                                   style: FontStyleUtility.h14(
                        //                                       fontColor:
                        //                                           ColorUtils
                        //                                               .primary_grey,
                        //                                       family: 'PR')),
                        //                               trailing: const Icon(
                        //                                   Icons
                        //                                       .arrow_forward_ios,
                        //                                   size: 15,
                        //                                   color:
                        //                                       Colors.white),
                        //                             ),
                        //                             ListTile(
                        //                               title: Text(
                        //                                 'Repeat',
                        //                                 style: FontStyleUtility.h14(
                        //                                     fontColor: ColorUtils
                        //                                         .primary_gold,
                        //                                     family: 'PR'),
                        //                               ),
                        //                               trailing: const Icon(
                        //                                 Icons
                        //                                     .arrow_forward_ios,
                        //                                 size: 15,
                        //                                 color: Colors.white,
                        //                               ),
                        //                             ),
                        //                             GestureDetector(
                        //                               onTap: () {
                        //                                 print('object');
                        //
                        //                                 showDialog(
                        //                                   context: context,
                        //                                   builder:
                        //                                       (BuildContext
                        //                                           context) {
                        //                                     double width =
                        //                                         MediaQuery.of(
                        //                                                 context)
                        //                                             .size
                        //                                             .width;
                        //                                     double height =
                        //                                         MediaQuery.of(
                        //                                                 context)
                        //                                             .size
                        //                                             .height;
                        //                                     return AlertDialog(
                        //                                         backgroundColor:
                        //                                             Colors
                        //                                                 .transparent,
                        //                                         contentPadding:
                        //                                             EdgeInsets
                        //                                                 .zero,
                        //                                         elevation:
                        //                                             0.0,
                        //                                         // title: Center(child: Text("Evaluation our APP")),
                        //                                         content:
                        //                                             Column(
                        //                                           mainAxisAlignment:
                        //                                               MainAxisAlignment
                        //                                                   .center,
                        //                                           children: [
                        //                                             Stack(
                        //                                               children: [
                        //                                                 Container(
                        //                                                   // height: 150,
                        //                                                   // height: double.maxFinite,
                        //                                                   height:
                        //                                                       MediaQuery.of(context).size.height / 4,
                        //                                                   width:
                        //                                                       double.maxFinite,
                        //                                                   decoration:
                        //                                                       BoxDecoration(
                        //                                                           // color: Colors.black.withOpacity(0.65),
                        //                                                           gradient:
                        //                                                               LinearGradient(
                        //                                                             begin: Alignment.centerLeft,
                        //                                                             end: Alignment.centerRight,
                        //                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                        //                                                             colors: [
                        //                                                               HexColor("#020204").withOpacity(1),
                        //                                                               HexColor("#36393E").withOpacity(1),
                        //                                                             ],
                        //                                                           ),
                        //                                                           boxShadow: [
                        //                                                             BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                        //                                                           ],
                        //                                                           borderRadius: BorderRadius.circular(20)),
                        //                                                   margin:
                        //                                                       EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //                                                   // height: 122,
                        //                                                   // width: 133,
                        //                                                   // padding: const EdgeInsets.all(8.0),
                        //                                                   child:
                        //                                                       Column(
                        //                                                     mainAxisAlignment: MainAxisAlignment.center,
                        //                                                     children: [
                        //                                                       Container(
                        //                                                         // color: Colors.white,
                        //                                                         alignment: Alignment.center,
                        //                                                         child: ListView.builder(
                        //                                                           padding: EdgeInsets.only(bottom: 0),
                        //
                        //                                                           // physics: NeverScrollableScrollPhysics(),
                        //                                                           itemCount: list_alarm.length,
                        //                                                           shrinkWrap: true,
                        //                                                           itemBuilder: (BuildContext context, int index) {
                        //                                                             return GestureDetector(
                        //                                                               onTap: () {
                        //                                                                 setState(() {
                        //                                                                   Selected_sound = list_alarm[index];
                        //                                                                   print("method_selected $Selected_sound");
                        //                                                                 });
                        //                                                                 Navigator.pop(context);
                        //                                                               },
                        //                                                               child: Container(
                        //                                                                 margin: EdgeInsets.symmetric(vertical: 8.5),
                        //                                                                 alignment: Alignment.center,
                        //                                                                 child: Text(
                        //                                                                   list_alarm[index],
                        //                                                                   style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                        //                                                                 ),
                        //                                                               ),
                        //                                                             );
                        //                                                           },
                        //                                                         ),
                        //                                                       ),
                        //                                                     ],
                        //                                                   ),
                        //                                                 ),
                        //                                                 GestureDetector(
                        //                                                   onTap:
                        //                                                       () {
                        //                                                     Navigator.pop(context);
                        //                                                   },
                        //                                                   child:
                        //                                                       Container(
                        //                                                     margin: EdgeInsets.only(right: 0),
                        //                                                     alignment: Alignment.topRight,
                        //                                                     child: Container(
                        //                                                         decoration: BoxDecoration(
                        //                                                             // color: Colors.black.withOpacity(0.65),
                        //                                                             gradient: LinearGradient(
                        //                                                               begin: Alignment.centerLeft,
                        //                                                               end: Alignment.centerRight,
                        //                                                               // stops: [0.1, 0.5, 0.7, 0.9],
                        //                                                               colors: [
                        //                                                                 HexColor("#36393E").withOpacity(1),
                        //                                                                 HexColor("#020204").withOpacity(1),
                        //                                                               ],
                        //                                                             ),
                        //                                                             boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                        //                                                             borderRadius: BorderRadius.circular(20)),
                        //                                                         child: Padding(
                        //                                                           padding: const EdgeInsets.all(4.0),
                        //                                                           child: Icon(
                        //                                                             Icons.cancel_outlined,
                        //                                                             size: 20,
                        //                                                             color: ColorUtils.primary_grey,
                        //                                                           ),
                        //                                                         )),
                        //                                                   ),
                        //                                                 )
                        //                                               ],
                        //                                             ),
                        //                                           ],
                        //                                         ));
                        //                                   },
                        //                                 );
                        //                               },
                        //                               child: ListTile(
                        //                                 title: Text('Sound',
                        //                                     style: FontStyleUtility.h14(
                        //                                         fontColor:
                        //                                             ColorUtils
                        //                                                 .primary_gold,
                        //                                         family:
                        //                                             'PR')),
                        //                                 trailing: const Icon(
                        //                                     Icons
                        //                                         .arrow_forward_ios,
                        //                                     size: 15,
                        //                                     color:
                        //                                         Colors.white),
                        //                               ),
                        //                             ),
                        //                             GestureDetector(
                        //                               onTap: () async {
                        //                                 if (Alarm_title
                        //                                     .text.isEmpty) {
                        //                                   CommonWidget()
                        //                                       .showErrorToaster(
                        //                                           msg:
                        //                                               "Enter Alarm title");
                        //                                   return;
                        //                                 } else {
                        //                                   await onSaveAlarm();
                        //                                 }
                        //                               },
                        //                               child: Container(
                        //                                 width: MediaQuery.of(
                        //                                             context)
                        //                                         .size
                        //                                         .width /
                        //                                     3,
                        //                                 decoration: BoxDecoration(
                        //                                     borderRadius:
                        //                                         BorderRadius
                        //                                             .circular(
                        //                                                 30),
                        //                                     border: Border.all(
                        //                                         color: ColorUtils
                        //                                             .primary_grey,
                        //                                         width: 1)),
                        //                                 child: Padding(
                        //                                   padding:
                        //                                       const EdgeInsets
                        //                                               .symmetric(
                        //                                           vertical:
                        //                                               12.0,
                        //                                           horizontal:
                        //                                               8),
                        //                                   child: Row(
                        //                                     mainAxisAlignment:
                        //                                         MainAxisAlignment
                        //                                             .center,
                        //                                     children: [
                        //                                       const Icon(
                        //                                         Icons.alarm,
                        //                                         color: Colors
                        //                                             .white,
                        //                                         size: 25,
                        //                                       ),
                        //                                       const SizedBox(
                        //                                         width: 10,
                        //                                       ),
                        //                                       Text(
                        //                                         'Save',
                        //                                         style: FontStyleUtility.h16(
                        //                                             fontColor:
                        //                                                 ColorUtils
                        //                                                     .primary_gold,
                        //                                             family:
                        //                                                 'PR'),
                        //                                       ),
                        //                                     ],
                        //                                   ),
                        //                                 ),
                        //                               ),
                        //                             )
                        //                           ],
                        //                         ),
                        //                       ),
                        //                     );
                        //                   },
                        //                 );
                        //               },
                        //             );
                        //             // scheduleAlarm();
                        //           },
                        //           child: Container(
                        //             decoration: BoxDecoration(
                        //                 // color: Colors.black.withOpacity(0.65),
                        //                 gradient: LinearGradient(
                        //                   begin: Alignment.centerLeft,
                        //                   end: Alignment.centerRight,
                        //                   // stops: [0.1, 0.5, 0.7, 0.9],
                        //                   colors: [
                        //                     HexColor("#36393E")
                        //                         .withOpacity(1),
                        //                     HexColor("#020204")
                        //                         .withOpacity(1),
                        //                   ],
                        //                 ),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                       color: HexColor('#04060F'),
                        //                       offset: const Offset(10, 10),
                        //                       blurRadius: 20)
                        //                 ],
                        //                 borderRadius:
                        //                     BorderRadius.circular(20)),
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(8.0),
                        //               child: Icon(
                        //                 Icons.add_circle_outline,
                        //                 color: ColorUtils.primary_grey,
                        //               ),
                        //             ),
                        //           )),
                        //     ],
                        //   ),
                        // )
                        // else
                        //   const Center(
                        //       child: Text(
                        //     'Only 5 alarms allowed!',
                        //     style: const TextStyle(color: Colors.white),
                        //   )),
                        FutureBuilder<List<AlarmInfo>>(
                          future: _alarms,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _currentAlarms = snapshot.data;
                              return Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  children: snapshot.data!.map<Widget>((alarm) {
                                    var alarmTime = DateFormat('hh:mm aa')
                                        .format(alarm.alarmDateTime!);
                                    var gradientColor = GradientTemplate
                                        .gradientTemplate[
                                            alarm.gradientColorIndex!]
                                        .colors;
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          // color: Colors.black.withOpacity(0.65),
                                          // gradient: LinearGradient(
                                          //   begin: Alignment.centerLeft,
                                          //   end: Alignment.centerRight,
                                          //   // stops: [0.1, 0.5, 0.7, 0.9],
                                          //   colors: [
                                          //     HexColor("#020204").withOpacity(1),
                                          //     HexColor("#36393E").withOpacity(1),
                                          //   ],
                                          // ),
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //       color: HexColor('#04060F'),
                                          //       offset: Offset(-10, 10),
                                          //       blurRadius: 20)
                                          // ],
                                          border: Border(
                                            bottom: BorderSide(
                                              //                   <--- left side
                                              color: HexColor('#1d1d1d'),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  alarmTime,
                                                  style: FontStyleUtility.h16(
                                                      fontColor: Colors.white,
                                                      family: 'PR'),
                                                ),
                                                subtitle: Text(alarm.title!,
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                            HexColor('#8A8A8A'),
                                                        family: 'PR')),
                                                trailing: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color:
                                                        ColorUtils.primary_gold,
                                                    onPressed: () {
                                                      deleteAlarm(alarm.id!);
                                                    }),
                                                // Container(
                                                //   width: 20,
                                                //   child: Transform.scale(
                                                //     scale: 0.5,
                                                //     child: CupertinoSwitch(
                                                //       onChanged: (bool value) {},
                                                //       value: true,
                                                //       trackColor: HexColor('#717171'),
                                                //       thumbColor: Colors.black87,
                                                //       activeColor:
                                                //           ColorUtils.primary_gold,
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).followedBy([
                                    // if (_currentAlarms!.length < 5)
                                    //   Container(
                                    //     child: FlatButton(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 32, vertical: 10),
                                    //         onPressed: () {
                                    //           _alarmTimeString = DateFormat('HH:mm')
                                    //               .format(selectedDate);
                                    //           showModalBottomSheet(
                                    //             useRootNavigator: true,
                                    //             context: context,
                                    //             clipBehavior: Clip.antiAlias,
                                    //             shape: const RoundedRectangleBorder(
                                    //               borderRadius:
                                    //               BorderRadius.vertical(
                                    //                 top: Radius.circular(24),
                                    //               ),
                                    //             ),
                                    //             builder: (context) {
                                    //               return StatefulBuilder(
                                    //                 builder:
                                    //                     (context, setModalState) {
                                    //                   return Container(
                                    //                     decoration: BoxDecoration(
                                    //                       // color: Colors.black.withOpacity(0.65),
                                    //                         gradient:
                                    //                         LinearGradient(
                                    //                           begin: Alignment
                                    //                               .centerLeft,
                                    //                           end: Alignment
                                    //                               .centerRight,
                                    //                           // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                           colors: [
                                    //                             HexColor("#020204")
                                    //                                 .withOpacity(1),
                                    //                             HexColor("#36393E")
                                    //                                 .withOpacity(1),
                                    //                           ],
                                    //                         ),
                                    //                         boxShadow: [
                                    //                           BoxShadow(
                                    //                               color: HexColor(
                                    //                                   '#04060F'),
                                    //                               offset:
                                    //                               const Offset(
                                    //                                   -10, 10),
                                    //                               blurRadius: 20)
                                    //                         ],
                                    //                         borderRadius:
                                    //                         const BorderRadius
                                    //                             .only(
                                    //                             topLeft: Radius
                                    //                                 .circular(
                                    //                                 20),
                                    //                             topRight: Radius
                                    //                                 .circular(
                                    //                                 20))),
                                    //                     padding:
                                    //                     const EdgeInsets.all(
                                    //                         32),
                                    //                     child:
                                    //                     SingleChildScrollView(
                                    //                       child: Column(
                                    //                         children: [
                                    //                           // FlatButton(
                                    //                           //   onPressed:
                                    //                           //       () async {
                                    //                           //     // var selectedTime = await showTimePicker(
                                    //                           //     //   context: context,
                                    //                           //     //   // initialEntryMode: DatePickerEntryMode.calendarOnly,<- this
                                    //                           //     //   initialEntryMode: TimePickerEntryMode.dial,
                                    //                           //     //   initialTime: TimeOfDay.now(),
                                    //                           //     //   builder: (context, child) {
                                    //                           //     //     return Theme(
                                    //                           //     //       data: Theme.of(
                                    //                           //     //               context)
                                    //                           //     //           .copyWith(
                                    //                           //     //         colorScheme:
                                    //                           //     //             ColorScheme
                                    //                           //     //                 .dark(
                                    //                           //     //           primary:
                                    //                           //     //               Colors.black,
                                    //                           //     //           onPrimary:
                                    //                           //     //               Colors.white,
                                    //                           //     //           surface:
                                    //                           //     //               ColorUtils.primary_gold,
                                    //                           //     //           // onPrimary: Colors.black, // <-- SEE HERE
                                    //                           //     //           onSurface:
                                    //                           //     //               Colors.black,
                                    //                           //     //         ),
                                    //                           //     //         dialogBackgroundColor:
                                    //                           //     //             ColorUtils
                                    //                           //     //                 .primary_gold,
                                    //                           //     //         textButtonTheme:
                                    //                           //     //             TextButtonThemeData(
                                    //                           //     //           style: TextButton
                                    //                           //     //               .styleFrom(
                                    //                           //     //             primary:
                                    //                           //     //                 Colors.black, // button text color
                                    //                           //     //           ),
                                    //                           //     //         ),
                                    //                           //     //       ),
                                    //                           //     //       child:
                                    //                           //     //           child!,
                                    //                           //     //     );
                                    //                           //     //   },
                                    //                           //     // );
                                    //                           //     // if (selectedTime !=
                                    //                           //     //     null) {
                                    //                           //     //   final now =
                                    //                           //     //       DateTime
                                    //                           //     //           .now();
                                    //                           //     //   var selectedDateTime = DateTime(
                                    //                           //     //       now.year,
                                    //                           //     //       now.month,
                                    //                           //     //       now.day,
                                    //                           //     //       selectedTime
                                    //                           //     //           .hour,
                                    //                           //     //       selectedTime
                                    //                           //     //           .minute);
                                    //                           //     //   _alarmTime =
                                    //                           //     //       selectedDateTime;
                                    //                           //     //   setModalState(
                                    //                           //     //       () {
                                    //                           //     //     _alarmTimeString =
                                    //                           //     //         DateFormat(
                                    //                           //     //                 'HH:mm')
                                    //                           //     //             .format(
                                    //                           //     //                 selectedDateTime);
                                    //                           //     //   });
                                    //                           //     // }
                                    //                           //   },
                                    //                           //   child: Text(
                                    //                           //       _alarmTimeString!,
                                    //                           //       style: FontStyleUtility.h35(
                                    //                           //           fontColor:
                                    //                           //               ColorUtils
                                    //                           //                   .primary_gold,
                                    //                           //           family:
                                    //                           //               'PM')),
                                    //                           // ),
                                    //                           Container(
                                    //                             height: 150,
                                    //                             decoration: BoxDecoration(
                                    //                                 borderRadius: BorderRadius.circular(15),
                                    //                                 gradient: LinearGradient(
                                    //                                   begin: Alignment.topCenter,
                                    //                                   end: Alignment.bottomCenter,
                                    //                                   colors: [
                                    //                                     HexColor("#000000").withOpacity(1),
                                    //                                     HexColor("#04060F").withOpacity(1),
                                    //                                     HexColor("#000000").withOpacity(1),
                                    //
                                    //                                   ],
                                    //                                 ),
                                    //                                 boxShadow: [
                                    //                                   BoxShadow(
                                    //                                       color: HexColor('#04060F'),
                                    //                                       offset: Offset(3, 3),
                                    //                                       blurRadius: 10)
                                    //                                 ]),
                                    //                             child: Stack(
                                    //                               children: [
                                    //                                 CupertinoTheme(
                                    //                                   data: CupertinoThemeData(
                                    //                                     brightness: Brightness.dark,
                                    //                                   ),
                                    //                                   child: CupertinoDatePicker(
                                    //                                     // use24hFormat: true,
                                    //                                     mode: CupertinoDatePickerMode.time,
                                    //                                     onDateTimeChanged: (DateTime value) {
                                    //                                       selected_time= value;
                                    //                                       print("${value.hour}:${value.minute}");
                                    //
                                    //
                                    //                                       if (selected_time !=
                                    //                                           null) {
                                    //                                         final now =
                                    //                                         DateTime
                                    //                                             .now();
                                    //                                         var selectedDateTime = DateTime(
                                    //                                             now.year,
                                    //                                             now.month,
                                    //                                             now.day,
                                    //                                             selected_time
                                    //                                                 .hour,
                                    //                                             selected_time
                                    //                                                 .minute);
                                    //                                         _alarmTime =
                                    //                                             selectedDateTime;
                                    //                                         setModalState(
                                    //                                                 () {
                                    //                                               _alarmTimeString =
                                    //                                                   DateFormat(
                                    //                                                       'HH:mm')
                                    //                                                       .format(
                                    //                                                       selectedDateTime);
                                    //                                             });
                                    //                                       }
                                    //                                     },
                                    //                                   ),
                                    //                                 ),
                                    //                               ],
                                    //                             ),
                                    //                           ),
                                    //
                                    //                           ListTile(
                                    //                             onTap: () {
                                    //                               showDialog(
                                    //                                 context:
                                    //                                 context,
                                    //                                 builder:
                                    //                                     (BuildContext
                                    //                                 context) {
                                    //                                   double width =
                                    //                                       MediaQuery.of(
                                    //                                           context)
                                    //                                           .size
                                    //                                           .width;
                                    //                                   double
                                    //                                   height =
                                    //                                       MediaQuery.of(
                                    //                                           context)
                                    //                                           .size
                                    //                                           .height;
                                    //                                   return BackdropFilter(
                                    //                                     filter: ImageFilter.blur(
                                    //                                         sigmaX:
                                    //                                         10,
                                    //                                         sigmaY:
                                    //                                         10),
                                    //                                     child: AlertDialog(
                                    //                                         backgroundColor: Colors.transparent,
                                    //                                         contentPadding: EdgeInsets.zero,
                                    //                                         elevation: 0.0,
                                    //                                         // title: Center(child: Text("Evaluation our APP")),
                                    //                                         content: Column(
                                    //                                           mainAxisAlignment:
                                    //                                           MainAxisAlignment.center,
                                    //                                           children: [
                                    //                                             Stack(
                                    //                                               children: [
                                    //                                                 Padding(
                                    //                                                   padding: const EdgeInsets.all(8.0),
                                    //                                                   child: Container(
                                    //                                                     decoration:
                                    //                                                     BoxDecoration(
                                    //                                                       // color: Colors.black.withOpacity(0.65),
                                    //                                                         gradient:
                                    //                                                         LinearGradient(
                                    //                                                           begin: Alignment.centerLeft,
                                    //                                                           end: Alignment.centerRight,
                                    //                                                           // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                                                           colors: [
                                    //                                                             HexColor("#020204").withOpacity(1),
                                    //                                                             HexColor("#36393E").withOpacity(1),
                                    //                                                           ],
                                    //                                                         ),
                                    //                                                         boxShadow: [
                                    //                                                           BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                    //                                                         ],
                                    //                                                         borderRadius: BorderRadius.circular(15)),
                                    //                                                     child: Align(
                                    //                                                         alignment: Alignment.center,
                                    //                                                         child: Padding(
                                    //                                                           padding: const EdgeInsets.all(8.0),
                                    //                                                           child: Column(
                                    //                                                             children: [
                                    //                                                               SizedBox(
                                    //                                                                 height: 0,
                                    //                                                               ),
                                    //
                                    //                                                               Column(
                                    //                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                    //                                                                 children: [
                                    //                                                                   Container(
                                    //                                                                     margin: EdgeInsets.only(left: 18),
                                    //                                                                     child: Text('Title', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                                    //                                                                   ),
                                    //                                                                   SizedBox(
                                    //                                                                     height: 11,
                                    //                                                                   ),
                                    //                                                                   Container(
                                    //                                                                     margin: EdgeInsets.symmetric(horizontal: 10),
                                    //                                                                     // width: 300,
                                    //                                                                     decoration: BoxDecoration(
                                    //                                                                       // color: Colors.black.withOpacity(0.65),
                                    //                                                                         gradient: LinearGradient(
                                    //                                                                           begin: Alignment.centerLeft,
                                    //                                                                           end: Alignment.centerRight,
                                    //                                                                           // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                                                                           colors: [
                                    //                                                                             HexColor("#36393E").withOpacity(1),
                                    //                                                                             HexColor("#020204").withOpacity(1),
                                    //                                                                           ],
                                    //                                                                         ),
                                    //                                                                         boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)],
                                    //                                                                         borderRadius: BorderRadius.circular(20)),
                                    //
                                    //                                                                     child: TextFormField(
                                    //                                                                       maxLength: 150,
                                    //                                                                       decoration: InputDecoration(
                                    //                                                                         contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                                    //                                                                         alignLabelWithHint: false,
                                    //                                                                         isDense: true,
                                    //                                                                         hintText: 'Add alarm title',
                                    //                                                                         counterStyle: TextStyle(
                                    //                                                                           height: double.minPositive,
                                    //                                                                         ),
                                    //                                                                         counterText: "",
                                    //                                                                         filled: true,
                                    //                                                                         border: InputBorder.none,
                                    //                                                                         enabledBorder: const OutlineInputBorder(
                                    //                                                                           borderSide: BorderSide(color: Colors.transparent, width: 1),
                                    //                                                                           borderRadius: BorderRadius.all(Radius.circular(10)),
                                    //                                                                         ),
                                    //                                                                         hintStyle: FontStyleUtility.h14(fontColor: HexColor('#CBCBCB'), family: 'PR'),
                                    //                                                                       ),
                                    //                                                                       style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                    //                                                                       controller: Alarm_title,
                                    //                                                                       keyboardType: TextInputType.text,
                                    //                                                                     ),
                                    //                                                                   ),
                                    //                                                                 ],
                                    //                                                               ),
                                    //                                                               SizedBox(
                                    //                                                                 height: 10,
                                    //                                                               ),
                                    //                                                               GestureDetector(
                                    //                                                                 onTap: () {
                                    //                                                                   setState(() {
                                    //                                                                     Alarm_title_list.add(Alarm_title.text);
                                    //                                                                     Navigator.pop(context);
                                    //                                                                   });
                                    //                                                                 },
                                    //                                                                 child: Container(
                                    //                                                                   alignment: Alignment.topRight,
                                    //                                                                   child: Text(
                                    //                                                                     'Add',
                                    //                                                                     style: FontStyleUtility.h12(fontColor: ColorUtils.primary_grey, family: 'PR'),
                                    //                                                                   ),
                                    //                                                                 ),
                                    //                                                               )
                                    //                                                               // common_button_gold(
                                    //                                                               //   onTap: () {
                                    //                                                               //     Get
                                    //                                                               //         .to(
                                    //                                                               //         DashboardScreen());
                                    //                                                               //   },
                                    //                                                               //   title_text: 'Go to Dashboard',
                                    //                                                               // ),
                                    //                                                             ],
                                    //                                                           ),
                                    //                                                         )),
                                    //                                                   ),
                                    //                                                 ),
                                    //                                                 GestureDetector(
                                    //                                                   onTap: () {
                                    //                                                     Navigator.pop(context);
                                    //                                                   },
                                    //                                                   child: Container(
                                    //                                                     margin: EdgeInsets.only(right: 10),
                                    //                                                     alignment: Alignment.topRight,
                                    //                                                     child: Container(
                                    //                                                         decoration: BoxDecoration(
                                    //                                                           // color: Colors.black.withOpacity(0.65),
                                    //                                                             gradient: LinearGradient(
                                    //                                                               begin: Alignment.centerLeft,
                                    //                                                               end: Alignment.centerRight,
                                    //                                                               // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                                                               colors: [
                                    //                                                                 HexColor("#36393E").withOpacity(1),
                                    //                                                                 HexColor("#020204").withOpacity(1),
                                    //                                                               ],
                                    //                                                             ),
                                    //                                                             boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                                    //                                                             borderRadius: BorderRadius.circular(20)),
                                    //                                                         child: Padding(
                                    //                                                           padding: const EdgeInsets.all(4.0),
                                    //                                                           child: Icon(
                                    //                                                             Icons.cancel_outlined,
                                    //                                                             size: 13,
                                    //                                                             color: ColorUtils.primary_grey,
                                    //                                                           ),
                                    //                                                         )),
                                    //                                                   ),
                                    //                                                 )
                                    //                                               ],
                                    //                                             ),
                                    //                                           ],
                                    //                                         )),
                                    //                                   );
                                    //                                 },
                                    //                               );
                                    //                             },
                                    //                             title: Text('Title',
                                    //                                 style: FontStyleUtility.h14(
                                    //                                     fontColor:
                                    //                                     ColorUtils
                                    //                                         .primary_grey,
                                    //                                     family:
                                    //                                     'PR')),
                                    //                             trailing: const Icon(
                                    //                                 Icons
                                    //                                     .arrow_forward_ios,
                                    //                                 size: 15,
                                    //                                 color: Colors
                                    //                                     .white),
                                    //                           ),
                                    //                           ListTile(
                                    //                             title: Text(
                                    //                               'Repeat',
                                    //                               style: FontStyleUtility.h14(
                                    //                                   fontColor:
                                    //                                   ColorUtils
                                    //                                       .primary_gold,
                                    //                                   family: 'PR'),
                                    //                             ),
                                    //                             trailing:
                                    //                             const Icon(
                                    //                               Icons
                                    //                                   .arrow_forward_ios,
                                    //                               size: 15,
                                    //                               color:
                                    //                               Colors.white,
                                    //                             ),
                                    //                           ),
                                    //                           GestureDetector(
                                    //                             onTap: () {
                                    //                               print('object');
                                    //
                                    //                               showDialog(
                                    //                                 context:
                                    //                                 context,
                                    //                                 builder:
                                    //                                     (BuildContext
                                    //                                 context) {
                                    //                                   double width =
                                    //                                       MediaQuery.of(
                                    //                                           context)
                                    //                                           .size
                                    //                                           .width;
                                    //                                   double
                                    //                                   height =
                                    //                                       MediaQuery.of(
                                    //                                           context)
                                    //                                           .size
                                    //                                           .height;
                                    //                                   return AlertDialog(
                                    //                                       backgroundColor:
                                    //                                       Colors
                                    //                                           .transparent,
                                    //                                       contentPadding:
                                    //                                       EdgeInsets
                                    //                                           .zero,
                                    //                                       elevation:
                                    //                                       0.0,
                                    //                                       // title: Center(child: Text("Evaluation our APP")),
                                    //                                       content:
                                    //                                       Column(
                                    //                                         mainAxisAlignment:
                                    //                                         MainAxisAlignment.center,
                                    //                                         children: [
                                    //                                           Stack(
                                    //                                             children: [
                                    //                                               Container(
                                    //                                                 // height: 150,
                                    //                                                 // height: double.maxFinite,
                                    //                                                 height: MediaQuery.of(context).size.height / 4,
                                    //                                                 width: double.maxFinite,
                                    //                                                 decoration:
                                    //                                                 BoxDecoration(
                                    //                                                   // color: Colors.black.withOpacity(0.65),
                                    //                                                     gradient:
                                    //                                                     LinearGradient(
                                    //                                                       begin: Alignment.centerLeft,
                                    //                                                       end: Alignment.centerRight,
                                    //                                                       // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                                                       colors: [
                                    //                                                         HexColor("#020204").withOpacity(1),
                                    //                                                         HexColor("#36393E").withOpacity(1),
                                    //                                                       ],
                                    //                                                     ),
                                    //                                                     boxShadow: [
                                    //                                                       BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                    //                                                     ],
                                    //                                                     borderRadius: BorderRadius.circular(20)),
                                    //                                                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    //                                                 // height: 122,
                                    //                                                 // width: 133,
                                    //                                                 // padding: const EdgeInsets.all(8.0),
                                    //                                                 child: Column(
                                    //                                                   mainAxisAlignment: MainAxisAlignment.center,
                                    //                                                   children: [
                                    //                                                     Container(
                                    //                                                       // color: Colors.white,
                                    //                                                       alignment: Alignment.center,
                                    //                                                       child: ListView.builder(
                                    //                                                         padding: EdgeInsets.only(bottom: 0),
                                    //
                                    //                                                         // physics: NeverScrollableScrollPhysics(),
                                    //                                                         itemCount: list_alarm.length,
                                    //                                                         shrinkWrap: true,
                                    //                                                         itemBuilder: (BuildContext context, int index) {
                                    //                                                           return GestureDetector(
                                    //                                                             onTap: () {
                                    //                                                               setState(() {
                                    //                                                                 Selected_sound = list_alarm[index];
                                    //                                                                 print("method_selected $Selected_sound");
                                    //                                                               });
                                    //                                                               Navigator.pop(context);
                                    //                                                             },
                                    //                                                             child: Container(
                                    //                                                               margin: EdgeInsets.symmetric(vertical: 8.5),
                                    //                                                               alignment: Alignment.center,
                                    //                                                               child: Text(
                                    //                                                                 list_alarm[index],
                                    //                                                                 style: FontStyleUtility.h15(fontColor: ColorUtils.primary_grey, family: 'PM'),
                                    //                                                               ),
                                    //                                                             ),
                                    //                                                           );
                                    //                                                         },
                                    //                                                       ),
                                    //                                                     ),
                                    //                                                   ],
                                    //                                                 ),
                                    //                                               ),
                                    //                                               GestureDetector(
                                    //                                                 onTap: () {
                                    //                                                   Navigator.pop(context);
                                    //                                                 },
                                    //                                                 child: Container(
                                    //                                                   margin: EdgeInsets.only(right: 0),
                                    //                                                   alignment: Alignment.topRight,
                                    //                                                   child: Container(
                                    //                                                       decoration: BoxDecoration(
                                    //                                                         // color: Colors.black.withOpacity(0.65),
                                    //                                                           gradient: LinearGradient(
                                    //                                                             begin: Alignment.centerLeft,
                                    //                                                             end: Alignment.centerRight,
                                    //                                                             // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                                                             colors: [
                                    //                                                               HexColor("#36393E").withOpacity(1),
                                    //                                                               HexColor("#020204").withOpacity(1),
                                    //                                                             ],
                                    //                                                           ),
                                    //                                                           boxShadow: [BoxShadow(color: HexColor('#04060F'), offset: Offset(0, 3), blurRadius: 5)],
                                    //                                                           borderRadius: BorderRadius.circular(20)),
                                    //                                                       child: Padding(
                                    //                                                         padding: const EdgeInsets.all(4.0),
                                    //                                                         child: Icon(
                                    //                                                           Icons.cancel_outlined,
                                    //                                                           size: 20,
                                    //                                                           color: ColorUtils.primary_grey,
                                    //                                                         ),
                                    //                                                       )),
                                    //                                                 ),
                                    //                                               )
                                    //                                             ],
                                    //                                           ),
                                    //                                         ],
                                    //                                       ));
                                    //                                 },
                                    //                               );
                                    //                             },
                                    //                             child: ListTile(
                                    //                               title: Text(
                                    //                                   'Sound',
                                    //                                   style: FontStyleUtility.h14(
                                    //                                       fontColor:
                                    //                                       ColorUtils
                                    //                                           .primary_gold,
                                    //                                       family:
                                    //                                       'PR')),
                                    //                               trailing: const Icon(
                                    //                                   Icons
                                    //                                       .arrow_forward_ios,
                                    //                                   size: 15,
                                    //                                   color: Colors
                                    //                                       .white),
                                    //                             ),
                                    //                           ),
                                    //                           GestureDetector(
                                    //                             onTap: () async {
                                    //                               if (Alarm_title
                                    //                                   .text
                                    //                                   .isEmpty) {
                                    //                                 CommonWidget()
                                    //                                     .showErrorToaster(
                                    //                                     msg:
                                    //                                     "Enter Alarm title");
                                    //                                 return;
                                    //                               } else {
                                    //                                 await onSaveAlarm();
                                    //                               }
                                    //                             },
                                    //                             child: Container(
                                    //                               width: MediaQuery.of(
                                    //                                   context)
                                    //                                   .size
                                    //                                   .width /
                                    //                                   3,
                                    //                               decoration: BoxDecoration(
                                    //                                   borderRadius:
                                    //                                   BorderRadius
                                    //                                       .circular(
                                    //                                       30),
                                    //                                   border: Border.all(
                                    //                                       color: ColorUtils
                                    //                                           .primary_grey,
                                    //                                       width:
                                    //                                       1)),
                                    //                               child: Padding(
                                    //                                 padding: const EdgeInsets
                                    //                                     .symmetric(
                                    //                                     vertical:
                                    //                                     12.0,
                                    //                                     horizontal:
                                    //                                     8),
                                    //                                 child: Row(
                                    //                                   mainAxisAlignment:
                                    //                                   MainAxisAlignment
                                    //                                       .center,
                                    //                                   children: [
                                    //                                     const Icon(
                                    //                                       Icons
                                    //                                           .alarm,
                                    //                                       color: Colors
                                    //                                           .white,
                                    //                                       size: 25,
                                    //                                     ),
                                    //                                     const SizedBox(
                                    //                                       width: 10,
                                    //                                     ),
                                    //                                     Text(
                                    //                                       'Save',
                                    //                                       style: FontStyleUtility.h16(
                                    //                                           fontColor: ColorUtils
                                    //                                               .primary_gold,
                                    //                                           family:
                                    //                                           'PR'),
                                    //                                     ),
                                    //                                   ],
                                    //                                 ),
                                    //                               ),
                                    //                             ),
                                    //                           )
                                    //                         ],
                                    //                       ),
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //               );
                                    //             },
                                    //           );
                                    //           // scheduleAlarm();
                                    //         },
                                    //         child: Container(
                                    //           decoration: BoxDecoration(
                                    //             // color: Colors.black.withOpacity(0.65),
                                    //               gradient: LinearGradient(
                                    //                 begin: Alignment.centerLeft,
                                    //                 end: Alignment.centerRight,
                                    //                 // stops: [0.1, 0.5, 0.7, 0.9],
                                    //                 colors: [
                                    //                   HexColor("#36393E")
                                    //                       .withOpacity(1),
                                    //                   HexColor("#020204")
                                    //                       .withOpacity(1),
                                    //                 ],
                                    //               ),
                                    //               boxShadow: [
                                    //                 BoxShadow(
                                    //                     color: HexColor('#04060F'),
                                    //                     offset:
                                    //                     const Offset(10, 10),
                                    //                     blurRadius: 20)
                                    //               ],
                                    //               borderRadius:
                                    //               BorderRadius.circular(20)),
                                    //           child: Padding(
                                    //             padding: const EdgeInsets.all(8.0),
                                    //             child: Icon(
                                    //               Icons.add_circle_outline,
                                    //               color: ColorUtils.primary_grey,
                                    //             ),
                                    //           ),
                                    //         )),
                                    //   )
                                    // else
                                    //   const Center(
                                    //       child: Text(
                                    //         'Only 5 alarms allowed!',
                                    //         style: const TextStyle(color: Colors.white),
                                    //       )),
                                  ]).toList(),
                                ),
                              );
                            }
                            return const Center(
                              child: const Text(
                                'Loading..',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                              offset: const Offset(10, 10),
                              blurRadius: 20)
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Kegel Info',
                            style: FontStyleUtility.h16(
                                fontColor: HexColor('#F2F2F2'), family: 'PR'),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Level : $levels',
                            style: FontStyleUtility.h16(
                                fontColor: HexColor('#F2F2F2'), family: 'PR'),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, left: 27, right: 27),
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
                              const SizedBox(
                                height: 17,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => AlarmPage()));
                  //   },
                  //   child: Text('alarm page'),
                  // ),

                  const SizedBox(
                    height: 50,
                  )
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
      elapsedTime = "00";
      watch.start();
      timer = Timer.periodic(
          const Duration(milliseconds: 100),
          (levels == 'Easy ? '
              ? updateTime_Easy
              : (levels == 'Normal' ? updateTime_Normal : updateTime_Easy)));
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
        await Future.delayed(const Duration(milliseconds: 500));
        Vibration.vibrate();
      }
      // Vibrate.defaultVibrationDuration;
      // Vibrate.defaultVibrationDuration;
      // Vibrate.vibrateWithPauses(pauses);
    } else {
      CommonWidget().showErrorToaster(msg: 'Device Cannot vibrate');
    }
  }

  List<String> list_alarm = [
    'clock_alarm_8761',
    'alarm_car_or_home_62554',
    'military_alarm_6380'
  ];
  String Selected_sound = '';

  Future<void> scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      // 'Channel for Alarm notification',
      icon: 'app_icon',
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(Selected_sound),
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
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

  Future<void> onSaveAlarm() async {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now()))
      scheduleAlarmDateTime = _alarmTime!;
    else
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms!.length,
      title: Alarm_title.text,
    );
    _alarmHelper.insertAlarm(alarmInfo);
    await scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Alarm_title.clear();
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
