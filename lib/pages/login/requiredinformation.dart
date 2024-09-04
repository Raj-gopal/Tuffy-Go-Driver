import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/login/approval.dart';
import 'package:flutter_driver/pages/login/login.dart';
import 'package:flutter_driver/pages/onTripPage/map_page.dart';
import 'package:flutter_driver/widgets/glassmorphism.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../onTripPage/rides.dart';
import 'carinformation.dart';
import 'ownerregister.dart';
import 'profileinformation.dart';
import 'uploaddocument.dart';

class RequiredInformation extends StatefulWidget {
  const RequiredInformation({Key? key}) : super(key: key);

  @override
  State<RequiredInformation> createState() => _RequiredInformationState();
}

bool profileCompleted = false;
bool carInformationCompleted = false;
bool documentCompleted = false;

class _RequiredInformationState extends State<RequiredInformation> {
  @override
  void initState() {
    super.initState();
    setState(() {
      profileCompleted = true;
    });

    // Check conditions and navigate if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (documentCompleted == true || userDetails['uploaded_document'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Approval()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: ValueListenableBuilder(
            valueListenable: valueNotifierHome.value,
            builder: (context, value, child) {
              if (userDetails['approve'] == true) {
                Future.delayed(const Duration(milliseconds: 0), () {
                  if (userDetails['role'] != 'owner' &&
                      userDetails['enable_bidding'] == true) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RidePage()),
                            (route) => false);
                  } else if (userDetails['role'] != 'owner' &&
                      userDetails['enable_bidding'] == false) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Maps()),
                            (route) => false);
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Maps()),
                            (route) => false);
                  }
                });
              }
              return GlassMorphism(
                text: languages[choosenLanguage]['text_reqinfo'],
                column: Column(
                  children: [
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: (" ${languages[choosenLanguage]['text_welcome']}"
                            " ${userDetails.isEmpty ? name.toString().split(' ')[0] : userDetails['name']}"),
                        size: media.width * fourteen,
                        fontweight: FontWeight.bold,
                        color: whiteText,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: languages[choosenLanguage]['text_reqinfo'],
                        size: media.width * fourteen,
                        fontweight: FontWeight.bold,
                        color: whiteText,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: languages[choosenLanguage]['text_become_captain'],
                        size: media.width * fourteen,
                        color: whiteText,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    InkWell(
                      onTap: () async {
                        if (profileCompleted != true && userDetails.isEmpty) {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileInformation()));
                          if (nav != null) {
                            if (nav) {
                              setState(() {});
                            }
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/person_icon.png',
                                height: media.width * 0.05,
                                width: media.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                      ['text_profile'],
                                      size: media.width * twelve,
                                      fontweight: FontWeight.bold,
                                      color: whiteText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.025,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                      ['text_profile_para'],
                                      size: media.width * fourteen,
                                      color: whiteText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                            ],
                          ),
                          if (profileCompleted == true ||
                              userDetails.isNotEmpty)
                            Image.asset(
                              'assets/images/done_icon.png',
                              height: media.width * 0.05,
                              width: media.width * 0.05,
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    Container(
                      height: 1,
                      color: const Color.fromARGB(255, 214, 213, 213),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    InkWell(
                      onTap: () async {
                        if (profileCompleted == true) {
                          if (carInformationCompleted != true &&
                              userDetails.isEmpty) {
                            // ignore: prefer_typing_uninitialized_variables
                            var nav;
                            if (ischeckownerordriver == 'driver') {
                              nav = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CarInformation(frompage: 1)));
                            } else {
                              nav = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const OwnersRegister()));
                            }
                            if (nav != null) {
                              if (nav) {
                                setState(() {});
                              }
                            }
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/car_information.png',
                                height: media.width * 0.05,
                                width: media.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: (ischeckownerordriver == 'driver')
                                          ? languages[choosenLanguage]
                                      ['text_car_info']
                                          : 'Company Information',
                                      size: media.width * twelve,
                                      fontweight: FontWeight.bold,
                                      color: whiteText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.025,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                      ['text_car_info_para'],
                                      size: media.width * fourteen,
                                      color: whiteText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                            ],
                          ),
                          if (carInformationCompleted == true ||
                              userDetails.isNotEmpty)
                            Image.asset(
                              'assets/images/done_icon.png',
                              height: media.width * 0.05,
                              width: media.width * 0.05,
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    Container(
                      height: 1,
                      color: const Color.fromARGB(255, 214, 213, 213),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    InkWell(
                      onTap: () async {
                        if (carInformationCompleted || userDetails.isNotEmpty) {
                          var nav = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadDocument()));
                          if (nav != null) {
                            if (nav) {
                              setState(() {});
                            }
                          }
                        }
                      },
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/document_icon.png',
                                height: media.width * 0.05,
                                width: media.width * 0.05,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                      ['text_docs'],
                                      size: media.width * twelve,
                                      fontweight: FontWeight.bold,
                                      color: whiteText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.025,
                                  ),
                                  SizedBox(
                                    width: media.width * 0.65,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                      ['text_upload_pho_lic'],
                                      size: media.width * fourteen,
                                      color: whiteText,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: media.width * 0.016,
                              ),
                            ],
                          ),
                          (documentCompleted == true ||
                              (userDetails['uploaded_document'] == true &&
                                  userDetails['declined_reason'] == null))
                              ? Image.asset(
                            'assets/images/done_icon.png',
                            height: media.width * 0.05,
                            width: media.width * 0.05,
                            fit: BoxFit.contain,
                          )
                              : (userDetails['declined_reason'] != null)
                              ? Image.asset(
                            'assets/images/cancel_icon.png',
                            height: media.width * 0.05,
                            width: media.width * 0.05,
                            fit: BoxFit.contain,
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    // Removed duplicate navigation code from here
                  ],
                ),
                error: error,
                loading: false,
                onTap: (userDetails.isNotEmpty)
                    ? null
                    : () {
                  Navigator.pop(context);
                },
                button: Container(),
              );
            }),
      ),
    );
  }
}
