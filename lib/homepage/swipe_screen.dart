import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/homepage/kegel_screen.dart';
import 'package:klench_/homepage/m_screen.dart';
import 'package:klench_/homepage/pee_screen.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/homepage/warmpUp_screen.dart';
import 'package:klench_/utils/common_widgets.dart';

import 'm_screen_metal.dart';

class SwipeScreen extends StatefulWidget {
  final int PageNo;

  const SwipeScreen({Key? key, required this.PageNo}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  PageController? _pageController_customer;
  Duration pageTurnDuration = Duration(milliseconds: 500);
  Curve pageTurnCurve = Curves.ease;

  final ValueNotifier<int> buildCount = ValueNotifier<int>(0);

  final Ledger_Setup_controller _ledgerScreenSetup_customer_Controller =
      Get.put(Ledger_Setup_controller(),
          tag: Ledger_Setup_controller().toString());

  List<Widget> widget_list = [
    KegelScreen(),
    M_ScreenMetal(),
    PeeScreen(),
    WarmUpScreen(),
  ];

  @override
  void initState() {
    _pageController_customer =
        PageController(initialPage: widget.PageNo, keepPage: false);
  }

  @override
  void dispose() {
    _pageController_customer!.dispose();
    super.dispose();
  }

  void _goForward() {
    _pageController_customer?.nextPage(
        duration: pageTurnDuration, curve: pageTurnCurve);
  }

  void _goBack() {
    _pageController_customer!
        .previousPage(duration: pageTurnDuration, curve: pageTurnCurve);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ledger_Setup_controller>(
      init: _ledgerScreenSetup_customer_Controller,
      builder: (_) {
        return GestureDetector(
          onHorizontalDragEnd: (dragEndDetails) {
            if (dragEndDetails.primaryVelocity! < 0) {
              // Page forwards
              if (_ledgerScreenSetup_customer_Controller.m_running != true) {
                _goForward();
                print('Move page forwards');
              } else {
                CommonWidget()
                    .showErrorToaster(msg: 'Please finish the method');
              }
            } else if (dragEndDetails.primaryVelocity! > 0) {
              // Page backwards
              if (_ledgerScreenSetup_customer_Controller.m_running != true) {
                print('Move page backwards');
                _goBack();
              } else {
                CommonWidget()
                    .showErrorToaster(msg: 'Please finish the method');
              }
            }
          },
          child: PageView.builder(
            onPageChanged: (page) {
              print('PageChanged $page');
              // _pageController_customer!.dispose();
              if (_ledgerScreenSetup_customer_Controller.m_running == true) {
                // M_ScreenMetalState().stopWatch_finish();
                CommonWidget().showErrorToaster(msg: 'Finish method first');
              }
              print('helo ${_ledgerScreenSetup_customer_Controller.m_running}');
            },
            itemBuilder: (context, int index) {
              return Center(
                child: widget_list[index % widget_list.length],
              );
            },
            controller: _pageController_customer,
            physics: NeverScrollableScrollPhysics(),
            // children: [
            //   KegelScreen(),
            //   WarmUpScreen(),
            //   M_ScreenMetal(),
            //   PeeScreen()
            // ],
          ),
        );
      },
    );
  }
}
