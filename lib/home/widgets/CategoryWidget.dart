import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final Color startColor;
  const CategoryWidget(
      {super.key,
      required this.iconData,
      required this.color,
      required this.startColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70.sp,
          height: 70.sp,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [startColor, color]),
            shape: BoxShape.circle,
            color: color,
          ),
          child: Icon(
            iconData,
            color: Colors.white,
            size: 30.sp,
          ),
        ),
        SizedBox(
          height: 2.sp,
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 12.sp,
          ),
        )
      ],
    );
  }
}
