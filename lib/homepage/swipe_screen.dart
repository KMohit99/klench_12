import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:klench_/homepage/kegel_screen.dart';
import 'package:klench_/homepage/m_screen.dart';
import 'package:klench_/homepage/pee_screen.dart';
import 'package:klench_/homepage/swipe_controller.dart';
import 'package:klench_/homepage/warmpUp_screen.dart';

import 'm_screen_metal.dart';

class SwipeScreen extends StatefulWidget {
  final int PageNo;
  const SwipeScreen({Key? key, required this.PageNo}) : super(key: key);

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  PageController? _pageController_customer;
  final Ledger_Setup_controller _ledgerScreenSetup_customer_Controller =
  Get.put(Ledger_Setup_controller(),tag: Ledger_Setup_controller().toString());


  @override
  void initState() {
    _pageController_customer = PageController(initialPage: widget.PageNo, keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Ledger_Setup_controller>(
      init: _ledgerScreenSetup_customer_Controller,
      builder: (_) {
        return Container(
          child: PageView(
            controller: _pageController_customer,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              KegelScreen(),
              WarmUpScreen(),
              M_ScreenMetal(),
              PeeScreen()
            ],
          ),
        );
      },
    );
  }
}
