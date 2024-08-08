import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KYCCardView extends StatelessWidget {
  final String text;
  const KYCCardView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 6.sp,
        vertical: 4.sp,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width ,
        height: MediaQuery.of(context).size.height * 25 / 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20.sp,
              ),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 138, 151, 238),
                    Color.fromARGB(255, 91, 104, 241)
                  ]),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'KYC Pending',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
