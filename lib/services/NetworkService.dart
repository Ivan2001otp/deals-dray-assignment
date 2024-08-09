import 'package:deals_dray/utils/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class NetworkService {
  Dio dio = Dio(
    BaseOptions(connectTimeout: const Duration(seconds: 15),sendTimeout: const Duration(seconds: 15),receiveTimeout: const Duration(seconds: 15))
  );

  Future<Map<String, dynamic>> fetchData() async {
    try {
      Response<dynamic> response = await dio.get(Constants.homePageUrl);

      Map<String, dynamic> json = response.data;

      return json;
    } catch (e) {
      debugPrint("The error is ${e.toString()}");
      rethrow;
    }
  }

  Future<dynamic> postSplashScreenDeviceInfo() async {
    String deviceId = '', deviceOs = '', deviceModel = '', deviceName = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      deviceOs = TargetPlatform.android.name;
      deviceModel = androidInfo.model;
      deviceName = androidInfo.display;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.systemVersion;
      deviceOs = TargetPlatform.iOS.name;
      deviceModel = iosDeviceInfo.model;
      deviceName = iosDeviceInfo.name;
    }

    Map<String, dynamic> json = {
      "deviceType": deviceOs,
      "deviceId": deviceId,
      "deviceName": deviceName,
      "deviceOSVersion": "2.3.6",
      "deviceIPAddress": "11.433.445.66",
      "lat": 9.9312,
      "long": 76.2673,
      "buyer_gcmid": "",
      "buyer_pemid": "",
      "app": {
        "version": "1.20.5",
        "installTimeStamp": "2022-02-10T12:33:30.696Z",
        "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
        "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
      }
    };

    try {
      Response<dynamic> response =
          await dio.post(Constants.splashScreenUrl, data: json);
      Map<String, dynamic> mapBody = response.data;
      mapBody.entries.forEach((element) {
        debugPrint('$element');
      });
      return mapBody;
    } catch (e) {
      debugPrint("The error is ${e.toString()}");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> SendVerificationCode(
      Map<String, dynamic> json) async {
    try {
      Response<dynamic> response =
          await dio.post(Constants.sendingVerificationCodeUrl, data: json);
      Map<String, dynamic> mapBody = response.data;

      return mapBody;
    } catch (e) {
      debugPrint("The error is ${e.toString()}");
      rethrow;
    }
  }
}
