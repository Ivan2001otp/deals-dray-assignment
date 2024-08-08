import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerWidget extends StatefulWidget {
  final List<String> bannerPathList;

  BannerWidget({super.key, required this.bannerPathList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late List<Widget> _pages = [];
  int _activePage = 0;
  Timer? _timer;

  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = List.generate(
      widget.bannerPathList.length,
      (index) => BannerPlaceHolder(imagePath: widget.bannerPathList[index]),
    );
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(
        Duration(
          seconds: 2,
        ), (timer) {
      if (_pageController.page == widget.bannerPathList.length - 1) {
        _pageController.animateTo(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.sp,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 25 / 100,
            child: PageView.builder(
              onPageChanged: (val) {
                setState(() {
                  _activePage = val;
                });
              },
              controller: _pageController,
              itemCount: widget.bannerPathList.length,
              itemBuilder: (context, index) {
                return _pages[index];
              },
            ),
          ),
          Positioned(
            bottom: 10.sp,
            right: 0,
            left: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.bannerPathList.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                    ),
                    child: InkWell(
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: CircleAvatar(
                        radius: 4.sp,
                        backgroundColor:
                            _activePage == index ? Colors.yellow : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BannerPlaceHolder extends StatelessWidget {
  final String imagePath;

  const BannerPlaceHolder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.sp),
      child: Image.network(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
