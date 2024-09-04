import 'package:flutter/material.dart';
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

class Approval extends StatefulWidget {
  const Approval({Key? key}) : super(key: key);

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top:264.0),
            child: Column(
              children: [
                if (userDetails['declined_reason'] == null)
                  Container(
                    height: media.width * 0.2,
                    width: media.width * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        opacity: 0.3,
                        image: AssetImage('assets/images/wait.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                Column(
                  children: [
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                    Row(
                      children: [
                        if (userDetails['declined_reason'] == null)
                          Image.asset(
                            'assets/images/proposal-approval.dart.png',
                            width: media.width * 0.045,
                            height: media.width * 0.045,
                            color: whiteText,
                          )
                        else
                          Icon(
                            Icons.info,
                            size: media.width * 0.045,
                            color: Colors.red,
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: media.width * 0.7,
                          child: (userDetails['declined_reason'] == null)
                              ? MyText(
                            text: languages[choosenLanguage]
                            ['text_waiting_approval'],
                            size: media.width * fourteen,
                            fontweight: FontWeight.bold,
                            color: whiteText,
                          )
                              : MyText(
                            text: languages[choosenLanguage]
                            ['text_account_declined'],
                            size: media.width * fourteen,
                            fontweight: FontWeight.bold,
                            color: whiteText,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: languages[choosenLanguage]['text_eva_profile'],
                        color: whiteText,
                        size: media.width * twelve,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: (userDetails['declined_reason'] == null)
                            ? languages[choosenLanguage]['text_order_to']
                            : languages[choosenLanguage]['text_kindly_reup'],
                        color: whiteText,
                        size: media.width * fourteen,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.04,
                    ),
                    SizedBox(
                      width: media.width * 0.9,
                      child: MyText(
                        text: (userDetails['declined_reason'] == null)
                            ? languages[choosenLanguage]['text_this_step']
                            : "${languages[choosenLanguage]['text_declined_reason']} - ${userDetails['declined_reason']}",
                        size: media.width * fourteen,
                        color: verifyDeclined,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
