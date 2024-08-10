import 'dart:async';
import 'package:deals_dray/home/Home.dart';
import 'package:deals_dray/register/views/register_user.dart';
import 'package:deals_dray/services/NetworkService.dart';
import 'package:deals_dray/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPviewPage extends StatefulWidget {
  final String mobileNumber;
  const OTPviewPage({super.key, required this.mobileNumber});

  @override
  State<OTPviewPage> createState() => _OTPviewPageState();
}

class _OTPviewPageState extends State<OTPviewPage> {
  int _secondsRemaining = 90;
  Timer? _timer;

  String get timerText {
    Duration duration = Duration(seconds: _secondsRemaining);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining == 0) {
          timer.cancel();
        } else {
          _secondsRemaining--;
        }
      });
    });
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _secondsRemaining = 60;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utility.showToast('OTP - 9879', context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/otp_recieve.png',
                width: 250.sp,
                height: 250.sp,
              ),
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'We have sent a unique OTP number to your mobile +91-${widget.mobileNumber}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //timer
                  Text(
                    timerText,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        Map<String, dynamic> json = {
                          "mobileNumber": "9011470243",
                          "deviceId": "62b341aeb0ab5ebe28a758a3"
                        };

                        EasyLoading.instance
                          ..textColor = Colors.white
                          ..progressColor = Colors.white;

                        EasyLoading.show(status: 'Loading');
                        try {
                          final response =
                              await NetworkService().sendVerificationCode(json);

                          if (response['data']['userId'] != null) {
                            resetTimer();
                            EasyLoading.showSuccess('OTP sent');
                          }
                        } catch (e) {
                          EasyLoading.showError('Something went wrong!');
                        } finally {
                          EasyLoading.dismiss();
                        }
                      },
                      child: Text(
                        'SEND AGAIN',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              OtpTextField(
                numberOfFields: 4,
                showCursor: true,
                showFieldAsBox: true,
                fieldWidth: 50,
                fieldHeight: 50,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                onSubmit: (value) {
                  debugPrint(value);
                  debugPrint("Sumbitted");
                  if (value == '9879') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterUserPage()),
                    );
                  } else {
                    Utility.showToast('Wrong OTP', context,
                        isErrorMessage: true);
                  }
                },
                keyboardType: TextInputType.number,
                borderRadius: BorderRadius.circular(12.sp),
                contentPadding: EdgeInsets.only(
                  bottom: 1.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
