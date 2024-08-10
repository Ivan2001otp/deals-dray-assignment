import 'package:deals_dray/login/pages/otp_page.dart';
import 'package:deals_dray/services/NetworkService.dart';
import 'package:deals_dray/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool switchedOn = false;
  bool emptyField = true;
  late TextEditingController _editingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editingController = TextEditingController();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/deals_dray_gray.png',
                width: 250.sp,
                height: 250.sp,
              ),
            ),
            Row(
              children: [
                Switch(
                    value: switchedOn,
                    activeColor: Colors.red,
                    activeTrackColor: Colors.black,
                    onChanged: (val) {
                      setState(() {
                        switchedOn = val;
                      });
                    }),
                SizedBox(
                  width: 10.w,
                ),
                switchedOn
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.email,
                            color: Colors.black,
                          )
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Mobile',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.mobile_friendly,
                            color: Colors.black,
                          )
                        ],
                      )
              ],
            ),
            Text(
              'Glad to see you !',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 30.sp,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Please provide your ${switchedOn ? 'Email' : 'Phone-Number'}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Form(
              child: TextFormField(
                controller: _editingController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Empty Field!";
                  }
                },
                onChanged: (val) {
                  setState(() {
                    emptyField = _editingController.text.isEmpty;
                  });
                },
                keyboardType: !switchedOn
                    ? TextInputType.phone
                    : TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.sp),
                        borderSide: BorderSide(color: Colors.black, width: 2)),
                    errorBorder: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                    ),
                    labelText: switchedOn ? 'Email' : 'Mobile'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !emptyField
                        ? Colors.red
                        : Color.fromARGB(193, 207, 119, 119),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.sp,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    EasyLoading.instance
                      ..textColor = Colors.white
                      ..progressColor = Colors.white;

                    if (_editingController.text.isNotEmpty) {
                      EasyLoading.show(status: "Loading");

                      Map<String, dynamic> json = {
                        "mobileNumber":
                            _editingController.text.trim(), //9011470243
                        "deviceId": "62b341aeb0ab5ebe28a758a3"
                      };
                      try {
                        final response =
                            await NetworkService().sendVerificationCode(json);

                        await Future.delayed(
                          Duration(seconds: 2),
                        );

                        if (response['data']['userId'] != null) {
                          EasyLoading.showSuccess('OTP sent');

                          Utility.showToast('OTP - 9879', context);

                          EasyLoading.dismiss();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OTPviewPage(
                                mobileNumber: json["mobileNumber"],
                              ),
                            ),
                          );
                        } else {
                          Utility.showToast("Recieve Timeout !", context,
                              isErrorMessage: true);
                        }
                      } catch (e) {
                        EasyLoading.dismiss();
                      }
                    }
                  },
                  child: Text(
                    'Send Code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
