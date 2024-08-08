import 'package:flutter/material.dart';

class Utility {
  static void showToast(
    String message,
    BuildContext ctx, {
    int seconds = 3,
    bool isSuccessMessage = false,
    bool isErrorMessage = false,
  }) {

    if(isSuccessMessage){
 ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(message,style: TextStyle(color: Colors.white),),
        duration: Duration(seconds: seconds),
      ),
    );
    }else if(isErrorMessage){
 ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(message,style: TextStyle(color: Colors.white),),
        
        duration: Duration(seconds: seconds),
      ),
    );
    }else{
       ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
      ),
    );
    }
   
  }
}
