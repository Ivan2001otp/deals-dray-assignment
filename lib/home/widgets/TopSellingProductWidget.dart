import 'package:deals_dray/home/model/HomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSellingProductWidget extends StatelessWidget {
  final List<TopSellingProduct> productList;
  const TopSellingProductWidget({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 55 / 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.h),
            elevation: 12.sp,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 70 / 100,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(
                    productList[index].icon!,
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 30.sp,
                  left: 4.sp,
                  child: Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: Text(
                      productList[index].label!,
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
