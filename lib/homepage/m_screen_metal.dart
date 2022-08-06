import 'dart:async';
import 'dart:convert';

import 'dart:ui';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:klench_/homepage/controller/m_screen_controller.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/utils/TexrUtils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/UrlConstrant.dart';
import '../utils/colorUtils.dart';
import '../utils/common_widgets.dart';
import '../utils/page_loader.dart';
import 'm_screen.dart';
import 'model/m_screen_weekly_data_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class M_ScreenMetal extends StatefulWidget {
  const M_ScreenMetal({Key? key}) : super(key: key);

  @override
  State<M_ScreenMetal> createState() => M_ScreenMetalState();
}

class M_ScreenMetalState extends State<M_ScreenMetal>
    with TickerProviderStateMixin {
  final Masturbation_screen_controller _masturbation_screen_controller =
      Get.put(Masturbation_screen_controller(),
          tag: Masturbation_screen_controller().toString());

  Stopwatch watch = Stopwatch();
  Timer? timer;
  bool startStop = true;
  bool started = true;
  bool button_keep = true;

  String elapsedTime = '00:00';
  List method_list = [
    'Sex',
    'Hand',
  ];
  String method_selected = '';
  List<ListMethodClass> method_time = [];

  updateTime(Timer timer) {
    if (watch.isRunning) {
      if (mounted) {
        setState(() {
          // print("startstop Inside=$startStop");
          elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
          percent += 1;
          if (percent >= 100) {
            percent = 0.0;
          }
        });
      }
    }
  }

  final List<ChartData> chartData = [
    ChartData("M", 10, 5, 12),
    ChartData("T", 5, 4, 4),
    ChartData("W", 2, 12, 4),
    ChartData("T", 20, 11, 4),
    ChartData("F", 10, 5, 4),
    ChartData("S", 15, 7, 4),
    ChartData("S", 10, 8, 4),
  ];
  TooltipBehavior? _tooltipBehavior;

  selectdate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: ColorUtils.primary_grey,
              // onPrimary: Colors.black, // <-- SEE HERE
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: ColorUtils.primary_gold,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        showInvoiceDate = DateFormat('MM-dd-yyyy').format(selected).toString();
      });
    }
  }

  DateTime selectedDate = DateTime.now();
  String showInvoiceDate = '';

  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 3);

  @override
  void initState() {
    getdata().then((value) => print("Success"));

    _tooltipBehavior = TooltipBehavior(
        enable: true, borderWidth: 5, color: Colors.transparent);
    super.initState();
  }

  getdata() async {
    print("insssiiiiiii");
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // await _masturbation_screen_controller.MasturbationData_get_API(context);
    await MasturbationWeekly_Data_get_API();
    // });
  }

  bool show_details_graph = false;
  TextEditingController method_new = new TextEditingController();

  double percent = 0.0;
  AnimationController? _animationController;
  Animation? _animation;
  bool animation_started = false;

  start_animation() {
    setState(() {
      animation_started = true;
      print(animation_started);
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 15.0).animate(_animationController!)
      ..addListener(() {});
  }

  @override
  dispose() {
    if (animation_started == true) {
      _animationController!.dispose();
    } // you need this
    print('    stopWatch_finish()');
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
                AssetUtils.m_screen_back,
              ),
            ),
          ),
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
                // Navigator.pop(context);
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
              Textutils.Masturbation,
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
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    height: 20,
                    child: ListView.builder(
                      itemCount: paused_time.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              // stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                HexColor("#34343E").withOpacity(1),
                                HexColor("#8A8B8D").withOpacity(1),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.pause,
                              size: 15,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
                                  color: (animation_started
                                      ? HexColor('#DD3931')
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
                                  'M',
                                  style: TextStyle(
                                      color:
                                          HexColor('#DD3931').withOpacity(0.2),
                                      fontSize: 70,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  elapsedTime,
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
                    onTap: () {
                      print('object');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          double width = MediaQuery.of(context).size.width;
                          double height = MediaQuery.of(context).size.height;
                          return AlertDialog(
                              backgroundColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              elevation: 0.0,
                              // title: Center(child: Text("Evaluation our APP")),
                              content: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        // height: 150,
                                        // height: double.maxFinite,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width: double.maxFinite,
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
                                                  blurRadius: 10)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        // height: 122,
                                        // width: 133,
                                        // padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // color: Colors.white,
                                                alignment: Alignment.center,
                                                child: ListView.builder(
                                                  padding: EdgeInsets.only(
                                                      bottom: 0),

                                                  // physics: NeverScrollableScrollPhysics(),
                                                  itemCount: method_list.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          method_selected =
                                                              method_list[
                                                                  index];
                                                          print(
                                                              "method_selected $method_selected");
                                                          started = true;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8.5),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          method_list[index],
                                                          style: FontStyleUtility.h15(
                                                              fontColor: ColorUtils
                                                                  .primary_grey,
                                                              family: 'PM'),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20, top: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      double width =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width;
                                                      double height =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height;
                                                      return BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 10,
                                                                sigmaY: 10),
                                                        child: AlertDialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            elevation: 0.0,
                                                            // title: Center(child: Text("Evaluation our APP")),
                                                            content: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
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
                                                                                        child: Text('Add more method', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 11,
                                                                                      ),
                                                                                      Container(
                                                                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                                                                        // width: 300,
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
                                                                                                  BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                                                                ],
                                                                                                borderRadius: BorderRadius.circular(20)),

                                                                                        child: TextFormField(
                                                                                          maxLength: 150,
                                                                                          decoration: InputDecoration(
                                                                                            contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                                                                                            alignLabelWithHint: false,
                                                                                            isDense: true,
                                                                                            hintText: 'Add more method',
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
                                                                                          controller: method_new,
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
                                                                                        method_list.add(method_new.text);
                                                                                        method_new.clear();
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
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                10),
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
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    right: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                  )),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      500),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                            colors: [
                                                              HexColor(
                                                                      "#020204")
                                                                  .withOpacity(
                                                                      1),
                                                              HexColor(
                                                                      "#36393E")
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
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 6),
                                                        child: Image.asset(
                                                          AssetUtils.plus_big,
                                                          height: 23,
                                                          width: 10,
                                                          color: HexColor(
                                                              '#606060'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 0),
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.black.withOpacity(0.65),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    // stops: [0.1, 0.5, 0.7, 0.9],
                                                    colors: [
                                                      HexColor("#36393E")
                                                          .withOpacity(1),
                                                      HexColor("#020204")
                                                          .withOpacity(1),
                                                    ],
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                            HexColor('#04060F'),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 5)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.cancel_outlined,
                                                  size: 20,
                                                  color:
                                                      ColorUtils.primary_grey,
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
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      // height: 45,
                      // width:(width ?? 300) ,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            // stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              HexColor("#020204").withOpacity(0.65),
                              HexColor("#151619").withOpacity(0.65),
                              HexColor("#36393E").withOpacity(0.65),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: Text(
                            (method_selected.isNotEmpty
                                ? method_selected
                                : "Select Method"),
                            style: FontStyleUtility.h16(
                                fontColor: ColorUtils.primary_metal,
                                family: 'PM'),
                          )),
                    ),
                  ),
                  // common_button_black(
                  //   // height_: 75,
                  //   onTap: () {
                  //     print('object');
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         double width = MediaQuery.of(context).size.width;
                  //         double height = MediaQuery.of(context).size.height;
                  //         return BackdropFilter(
                  //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  //           child: AlertDialog(
                  //               backgroundColor: Colors.transparent,
                  //               contentPadding: EdgeInsets.zero,
                  //               elevation: 0.0,
                  //               // title: Center(child: Text("Evaluation our APP")),
                  //               content: Column(
                  //                 mainAxisAlignment: MainAxisAlignment.center,
                  //                 children: [
                  //                   Container(
                  //                     margin: EdgeInsets.symmetric(
                  //                         horizontal: 10, vertical: 0),
                  //                     // height: 122,
                  //                     // width: 133,
                  //                     // padding: const EdgeInsets.all(8.0),
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.black,
                  //                         border: Border.all(
                  //                             color: ColorUtils.primary_gold,
                  //                             width: 1),
                  //                         borderRadius: BorderRadius.all(
                  //                             Radius.circular(10.0))),
                  //                     alignment: Alignment.center,
                  //                     child: Stack(
                  //                       children: [
                  //                         Align(
                  //                           alignment: Alignment.center,
                  //                           child: ListView.builder(
                  //                             padding: EdgeInsets.zero,
                  //                             itemCount: method_list.length,
                  //                             shrinkWrap: true,
                  //                             itemBuilder: (BuildContext context,
                  //                                 int index) {
                  //                               return Column(
                  //                                 mainAxisSize: MainAxisSize.min,
                  //                                 children: [
                  //                                   SizedBox(
                  //                                     height: 5,
                  //                                   ),
                  //                                   GestureDetector(
                  //                                     onTap: () {
                  //                                       setState(() {
                  //                                         method_selected =
                  //                                         method_list[index];
                  //                                         print(
                  //                                             "method_selected $method_selected");
                  //                                       });
                  //                                       Navigator.pop(context);
                  //                                     },
                  //                                     child: Container(
                  //                                       alignment: Alignment.center,
                  //                                       child: Text(
                  //                                         method_list[index],
                  //                                         style: FontStyleUtility.h16(
                  //                                             fontColor: ColorUtils
                  //                                                 .primary_gold,
                  //                                             family: 'PM'),
                  //                                       ),
                  //                                     ),
                  //                                   ),
                  //                                   SizedBox(
                  //                                     height: 5,
                  //                                   ),
                  //                                 ],
                  //                               );
                  //                             },
                  //                           ),
                  //                         ),
                  //                         Align(
                  //                           alignment: Alignment.topRight,
                  //                           child: IconButton(
                  //                             onPressed: () {
                  //                               Navigator.pop(context);
                  //                             },
                  //                             icon: Icon(
                  //                               Icons.clear,
                  //                               color: ColorUtils.primary_gold,
                  //                             ),
                  //                           ),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               )),
                  //         );
                  //       },
                  //     );
                  //     // Get.to(DashboardScreen());
                  //   },
                  //   title_text: (method_selected.isNotEmpty
                  //       ? method_selected
                  //       : "Select Method"),
                  // ),
                  const SizedBox(
                    height: 28,
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () async {
                  //           await stopWatch();
                  //           method_time.add(ListMethodClass(
                  //               method_name: method_selected,
                  //               total_time: elapsedTime));
                  //           setState(() {
                  //             elapsedTime = '00:00:00';
                  //             // paused_time.clear();
                  //           });
                  //           print('method_time : ${method_time[0].total_time}');
                  //           print(
                  //               'method_name : ${method_time[0].method_name}');
                  //         },
                  //         child: Container(
                  //           height: 87,
                  //           width: 87,
                  //           decoration: BoxDecoration(
                  //               color: Colors.black,
                  //               border: Border.all(
                  //                   color: ColorUtils.primary_gold, width: 1),
                  //               borderRadius: BorderRadius.circular(100)),
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             child: Text(
                  //               'Finish',
                  //               style: FontStyleUtility.h16(
                  //                   fontColor: ColorUtils.primary_gold,
                  //                   family: 'PR'),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       GestureDetector(
                  //         onTap: () {
                  //           startOrStop();
                  //         },
                  //         child: Container(
                  //           height: 87,
                  //           width: 87,
                  //           decoration: BoxDecoration(
                  //               color: ColorUtils.primary_gold,
                  //               border: Border.all(
                  //                   color: ColorUtils.primary_gold, width: 1),
                  //               borderRadius: BorderRadius.circular(100)),
                  //           child: Container(
                  //             alignment: Alignment.center,
                  //             child: Text(
                  //               (startStop ? 'Start' : 'Pause'),
                  //               style: FontStyleUtility.h16(
                  //                   fontColor: Colors.black, family: 'PR'),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (started == false) {
                            await stopWatch_finish();
                            method_time.add(ListMethodClass(
                                method_name: method_selected,
                                pauses: paused_time.length.toString(),
                                total_time: elapsedTime));
                            setState(() {
                              elapsedTime = '00:00';
                              percent = 0.0;
                              // method_selected = '';
                              watch.reset();
                              paused_time.clear();
                            });
                            print(method_time.length);

                            await _masturbation_screen_controller
                                .m_method_post_API(
                                    context: context, method_data: method_time);
                            // print('method_time : ${method_time[0].total_time}');
                            // print('method_name : ${method_time[0].method_name}');
                          }
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          // width: MediaQuery.of(context).size.width / 3,
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          // height: 45,
                          // width:(width ?? 300) ,
                          decoration: (started
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: ColorUtils.primary_gold, width: 1),
                                  borderRadius: BorderRadius.circular(100))
                              : BoxDecoration(
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
                              borderRadius: BorderRadius.circular(100))),
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                ('Finish'),
                                style: FontStyleUtility.h16(
                                    fontColor:
                                        (started ? Colors.white : Colors.black),
                                    family: 'PM'),
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (method_selected.isNotEmpty) {
                            // if (started) {
                            //   // start_animation();
                            //   startWatch();
                            // } else {
                            //   setState(() {
                            //     startStop = true;
                            //     started = false;
                            //     watch.stop();
                            //     setTime();
                            //   });
                            // }
                            if (startStop) {
                              startWatch();
                              start_animation();
                            } else {
                              stopWatch();
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please select method first",
                              textColor: Colors.white,
                              backgroundColor: Colors.red,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          // width: MediaQuery.of(context).size.width / 3,
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
                              borderRadius: BorderRadius.circular(100)),
                          child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Text(
                                (startStop ? 'Start' : 'Pause'),
                                style: FontStyleUtility.h16(
                                    fontColor: Colors.black, family: 'PM'),
                              )),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 28,
                  // ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     if (method_selected.isNotEmpty) {
                  //       if (started) {
                  //         start_animation();
                  //         startWatch();
                  //       } else {
                  //         await stopWatch_finish();
                  //         method_time.add(ListMethodClass(
                  //             method_name: method_selected,
                  //             pauses: paused_time.length.toString(),
                  //             total_time: elapsedTime));
                  //         setState(() {
                  //           elapsedTime = '00:00';
                  //           percent = 0.0;
                  //           method_selected = '';
                  //           watch.reset();
                  //           paused_time.clear();
                  //         });
                  //         print(method_time.length);
                  //
                  //         await _masturbation_screen_controller
                  //             .m_method_post_API(
                  //                 context: context, method_data: method_time);
                  //         // print('method_time : ${method_time[0].total_time}');
                  //         // print('method_name : ${method_time[0].method_name}');
                  //       }
                  //     } else {
                  //       await Fluttertoast.showToast(
                  //         msg: "Please select method first",
                  //         textColor: Colors.white,
                  //         backgroundColor: Colors.red,
                  //         toastLength: Toast.LENGTH_LONG,
                  //         gravity: ToastGravity.BOTTOM,
                  //       );
                  //     }
                  //   },
                  //   child: Container(
                  //     height: 65,
                  //     margin: EdgeInsets.symmetric(horizontal: 15),
                  //     // height: 45,
                  //     // width:(width ?? 300) ,
                  //     decoration: BoxDecoration(
                  //         color: ColorUtils.primary_gold,
                  //         gradient: LinearGradient(
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //           // stops: [0.1, 0.5, 0.7, 0.9],
                  //           colors: [
                  //             HexColor("#ECDD8F").withOpacity(0.90),
                  //             HexColor("#E5CC79").withOpacity(0.90),
                  //             HexColor("#CE952F").withOpacity(0.90),
                  //           ],
                  //         ),
                  //         borderRadius: BorderRadius.circular(15)),
                  //     child: Container(
                  //         alignment: Alignment.center,
                  //         margin: EdgeInsets.symmetric(
                  //           vertical: 12,
                  //         ),
                  //         child: Text(
                  //           (started ? 'Start' : 'Finish'),
                  //           style: FontStyleUtility.h16(
                  //               fontColor: Colors.black, family: 'PM'),
                  //         )),
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     await _masturbation_screen_controller
                  //         .m_method_post_API(
                  //             context: context, method_data: method_time);
                  //   },
                  //   child: Container(
                  //     height: 65,
                  //     margin: EdgeInsets.symmetric(horizontal: 15),
                  //     // height: 45,
                  //     // width:(width ?? 300) ,
                  //     decoration: BoxDecoration(
                  //         color: ColorUtils.primary_gold,
                  //         gradient: LinearGradient(
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight,
                  //           // stops: [0.1, 0.5, 0.7, 0.9],
                  //           colors: [
                  //             HexColor("#ECDD8F").withOpacity(0.90),
                  //             HexColor("#E5CC79").withOpacity(0.90),
                  //             HexColor("#CE952F").withOpacity(0.90),
                  //           ],
                  //         ),
                  //         borderRadius: BorderRadius.circular(15)),
                  //     child: Container(
                  //         alignment: Alignment.center,
                  //         margin: EdgeInsets.symmetric(
                  //           vertical: 12,
                  //         ),
                  //         child: Text(
                  //           'Add',
                  //           style: FontStyleUtility.h16(
                  //               fontColor: Colors.black, family: 'PM'),
                  //         )),
                  //   ),
                  // ),
                  SizedBox(
                    height: 21,
                  ),
                  Container(
                      child: (paused_time.length > 0
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: 0, top: 0, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.65),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        // stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          HexColor("#020204").withOpacity(0.63),
                                          // HexColor("#151619").withOpacity(0.63),
                                          HexColor("#36393E").withOpacity(0.63),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, top: 20),
                                    child: ListView.builder(
                                      itemCount: paused_time.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Pause ${index + 1}",
                                                style: FontStyleUtility.h15(
                                                    fontColor:
                                                        ColorUtils.primary_grey,
                                                    family: 'PR'),
                                              ),
                                              Text(
                                                paused_time[index],
                                                style: FontStyleUtility.h15(
                                                    fontColor:
                                                        HexColor('#6E6E6E'),
                                                    family: 'PR'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink())),
                  SizedBox(
                    height: 21,
                  ),
                  (method_time.length > 0
                      ? Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                // stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  HexColor("#36393E").withOpacity(0.45),
                                  HexColor("#020204").withOpacity(0.45),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30, top: 8.5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Progress Tracker',
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.primary_gold,
                                      family: 'PMB'),
                                ),
                              ),
                              // SizedBox(
                              //   height: 29,
                              // ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      right: 15, left: 15, top: 15, bottom: 20),
                                  decoration: BoxDecoration(
                                      // color: Colors.black.withOpacity(0.65),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        // stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          HexColor("#020204").withOpacity(0.65),
                                          HexColor("#36393E").withOpacity(0.65),
                                        ],
                                      ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: HexColor('#04060F'),
                                      //       offset: Offset(10, 10),
                                      //       blurRadius: 10)
                                      // ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Method Used',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                    bottom: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Pause',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                )),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 12.0),
                                                  child: Text(
                                                    'Current time',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: method_time.length,
                                        padding: EdgeInsets.zero,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      right: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                      bottom: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                    )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.5),
                                                      child: Text(
                                                        '${method_time[index].method_name}',
                                                        style: FontStyleUtility.h14(
                                                            fontColor: ColorUtils
                                                                .primary_gold,
                                                            family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      right: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                      bottom: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                    )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.5),
                                                      child: Text(
                                                        '${method_time[index].pauses}',
                                                        style: FontStyleUtility.h14(
                                                            fontColor: ColorUtils
                                                                .primary_grey,
                                                            family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.black,
                                                          width: 1),
                                                    )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.5),
                                                      child: Text(
                                                        '${method_time[index].total_time}',
                                                        style: FontStyleUtility
                                                            .h14(
                                                                fontColor:
                                                                    HexColor(
                                                                        '#7A7A7A'),
                                                                family: 'PR'),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      double width =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width;
                                                      double height =
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height;
                                                      return BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                                sigmaX: 10,
                                                                sigmaY: 10),
                                                        child: AlertDialog(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            elevation: 0.0,
                                                            // title: Center(child: Text("Evaluation our APP")),
                                                            content: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
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
                                                                                        child: Text('Add more method', style: FontStyleUtility.h14(fontColor: ColorUtils.primary_grey, family: 'Pr')),
                                                                                      ),
                                                                                      SizedBox(
                                                                                        height: 11,
                                                                                      ),
                                                                                      Container(
                                                                                        margin: EdgeInsets.symmetric(horizontal: 10),
                                                                                        // width: 300,
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
                                                                                                  BoxShadow(color: HexColor('#04060F'), offset: Offset(10, 10), blurRadius: 10)
                                                                                                ],
                                                                                                borderRadius: BorderRadius.circular(20)),

                                                                                        child: TextFormField(
                                                                                          maxLength: 150,
                                                                                          decoration: InputDecoration(
                                                                                            contentPadding: EdgeInsets.only(left: 20, top: 14, bottom: 14),
                                                                                            alignLabelWithHint: false,
                                                                                            isDense: true,
                                                                                            hintText: 'Add more method',
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
                                                                                          controller: method_new,
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
                                                                                        method_list.add(method_new.text);
                                                                                        method_new.clear();
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
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            right:
                                                                                10),
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
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            )),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    right: BorderSide(
                                                        color: Colors.black,
                                                        width: 1),
                                                  )),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4.5),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      500),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .centerLeft,
                                                            end: Alignment
                                                                .centerRight,
                                                            // stops: [0.1, 0.5, 0.7, 0.9],
                                                            colors: [
                                                              HexColor(
                                                                      "#020204")
                                                                  .withOpacity(
                                                                      1),
                                                              HexColor(
                                                                      "#36393E")
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
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 6),
                                                        child: Image.asset(
                                                          AssetUtils.plus_big,
                                                          height: 23,
                                                          width: 10,
                                                          color: HexColor(
                                                              '#606060'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                  right: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.5),
                                                  child: Text(
                                                    '-',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_gold,
                                                        family: 'PR'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border()),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Text(
                                                    '-',
                                                    style: FontStyleUtility.h14(
                                                        fontColor: ColorUtils
                                                            .primary_gold,
                                                        family: 'PR'),
                                                  ),
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

                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'History',
                                            style: FontStyleUtility.h14(
                                                fontColor:
                                                    ColorUtils.primary_gold,
                                                family: 'PR'),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
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
                                                      offset: Offset(3, 3),
                                                      blurRadius: 10)
                                                ]),
                                            child: IconButton(
                                              visualDensity: VisualDensity(
                                                  vertical: -2, horizontal: -2),
                                              onPressed: () {
                                                selectdate(context);
                                              },
                                              iconSize: 15,
                                              icon: Icon(
                                                Icons.calendar_today,
                                                color: ColorUtils.primary_grey,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 250,
                                        child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            plotAreaBorderColor:
                                                ColorUtils.primary_grey,
                                            primaryXAxis: CategoryAxis(
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 3)),
                                            primaryYAxis: NumericAxis(
                                                //Hide the gridlines of y-axis
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 3)),
                                            series: <
                                                ChartSeries<ChartData, String>>[
                                              // Renders column chart

                                              ColumnSeries<ChartData, String>(
                                                  // dataSource: _masturbation_screen_controller.gst_payable_list,
                                                  dataSource: chartData,
                                                  width: 0.5,
                                                  spacing: 0.6,
                                                  color: HexColor('#DD3931'),
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y),
                                              ColumnSeries<ChartData, String>(
                                                  width: 0.5,
                                                  spacing: 0.6,
                                                  color: HexColor('#75C043'),
                                                  // dataSource: _masturbation_screen_controller.gst_payable_list,
                                                  dataSource: chartData,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y1),
                                              ColumnSeries<ChartData, String>(
                                                  width: 0.5,
                                                  spacing: 0.6,
                                                  color: HexColor('#1880C3'),
                                                  dataSource:
                                                      _masturbation_screen_controller
                                                          .gst_payable_list,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y2),
                                            ])),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    // color: Colors.black.withOpacity(0.65),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: HexColor('#04060F'),
                                    //       offset: Offset(10, 10),
                                    //       blurRadius: 10)
                                    // ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                AssetUtils.m_screen_trophy,
                                                height: 25,
                                                width: 20,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Best result',
                                                      style:
                                                          FontStyleUtility.h14(
                                                              fontColor:
                                                                  HexColor(
                                                                      '#A2A2A2'),
                                                              family: 'PR')),
                                                  Text('72 sec',
                                                      style:
                                                          FontStyleUtility.h14(
                                                              fontColor:
                                                                  Colors.white,
                                                              family: 'PR')),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Last measurement',
                                                      style:
                                                          FontStyleUtility.h14(
                                                              fontColor:
                                                                  HexColor(
                                                                      '#A2A2A2'),
                                                              family: 'PR')),
                                                  Text('26 days ago',
                                                      style:
                                                          FontStyleUtility.h14(
                                                              fontColor:
                                                                  Colors.white,
                                                              family: 'PR')),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: HexColor('#181A1F')
                                              .withOpacity(0.65),
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            border: Border.all(
                                                color: HexColor('#383E46'),
                                                width: 1)),
                                        margin: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 12,
                                                  top: 17,
                                                  bottom: 17),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '01 Jan - 31 Dec 2021',
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                            HexColor('#D5D5D5'),
                                                        family: 'PR'),
                                                  ),
                                                  Text(
                                                    'Top result: 40 sec',
                                                    style: FontStyleUtility.h14(
                                                        fontColor:
                                                            HexColor("#66686B"),
                                                        family: 'PR'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height: 250,
                                                child: SfCartesianChart(
                                                    plotAreaBorderWidth: 0,
                                                    plotAreaBorderColor:
                                                        ColorUtils.primary_grey,
                                                    primaryXAxis: CategoryAxis(
                                                        majorGridLines:
                                                            MajorGridLines(
                                                                width: 0),
                                                        isInversed: true,

                                                        //Hide the axis line of y-axis
                                                        axisLine:
                                                            AxisLine(width: 0)),
                                                    primaryYAxis: NumericAxis(
                                                        //Hide the gridlines of y-axis
                                                        opposedPosition: true,
                                                        majorGridLines:
                                                            MajorGridLines(
                                                                width: 1,
                                                                color: HexColor(
                                                                    '#383E46')),
                                                        //Hide the axis line of y-axis
                                                        axisLine:
                                                            AxisLine(width: 0)),
                                                    series: <
                                                        ChartSeries<ChartData,
                                                            String>>[
                                                      // Renders column chart
                                                      ColumnSeries<ChartData,
                                                              String>(
                                                          dataSource: chartData,
                                                          width: 0.5,
                                                          // spacing: 0.6,
                                                          color: HexColor(
                                                              '#F92824'),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    5),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                          ),
                                                          xValueMapper:
                                                              (ChartData data,
                                                                      _) =>
                                                                  data.x,
                                                          yValueMapper:
                                                              (ChartData data,
                                                                      _) =>
                                                                  data.y),
                                                    ])),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 250,
                                decoration: BoxDecoration(
                                    color:
                                        HexColor('#181B23').withOpacity(0.65),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: HexColor('#000000'),
                                    //       offset: Offset(0, 6),
                                    //       blurRadius: 6)
                                    // ],
                                    borderRadius: BorderRadius.circular(100)),
                                margin: EdgeInsets.symmetric(vertical: 7),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected_time = 'days';
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: (selected_time == 'days'
                                                ? HexColor('#21252E')
                                                : Colors.transparent),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 14),
                                            child: Text('Days',
                                                style: FontStyleUtility.h13(
                                                    fontColor: (selected_time ==
                                                            'days'
                                                        ? Colors.white
                                                        : HexColor('#656565')),
                                                    family: 'PM')),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected_time = 'weeks';
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: (selected_time == 'weeks'
                                                  ? HexColor('#21252E')
                                                  : Colors.transparent)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 14),
                                            child: Text('Weeks',
                                                style: FontStyleUtility.h13(
                                                    fontColor: (selected_time ==
                                                            'weeks'
                                                        ? Colors.white
                                                        : HexColor('#656565')),
                                                    family: 'PM')),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected_time = 'months';
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: (selected_time == 'months'
                                                  ? HexColor('#21252E')
                                                  : Colors.transparent)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 14),
                                            child: Text('Months',
                                                style: FontStyleUtility.h13(
                                                    fontColor: (selected_time ==
                                                            'months'
                                                        ? Colors.white
                                                        : HexColor('#656565')),
                                                    family: 'PM')),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    // color: Colors.black.withOpacity(0.65),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      // stops: [0.1, 0.5, 0.7, 0.9],
                                      colors: [
                                        HexColor("#020204").withOpacity(0.65),
                                        HexColor("#36393E").withOpacity(0.65),
                                      ],
                                    ),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //       color: HexColor('#04060F'),
                                    //       offset: Offset(10, 10),
                                    //       blurRadius: 10)
                                    // ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 13, left: 31, bottom: 25),
                                      child: Text(
                                        'Life time',
                                        style: FontStyleUtility.h16(
                                            fontColor: ColorUtils.primary_grey,
                                            family: 'PR'),
                                      ),
                                    ),
                                    Container(
                                        height: 250,
                                        child: SfCartesianChart(
                                            plotAreaBorderWidth: 0,
                                            plotAreaBorderColor:
                                                ColorUtils.primary_grey,
                                            tooltipBehavior: _tooltipBehavior,
                                            primaryXAxis: CategoryAxis(
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 3)),
                                            primaryYAxis: NumericAxis(
                                                //Hide the gridlines of y-axis
                                                majorGridLines:
                                                    MajorGridLines(width: 0),
                                                //Hide the axis line of y-axis
                                                axisLine: AxisLine(width: 3)),
                                            series: <ChartSeries>[
                                              LineSeries<ChartData2, String>(
                                                  dataSource: [
                                                    ChartData2('Jan', 4,
                                                        HexColor('#75C043')),
                                                    ChartData2('Feb', 8,
                                                        HexColor('#75C043')),
                                                    ChartData2('Mar', 4,
                                                        HexColor('#75C043')),
                                                    ChartData2('Apr', 2,
                                                        HexColor('#75C043')),
                                                    ChartData2('May', 4,
                                                        HexColor('#75C043'))
                                                  ],
                                                  // Bind the color for all the data points from the data source
                                                  pointColorMapper:
                                                      (ChartData2 data, _) =>
                                                          data.color,
                                                  xValueMapper:
                                                      (ChartData2 data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData2 data, _) =>
                                                          data.y)
                                            ])),
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      // color: Colors.black.withOpacity(0.65),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        // stops: [0.1, 0.5, 0.7, 0.9],
                                        colors: [
                                          HexColor("#020204").withOpacity(0.65),
                                          HexColor("#36393E").withOpacity(0.65),
                                        ],
                                      ),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //       color: HexColor('#04060F'),
                                      //       offset: Offset(10, 10),
                                      //       blurRadius: 10)
                                      // ],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 40,
                                              top: 15,
                                              right: 15,
                                              bottom: 15),
                                          child: Text(
                                            "Technique",
                                            style: FontStyleUtility.h15(
                                                fontColor:
                                                    ColorUtils.primary_grey,
                                                family: 'PM'),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '1.   Use different tools',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '2.   Try edging',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '3.   Use different tools',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '4.   Try edging',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(
                                          '5.   Use different tools',
                                          style: FontStyleUtility.h15(
                                              fontColor:
                                                  ColorUtils.primary_grey,
                                              family: 'PM'),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      : SizedBox.shrink()),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  // M_ScreenWeeklyDataModel? m_screenWeeklyDataModel;

  // var getUSerModelList = M_ScreenGetModel().obs;
  var x_axis = ["M", "T", "W", "T", "F", "S", "S"];
  List<ChartData> gst_payable_list = [];

  // Future<dynamic> MasturbationWeekly_Data_get_API(BuildContext context) async {
  //   print('Inside creator get email');
  //   showLoader(context);
  //   String id_user = await PreferenceManager().getPref(URLConstants.id);
  //   print("UserID $id_user");
  //   String url =
  //       "${URLConstants.base_url}${URLConstants.masturbation_get_weekly_data}?userId=$id_user";
  //   // debugPrint('Get Sales Token ${tokens.toString()}');
  //   // try {
  //   // } catch (e) {
  //   //   print('1-1-1-1 Get Purchase ${e.toString()}');
  //   // }
  //
  //   try {
  //     http.Response response = await http.get(Uri.parse(url));
  //
  //     print('Response request: ${response.request}');
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var data = convert.jsonDecode(response.body);
  //       m_screenWeeklyDataModel = M_ScreenWeeklyDataModel.fromJson(data);
  //       // getUSerModelList(userInfoModel_email);
  //       if (m_screenWeeklyDataModel!.error == false) {
  //         hideLoader(context);
  //         debugPrint(
  //             '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenWeeklyDataModel!.data!.length}');
  //         // CommonWidget().showToaster(msg: breathingGetModel!.message!);
  //         // CommonWidget().showToaster(msg: data["success"].toString());
  //         // await Get.to(Dashboard());
  //         CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //
  //         // for (var i = 0; i < m_screenWeeklyDataModel!.data!.length; i++) {
  //         //   // x_axis = data_sales[i]["month"];
  //         //   var y1 = double.parse(
  //         //       m_screenWeeklyDataModel!.data![0].methods![i].totalTime!);
  //         //   // var y2 = data_gst_receivable[i]['value'];
  //         //   // var y3 =
  //         //   gst_payable_list.add(ChartData(
  //         //     x_axis[i],
  //         //     y1,
  //         //     y1,
  //         //     y1,
  //         //   ));
  //         // }
  //
  //         return m_screenWeeklyDataModel;
  //       } else {
  //         hideLoader(context);
  //
  //         CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //         return null;
  //       }
  //     } else if (response.statusCode == 422) {
  //       hideLoader(context);
  //       CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //     } else if (response.statusCode == 401) {
  //       hideLoader(context);
  //       CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
  //     } else {
  //       // CommonWidget().showToaster(msg: msg.toString());
  //     }
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     // TODO
  //   }
  // }

  String selected_time = 'days';

  startOrStop() {
    if (startStop) {
      startWatch();
    } else {
      stopWatch();
    }
  }

  final Ledger_Setup_controller _swipe_setup_controller = Get.put(
      Ledger_Setup_controller(),
      tag: Ledger_Setup_controller().toString());

  startWatch() {
    setState(() {
      _swipe_setup_controller.m_running = true;
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
      _swipe_setup_controller.m_running = false;
      startStop = true;
      started = true;
      _animationController!.stop();
      animation_started = false;
      watch.stop();
      setTime_finish();
    });
  }

  List paused_time = [];

  setTime() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
      paused_time.add(elapsedTime);
    });
    print("elapsedTime $elapsedTime");
    print("elapsedTime Listtttttt $paused_time");
  }

  setTime_finish() {
    var timeSoFar = watch.elapsedMilliseconds;
    setState(() {
      elapsedTime = transformMilliSeconds(timeSoFar);
    });
    // paused_time.add(elapsedTime);
    // print("elapsedTime $elapsedTime");
    // print("elapsedTime Listtttttt $paused_time");
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

  M_ScreenWeeklyDataModel? m_screenWeeklyDataModel;

  Future MasturbationWeekly_Data_get_API() async {
    String id_user = await PreferenceManager().getPref(URLConstants.id);
    var url =
        "${URLConstants.base_url}${URLConstants.masturbation_get_weekly_data}?userId=$id_user";

    try {
      showLoader(context);
      var response = await http.get(Uri.parse(url));
      print(response.body);
      print(response.request);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // var data = convert.jsonDecode(response.body);
        Map<String, dynamic> data =
            json.decode(response.body.replaceAll('}[]', '}'));
        print("Data :${data}");
        m_screenWeeklyDataModel = M_ScreenWeeklyDataModel.fromJson(data);
        // getUSerModelList(userInfoModel_email);
        if (m_screenWeeklyDataModel!.error == false) {
          hideLoader(context);
          debugPrint(
              '2-2-2-2-2-2 Inside the Get UserInfo Controller Details ${m_screenWeeklyDataModel!.data!.length}');
          // CommonWidget().showToaster(msg: breathingGetModel!.message!);
          // CommonWidget().showToaster(msg: data["success"].toString());
          // await Get.to(Dashboard());
          CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);

          // for (var i = 0; i < m_screenWeeklyDataModel!.data!.length; i++) {
          //   // x_axis = data_sales[i]["month"];
          //   var y1 = double.parse(
          //       m_screenWeeklyDataModel!.data![0].methods![i].totalTime!);
          //   // var y2 = data_gst_receivable[i]['value'];
          //   // var y3 =
          //   gst_payable_list.add(ChartData(
          //     x_axis[i],
          //     y1,
          //     y1,
          //     y1,
          //   ));
          // }

          return m_screenWeeklyDataModel;
        } else {
          hideLoader(context);

          CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
          return null;
        }
      } else if (response.statusCode == 422) {
        hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else if (response.statusCode == 401) {
        hideLoader(context);
        CommonWidget().showToaster(msg: m_screenWeeklyDataModel!.message!);
      } else {
        // CommonWidget().showToaster(msg: msg.toString());
      }
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
  }
}
