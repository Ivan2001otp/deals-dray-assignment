import 'package:deals_dray/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkService {
  Dio dio = Dio();

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
}
