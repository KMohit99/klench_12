import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/homepage/controller/pee_screen_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibration/vibration.dart';

import '../utils/Asset_utils.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import 'model/pee_get_model.dart';

class PeeScreen extends StatefulWidget {
  const PeeScreen({Key? key}) : super(key: key);

  @override
  State<PeeScreen> createState() => _PeeScreenState();
}

class _PeeScreenState extends State<PeeScreen> with TickerProviderStateMixin {
  final PeeScreenController _peeScreenController =
      Get.put(PeeScreenController(), tag: PeeScreenController().toString());

  List urine_test_text = [
    "Doing ok. You’re probably well hydrated. Drink water as normal.",
    "You’re just fine. You could stand to drink a little water now, maybe a small glass of water.",
    "Drink about 1⁄2 bottle of water (1/4 liter) right now, or drink a whole bottle (1/2 liter) of water if you’re outside and/or sweating.",
    "Drink about 1⁄2 bottle of water (1/4 liter) within the hour, or drink a whole bottle (1/2 liter) of water if you’re outside and/or sweating.",
    "Drink 2 bottles of water right now (1 liter). If your urine is darker than this and/or red or brown, then dehydration may not be your problem. See a doctor.",
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
            Future.delayed(const Duration(seconds: 4), () {
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

  String? selected_date_sets = '';
  String? selected_date = '';
  double percent = 0.0;

  bool back_wallpaper = true;

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 3);

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
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 25.0).animate(_animationController!)
      ..addListener(() {});

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

  @override
  dispose() {
    if(animation_started == true) {
      _animationController!.dispose();
    } // you need this
    super.dispose();
  }

  @override
  void initState() {
    // get_saved_data();
    getdata();
    super.initState();
  }

  getdata() async {
      // await _masturbation_screen_controller.MasturbationData_get_API(context);
      levels = await PreferenceManager().getPref(URLConstants.levels);
      print('Inside');
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _peeScreenController.Pee_get_API(context);
      });
  }

  get_saved_data() async {
    levels = await PreferenceManager().getPref(URLConstants.levels);
    print("Levels $levels");
    setState(() {});
  }

  pop() {
    print("no data found");
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
                (back_wallpaper ?
                const BoxDecoration(
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
                    : CommonWidget().showErrorToaster(msg: "Please finish the method"));
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
              margin: const EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  AvatarGlow(
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
                            image: const DecorationImage(
                                alignment: Alignment.center,
                                image:
                                    const AssetImage(AssetUtils.home_button)),
                            boxShadow: [
                              BoxShadow(
                                color: (animation_started
                                    ? HexColor('#F5C921')
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
                                'P',
                                style: TextStyle(
                                    color: HexColor('#F5C921').withOpacity(0.2),
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

                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (started) {
                        back_wallpaper = false;

                        start_animation();
                        startWatch();
                      } else {
                        await stopWatch_finish();

                        _peeScreenController.sets++;
                        await _peeScreenController.Pee_post_API(context);

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
                    height: 28,
                  ),

                  Obx(() => _peeScreenController.isLoading.value == false
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

                                todayTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.white),
                                todayDecoration: BoxDecoration(
                                    color: Colors.orange,
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
                                    // fontWeight: FontWeight.normal,
                                    fontSize: 16.0,
                                    fontFamily: 'PM',
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
                                      fontSize: 14.0,
                                      color: Colors.white),
                                  weekendStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
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
                              calendarBuilders: CalendarBuilders(
                                markerBuilder:
                                    (BuildContext context, date, events) {
                                  for (var i = 0;
                                      i <
                                          _peeScreenController
                                              .peeGetModel!.data!.length;
                                      i++) {
                                    if (DateFormat('yyyy-MM-dd').format(date) ==
                                        _peeScreenController.peeGetModel!
                                            .data![i].createdDate) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected_date_sets =
                                                _peeScreenController
                                                    .peeGetModel!
                                                    .data![i]
                                                    .sets!;
                                            selected_date = _peeScreenController
                                                .peeGetModel!
                                                .data![i]
                                                .createdDate!;
                                          });
                                          print(selected_date_sets);
                                          print(selected_date);
                                        },
                                        child: Container(
                                          height:40,
                                          width: 40,
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
                              'User peed ${selected_date_sets} time on ${selected_date}',
                              style: FontStyleUtility.h16(
                                  fontColor: HexColor('#FFFFFF'), family: 'PM'),
                            ),
                          ),
                        )),
                  const SizedBox(
                    height: 10,
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
                          margin: const EdgeInsets.only(top: 8, left: 27),
                          child: Text(
                            'Pee Info',
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
                        Container(
                          margin: const EdgeInsets.only(
                              top: 0, left: 27, right: 27),
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
                              const SizedBox(
                                height: 17,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
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
                                    offset: const Offset(10, 10),
                                    blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 24, top: 14),
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
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 15),
                                  physics: const NeverScrollableScrollPhysics(),
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
                                                offset: const Offset(10, 10),
                                                blurRadius: 20)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      margin: const EdgeInsets.symmetric(
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
                                            const SizedBox(
                                              width: 9,
                                            ),
                                            Container(
                                              child: Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Text(
                                                    urine_test_text[index],
                                                    maxLines: 3,
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: FontStyleUtility.h13(
                                                        fontColor: Colors.white,
                                                        family: 'PR'),
                                                  ),
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
                          margin: const EdgeInsets.only(
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
                                    offset: const Offset(10, 10),
                                    blurRadius: 20)
                              ],
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 24, top: 14),
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
                                  padding: const EdgeInsets.only(
                                      top: 25, bottom: 15),
                                  physics: const NeverScrollableScrollPhysics(),
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
                                                offset: const Offset(10, 10),
                                                blurRadius: 20)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      margin: const EdgeInsets.symmetric(
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
                                            const SizedBox(
                                              width: 9,
                                            ),
                                            Container(
                                              child: Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 5),
                                                  child: Text(
                                                    urine_test_text[index],
                                                    maxLines: 3,
                                                    textAlign: TextAlign.left,
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: FontStyleUtility.h13(
                                                        fontColor: Colors.white,
                                                        family: 'PR'),
                                                  ),
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
      timer =
          Timer.periodic(const Duration(milliseconds: 100), updateTime_normal);
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
