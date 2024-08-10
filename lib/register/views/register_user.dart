import 'dart:ffi';
import 'dart:math';

import 'package:deals_dray/home/Home.dart';
import 'package:deals_dray/services/NetworkService.dart';
import 'package:deals_dray/utils/constants.dart';
import 'package:deals_dray/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _referralController;
  late NetworkService _networkService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkService = NetworkService();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _referralController = TextEditingController();
  }

  final String label = "Let's Begin !";
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          if (_emailController.text.isNotEmpty &&
              _passwordController.text.isNotEmpty) {
            Map<String, dynamic> json = {
              "email": _emailController.text.trim(),
              "password": _passwordController.text.trim(),
              "referralCode": _referralController.text.isEmpty
                  ? 12345678
                  : int.tryParse(_referralController.text.trim()),
              "userId": "62a833766ec5dafd4380fc85",
            };

            EasyLoading.show(status: 'Loading');

            try {
              Map<String, dynamic> response = {
                "data": {
                  "message": Constants.registerPlaceholderString,
                },
              };

              await Future.delayed(
                const Duration(seconds: 2),
              );
              // await _networkService.registerUser(json);

              if (response['data']['message'] ==
                  Constants.registerPlaceholderString) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              } else {
                Utility.showToast('Email Already exists', context);
              }
            } catch (e) {
              EasyLoading.showError('Something went Wrong!');
            } finally {
              EasyLoading.dismiss();
            }
          } else {
            Utility.showToast('Empty Field', context, isErrorMessage: true);
          }
        },
        child: Transform.rotate(
          angle: pi,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
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
              SizedBox(
                height: 10.h,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'Please enter your credentials to proceed',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Empty Field!";
                        }
                      },
                      onChanged: (val) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2)),
                        errorBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                        ),
                        hintText: 'Your Email',
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isObscure,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Empty Field!";
                        }
                      },
                      onChanged: (val) {},
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: isObscure
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(
                                  Icons.visibility_off,
                                ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.sp),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.w)),
                        errorBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                        ),
                        hintText: 'Create Password',
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    TextFormField(
                      controller: _referralController,
                      validator: (val) {},
                      onChanged: (val) {},
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w800,
                        ),
                        hintText: 'Referral Code (Optional)',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
