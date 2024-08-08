import 'package:deals_dray/home/model/HomeResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductWidget extends StatelessWidget {
  final List<Product> productList;
  const ProductWidget({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    if (productList.isEmpty) {
      return SizedBox.shrink();
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
                    right: 10.sp,
                    top: 10.sp,
                    child: Card(
                      color: Colors.green,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.sp,
                          vertical: 8.sp,
                        ),
                        child: Text(
                          productList[index].offer!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
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
                Positioned(
                  bottom: 1.sp,
                  left: 4.sp,
                  child: Padding(
                    padding: EdgeInsets.all(4.sp),
                    child: Text(
                      productList[index].subLabel ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
