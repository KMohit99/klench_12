import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../front_page/FrontpageScreen.dart';
import '../utils/Asset_utils.dart';
import '../utils/Common_buttons.dart';
import '../utils/Common_container_color.dart';
import '../utils/Common_textfeild.dart';
import '../utils/TexrUtils.dart';
import '../utils/TextStyle_utils.dart';
import '../utils/colorUtils.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  int selectedCard = -1;
  List difficulty = ['very easy', 'easy' , 'normal' , 'hard' , '∞'];
  List<String> gender_list = <String>['Male', 'Female', 'Prefer not say'];
  String? selected_gender;

  DateTime selectedDate = DateTime.now();
  String showInvoiceDate = '';
  TextEditingController dobcontroller = new TextEditingController();
  TextEditingController gender_controller = new TextEditingController();
  selectDoB(BuildContext context) async {
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
        dobcontroller.text = showInvoiceDate.toString();
      });
    }
  }

  select_gender(BuildContext context) {
    return
      showDialog(
        context: context,
        builder: (BuildContext context) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height;
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                elevation: 0.0,
                // title: Center(child: Text("Evaluation our APP")),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:<Widget> [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 180,
                              width: 220,
                              decoration: BoxDecoration(
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
                                  horizontal: 10, vertical: 0),
                              // height: 122,
                              // width: 133,
                              // padding: const EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child:

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Selece Gender",
                                        style: FontStyleUtility.h15(
                                            fontColor: Colors.white,
                                            family: 'PM'),
                                      ),
                                      ListView.builder(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 0),
                                        itemCount: gender_list.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context,
                                            int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selected_gender = gender_list[index];
                                                gender_controller.text = selected_gender!;
                                                print(
                                                    "method_selected $selected_gender");
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.5),
                                                  alignment:
                                                  Alignment.center,
                                                  child: Text(
                                                    gender_list[index],
                                                    style: FontStyleUtility.h15(
                                                        fontColor: ColorUtils
                                                            .primary_grey,
                                                        family: 'PM'),
                                                  ),
                                                ),
                                                Radio(
                                                  visualDensity: VisualDensity(vertical: -4,horizontal: -4),

                                                  value: gender_list[index],
                                                  groupValue: selected_gender,
                                                  activeColor: ColorUtils.primary_gold,
                                                  onChanged: (val) {
                                                    print("Radio $val");
                                                    setState((){
                                                      selected_gender = val as String?;
                                                    });
                                                  },
                                                ),

                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
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
                                    size: 13,
                                    color:
                                    ColorUtils.primary_grey,
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
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          Textutils.myprofile,
          style: FontStyleUtility.h16(
              fontColor: ColorUtils.primary_gold, family: 'PM'),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor("#36393E").withOpacity(1),
                  HexColor("#020204").withOpacity(1),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: HexColor('#2A2A29'),
              //     offset: Offset(10, 10),
              //     blurRadius: 20,
              //   ),
              // ],
              borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 0, right: 8, left:8  ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                        color: ColorUtils.light_black,
                                        offset: Offset(5,5),
                                        blurRadius: 6
                                    )
                                  ]
                              ),
                              child: Image.asset(
                                AssetUtils.user_icon2,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Positioned(
                              bottom: 2,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                      colors: [HexColor('#36393E'),HexColor('#020204'), ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,

                                    ),

                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.camera_alt,color: ColorUtils.primary_gold,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  colors: [HexColor('#36393E'),HexColor('#020204'), ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,

                                ),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor('#04060F'),
                                offset: Offset(10,10),
                                blurRadius: 20
                              )
                            ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 18),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5,right: 5),
                                    child: Text(
                                      'Edit',
                                      style: FontStyleUtility.h12(
                                          fontColor: ColorUtils.primary_gold, family: 'PM'),
                                    ),
                                  ),

                                  Container(
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: ColorUtils.primary_gold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),

                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          HexColor("#36393E").withOpacity(1),
                          HexColor("#020204").withOpacity(1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#2A2A29'),
                          offset: Offset(10, 10),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Container(
                          child: CommonTextFormField(
                            labelText: Textutils.name_,

                            iconData: IconButton(
                              visualDensity: VisualDensity(horizontal: -4,vertical: -4),

                              icon: Image.asset(
                                AssetUtils.signIN_user_icon,
                                height: 17,
                                width: 15,
                                color: HexColor("#606060"),

                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            labelText: Textutils.phone_,
                            iconData: IconButton(
                              visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                              icon: Image.asset(
                                AssetUtils.mobile_icons,
                                height: 17,
                                color: HexColor("#606060"),

                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            labelText: Textutils.email_,
                            iconData: IconButton(
                              visualDensity: VisualDensity(horizontal: -4,vertical: -4),

                              icon:  Image.asset(
                                AssetUtils.message_icons,
                                color: HexColor("#606060"),

                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: CommonTextFormField(
                            labelText: Textutils.dob_,
                            readOnly: true,
                            controller: dobcontroller,
                            tap: (){
                              selectDoB(context);
                            },
                            iconData: IconButton(
                              visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                              icon:  Image.asset(
                                AssetUtils.date_icons,
                                color: HexColor("#606060"),
                                height: 17,
                                width: 15,
                              ),
                              onPressed: () {
                                selectDoB(context);

                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // Container(
                        //   width: screenWidth,
                        //   decoration: BoxDecoration(
                        //     // color: Colors.black.withOpacity(0.65),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.centerLeft,
                        //         end: Alignment.centerRight,
                        //         // stops: [0.1, 0.5, 0.7, 0.9],
                        //         colors: [
                        //           HexColor("#36393E").withOpacity(1),
                        //           HexColor("#020204").withOpacity(1),
                        //         ],
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: HexColor('#04060F'),
                        //           offset: Offset(10, 10),
                        //           blurRadius: 20,
                        //         ),
                        //       ],
                        //       borderRadius: BorderRadius.circular(10)),
                        //   child: FormField<String>(
                        //     builder: (FormFieldState<String> state) {
                        //       return DropdownButtonHideUnderline(
                        //         child: DropdownButton2(
                        //           isExpanded: true,
                        //           hint: Row(
                        //             children: [
                        //               SizedBox(
                        //                 width: 4,
                        //               ),
                        //               Expanded(
                        //                 child: Text(
                        //                   'Select gender',
                        //                   style: FontStyleUtility.h15(
                        //                       fontColor: ColorUtils.primary_grey,
                        //                       family: 'PM'),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           items: data
                        //               .map((item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Text(
                        //               item,
                        //               textAlign: TextAlign.center,
                        //               style: FontStyleUtility.h15(
                        //                   fontColor:
                        //                   ColorUtils.primary_grey,
                        //                   family: 'PM'),
                        //               overflow: TextOverflow.ellipsis,
                        //             ),
                        //           ))
                        //               .toList(),
                        //           value: selected_gender,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               selected_gender = value as String;
                        //             });
                        //             // print(contactdetailsController
                        //             //     .selectedValue);
                        //           },
                        //           iconSize: 25,
                        //           isDense: true,
                        //
                        //           icon: Image.asset(
                        //             AssetUtils.arrow_down_icons,
                        //             color: HexColor("#606060"),
                        //             height: 13,
                        //             width: 13,
                        //           ),
                        //
                        //           iconEnabledColor: Color(0xff007DEF),
                        //           iconDisabledColor: Color(0xff007DEF),
                        //           buttonHeight: 50,
                        //           buttonWidth: 160,
                        //           style: FontStyleUtility.h16(
                        //               fontColor: ColorUtils.primary_gold,
                        //               family: 'PM'),
                        //           buttonPadding:
                        //           const EdgeInsets.only(left: 15, right: 15),
                        //           buttonDecoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(10),
                        //               color: Colors.transparent),
                        //           buttonElevation: 0,
                        //           itemHeight: 40,
                        //           itemPadding:
                        //           const EdgeInsets.only(left: 14, right: 14),
                        //           dropdownMaxHeight: 200,
                        //           // dropdownWidth: 200,
                        //           dropdownPadding: null,
                        //           dropdownDecoration: BoxDecoration(
                        //             // color: Colors.black.withOpacity(0.65),
                        //               gradient: LinearGradient(
                        //                 begin: Alignment.centerLeft,
                        //                 end: Alignment.centerRight,
                        //                 // stops: [0.1, 0.5, 0.7, 0.9],
                        //                 colors: [
                        //                   HexColor("#020204").withOpacity(1),
                        //                   HexColor("#36393E").withOpacity(1),
                        //                 ],
                        //               ),
                        //               boxShadow: [
                        //                 BoxShadow(
                        //                   color: HexColor('#04060F'),
                        //                   offset: Offset(10,10),
                        //                   blurRadius: 20,
                        //                 ),
                        //               ],
                        //               borderRadius: BorderRadius.circular(10)),
                        //           dropdownElevation: 20,
                        //           scrollbarRadius: const Radius.circular(40),
                        //           scrollbarThickness: 6,
                        //           scrollbarAlwaysShow: true,
                        //           offset: const Offset(0, -5),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        Container(
                          child: CommonTextFormField(
                            labelText: 'Gender',
                            controller: gender_controller,
                            tap: () {
                              select_gender(context);
                            },
                            readOnly: true,
                            iconData: IconButton(
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              icon:  Image.asset(
                                AssetUtils.arrow_down_icons,
                                color: HexColor("#606060"),
                                height: 13,
                                width: 13,
                              ),
                              onPressed: () {
                                select_gender(context);
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          HexColor("#36393E").withOpacity(1),
                          HexColor("#020204").withOpacity(1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#2A2A29'),
                          offset: Offset(10, 10),
                          blurRadius: 20,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0,left: 32),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Level',
                            style: FontStyleUtility.h15(
                                fontColor: Colors.white, family: 'PM'),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: screenWidth,
                          height: 140,
                          child: GridView.builder(
                            padding: EdgeInsets.symmetric(vertical: 0),
                              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio:( MediaQuery.of(context).size.width /0.8)/
                                      (MediaQuery.of(context).size.height / 4),
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 10),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: difficulty.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // ontap of each card, set the defined int to the grid view index
                                      selectedCard = index;
                                    });
                                  },
                                  child: SizedBox(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      // decoration: BoxDecoration(
                                      //     color: (selectedCard == index
                                      //         ? ColorUtils.primary_gold
                                      //         : Colors.black),
                                      //     borderRadius: BorderRadius.circular(10),
                                      //     border: Border.all(
                                      //         color: ColorUtils.primary_gold, width: 1)),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              HexColor("#36393E").withOpacity(1),
                                              HexColor("#020204").withOpacity(1),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: HexColor('#04060F'),
                                              offset: Offset(10, 10),
                                              blurRadius: 10,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(15)),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          difficulty[index],
                                          style: FontStyleUtility.h15(
                                              fontColor: (selectedCard == index
                                                  ? ColorUtils.primary_gold
                                                  : ColorUtils.primary_grey),
                                              family: 'PM'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        Container(
                          child: Text(
                            'Short descriptions regarding each level',
                            style: FontStyleUtility.h15(
                                fontColor: Colors.white, family: 'PM'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50,)


              ],
            ),
          ),
        ),
      ),
    );
  }
}
