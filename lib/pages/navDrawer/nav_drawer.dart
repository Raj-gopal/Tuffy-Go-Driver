import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/outstation.dart';
import 'package:flutter_driver/pages/NavigatorPages/settings.dart';
import 'package:flutter_driver/pages/NavigatorPages/support.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../NavigatorPages/bankdetails.dart';
import '../NavigatorPages/driverdetails.dart';
import '../NavigatorPages/driverearnings.dart';
import '../NavigatorPages/editprofile.dart';
import '../NavigatorPages/history.dart';
import '../NavigatorPages/makecomplaint.dart';
import '../NavigatorPages/managevehicles.dart';
import '../NavigatorPages/myroutebookings.dart';
import '../NavigatorPages/notification.dart';
import '../NavigatorPages/referral.dart';
import '../NavigatorPages/sos.dart';
import '../NavigatorPages/walletpage.dart';
import '../login/landingpage.dart';
import '../login/login.dart';
import '../onTripPage/map_page.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  dynamic isCompleted;
  bool showFilter = false;
  // ignore: unused_field
  final bool _isLoading = false;
  // ignore: unused_field
  final String _error = '';
  List myHistory = [];
  navigateLogout() {
    if (ownermodule == '1') {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
            (route) => false);
      });
    } else {
      ischeckownerordriver = 'driver';
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      });
    }
  }

  @override
  void initState() {
    historyFiltter = '';
    if (userDetails['chat_id'] != null && chatStream == null) {
      streamAdminchat();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: valueNotifierHome.value,
        builder: (context, value, child) {
          return SizedBox(
            height: media.height,
            width: media.width * 0.8,
            child: Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                color: Colors.white,
                child: Container(
                  height: media.height,
                  width: media.width * 0.8,
                  decoration:
                      BoxDecoration(color: page, boxShadow: [boxshadow]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.width * 0.05 +
                            MediaQuery.of(context).padding.top,
                      ),
                      InkWell(
                        onTap: () async {
                          var val = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()));
                          if (val) {
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(media.width * 0.025),
                          width: media.width * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: media.width * 0.15,
                                height: media.width * 0.15,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            userDetails['profile_picture']),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: media.width * 0.025,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: userDetails['name'],
                                    size: media.width * fourteen,
                                    fontweight: FontWeight.w600,
                                    maxLines: 1,
                                  ),
                                  MyText(
                                    text: userDetails['mobile'],
                                    size: media.width * fourteen,
                                    fontweight: FontWeight.w500,
                                    maxLines: 1,
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: media.width * 0.025,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: media.width * 0.04,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),

                      // SizedBox(height: media.width*0.05,),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left:16.0,top: 16),
                              child: InkWell(
                                onTap: ()  {
                                  // Fluttertoast.showToast(
                                  //     msg: "Currently Unavailable",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: Colors.red,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0
                                  // );
                                },
                                  child: Column(
                                    children: [
                                      if (userDetails['pro'] == 1)
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  media.width * 0.01,
                                                  media.width * 0.025,
                                                  media.width * 0.025,
                                                  media.width * 0.025
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.car_detailed,
                                                    color: textColor.withOpacity(0.8),
                                                  ),
                                                  SizedBox(
                                                    width: media.width * 0.025,
                                                  ),
                                                  ShowUp(
                                                    delay: 200,
                                                    child: SizedBox(
                                                      width: media.width * 0.45,
                                                      child: MyText(
                                                        text: 'Pro Driver',
                                                        overflow: TextOverflow.ellipsis,
                                                        size: media.width * sixteen,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            MyText(
                                              text: 'Active',
                                              overflow: TextOverflow.ellipsis,
                                              size: media.width * sixteen,
                                              color: Colors.white,
                                            ),

                                          ],
                                        ),
                                      // Additional content goes here...
                                    ],
                                  )

                              ),
                            ),

                            userDetails['role'] != 'owner' &&
                                    userDetails[
                                            'enable_my_route_booking_feature'] ==
                                        '1' &&
                                    userDetails['transport_type'] != 'delivery'
                                ? InkWell(
                                    onTap: () async {
                                      var nav = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MyRouteBooking()));
                                      if (nav != null) {
                                        if (nav) {
                                          setState(() {});
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: media.width * 0.03),
                                      width: media.width * 0.7,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/myroute.png',
                                                fit: BoxFit.contain,
                                                width: media.width * 0.04,
                                                color: textColor,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                  width: media.width * 0.45,
                                                  child: MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_my_route'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    size: media.width * sixteen,
                                                    color: textColor,
                                                  ))
                                            ],
                                          ),

                                          // SizedBox(width: media.width*0.05,),
                                          if (userDetails['my_route_address'] !=
                                              null)
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: media.width * 0.005,
                                                  right: media.width * 0.005),
                                              height: media.width * 0.05,
                                              width: media.width * 0.1,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        media.width * 0.025),
                                                color: (userDetails[
                                                            'enable_my_route_booking'] ==
                                                        1)
                                                    ? Colors.green
                                                        .withOpacity(0.4)
                                                    : Colors.grey
                                                        .withOpacity(0.6),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: (userDetails[
                                                            'enable_my_route_booking'] ==
                                                        1)
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: media.width * 0.045,
                                                    width: media.width * 0.045,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (userDetails[
                                                                  'enable_my_route_booking'] ==
                                                              1)
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),

                            SizedBox(
                              width: media.width * 0.7,
                              child: NavMenu(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const History()));
                                },
                                text: languages[choosenLanguage]
                                    ['text_enable_history'],
                                icon: Icons.view_list_outlined,
                              ),
                            ),

                            (userDetails['role'] != 'owner')
                                ? ValueListenableBuilder(
                                    valueListenable:
                                        valueNotifierNotification.value,
                                    builder: (context, value, child) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NotificationPage()));
                                          setState(() {
                                            userDetails['notifications_count'] =
                                                0;
                                          });
                                        },
                                        child: Container(
                                          width: media.width * 0.7,
                                          padding: EdgeInsets.only(
                                              top: media.width * 0.07),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.notifications_none,
                                                size: media.width * 0.04,
                                                color: textColor,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: (userDetails[
                                                                'notifications_count'] ==
                                                            0)
                                                        ? media.width * 0.55
                                                        : media.width * 0.495,
                                                    child: MyText(
                                                        text: languages[choosenLanguage]
                                                                [
                                                                'text_notification']
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        size: media.width *
                                                            sixteen,
                                                        color: textColor),
                                                  ),
                                                  (userDetails[
                                                              'notifications_count'] ==
                                                          0)
                                                      ? Container()
                                                      : Container(
                                                          height: 25,
                                                          width: 25,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: buttonColor,
                                                          ),
                                                          child: Text(
                                                            userDetails[
                                                                    'notifications_count']
                                                                .toString(),
                                                            style: GoogleFonts.notoSans(
                                                                fontSize: media
                                                                        .width *
                                                                    twelve,
                                                                color: (isDarkTheme)
                                                                    ? Colors
                                                                        .black
                                                                    : buttonText),
                                                          ),
                                                        ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Container(),

                            if (userDetails['show_outstation_ride_feature'] ==
                                "1")
                              SizedBox(
                                width: media.width * 0.7,
                                child: NavMenu(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OutStation()));
                                  },
                                  text: languages[choosenLanguage]
                                      ['text_outstation'],
                                  icon: Icons.luggage_outlined,
                                ),
                              ),

                            //wallet page

                            userDetails['owner_id'] == null &&
                                    userDetails[
                                            'show_wallet_feature_on_mobile_app'] ==
                                        '1'
                                ? SizedBox(
                                    width: media.width * 0.7,
                                    child: NavMenu(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WalletPage()));
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_enable_wallet'],
                                      icon: Icons.payment,
                                    ),
                                  )
                                : Container(),

                            //Earnings
                            SizedBox(
                              width: media.width * 0.7,
                              child: NavMenu(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DriverEarnings()));
                                },
                                text: languages[choosenLanguage]
                                    ['text_earnings'],
                                image: 'assets/images/earing.png',
                              ),
                            ),

                            //manage vehicle

                            userDetails['role'] == 'owner'
                                ? SizedBox(
                                    width: media.width * 0.7,
                                    child: NavMenu(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ManageVehicles()));
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_manage_vehicle'],
                                      image:
                                          'assets/images/updateVehicleInfo.png',
                                    ),
                                  )
                                : Container(),

                            //manage Driver
                            userDetails['role'] == 'owner'
                                ? SizedBox(
                                    width: media.width * 0.7,
                                    child: NavMenu(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DriverList()));
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_manage_drivers'],
                                      image: 'assets/images/managedriver.png',
                                    ),
                                  )
                                : Container(),

                            //bank details
                            userDetails['owner_id'] == null &&
                                    userDetails[
                                            'show_bank_info_feature_on_mobile_app'] ==
                                        "1"
                                ? SizedBox(
                                    width: media.width * 0.7,
                                    child: NavMenu(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const BankDetails()));
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_updateBank'],
                                      icon: Icons.account_balance_outlined,
                                    ),
                                  )
                                : Container(),

                            //sos
                            userDetails['role'] != 'owner'
                                ? SizedBox(
                                    width: media.width * 0.7,
                                    child: NavMenu(
                                      onTap: () async {
                                        var nav = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Sos()));
                                        if (nav) {
                                          setState(() {});
                                        }
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_sos'],
                                      icon: Icons.connect_without_contact,
                                    ),
                                  )
                                : Container(),

                            //makecomplaints
                            SizedBox(
                              width: media.width * 0.7,
                              child: NavMenu(
                                icon: Icons.toc,
                                text: languages[choosenLanguage]
                                    ['text_make_complaints'],
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MakeComplaint()));
                                },
                              ),
                            ),

                            //settings
                            SizedBox(
                              width: media.width * 0.7,
                              child: NavMenu(
                                onTap: () async {
                                  var nav = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingsPage()));
                                  if (nav) {
                                    setState(() {});
                                  }
                                },
                                text: languages[choosenLanguage]
                                    ['text_settings'],
                                icon: Icons.settings,
                              ),
                            ),
                            //support call

                            InkWell(
                              onTap: () async {
                                final Uri url = Uri(
                                    scheme: 'tel',
                                    path: '+919230128456');
                                if (await canLaunchUrl(url)) {
                                  launchUrl(url);
                                } else {
                                  print(
                                      'Could not launch the dialer: ${url.toString()}');
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Could not launch the phone dialer. Please try again later.')),
                                  );
                                }
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(
                              top: media.width * 0.07,left: media.width * 0.05,),

                                child:
                              Row(
                                children: [
                                  Icon(Icons.call,
                                      size: media.width * 0.04,
                                      color: textColor),
                                  SizedBox(
                                    width: media.width * 0.025,
                                  ),
                                  Text('Support Call',style: TextStyle(fontSize: media.width * sixteen,
                                    color: textColor,),)
                                ],
                              ),
                            ),
                            ),
                            //support
                            ValueListenableBuilder(
                                valueListenable: valueNotifierChat.value,
                                builder: (context, value, child) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SupportPage()));
                                    },
                                    child: Container(
                                      width: media.width * 0.7,
                                      padding: EdgeInsets.only(
                                          top: media.width * 0.07),
                                      child: Row(
                                        children: [
                                          Icon(Icons.support_agent,
                                              size: media.width * 0.04,
                                              color: textColor),
                                          SizedBox(
                                            width: media.width * 0.025,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: (unSeenChatCount == '0')
                                                    ? media.width * 0.55
                                                    : media.width * 0.495,
                                                child: MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_support'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  size: media.width * sixteen,
                                                  color: textColor,
                                                ),
                                              ),
                                              (unSeenChatCount == '0')
                                                  ? Container()
                                                  : Container(
                                                      height: 20,
                                                      width: 20,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: buttonColor,
                                                      ),
                                                      child: Text(
                                                        unSeenChatCount,
                                                        style: GoogleFonts.notoSans(
                                                            fontSize:
                                                                media.width *
                                                                    fourteen,
                                                            color: (isDarkTheme)
                                                                ? Colors.black
                                                                : buttonText),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),

                            //referral page


                            SizedBox(
                              // padding: EdgeInsets.only(top: 100),
                              width: media.width * 0.7,
                              child: NavMenu(
                                onTap: () {
                                  setState(() {
                                    logout = true;
                                  });
                                  valueNotifierHome.incrementNotifier();
                                  Navigator.pop(context);
                                },
                                text: languages[choosenLanguage]
                                    ['text_sign_out'],
                                icon: Icons.logout,
                                textcolor: Colors.red,
                              ),
                            ),

                            SizedBox(
                              height: media.width * 0.05,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              //
            ),
          );
        });
  }
}
