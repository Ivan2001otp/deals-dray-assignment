import 'dart:math';

import 'package:deals_dray/home/bloc/bloc_home.dart';
import 'package:deals_dray/home/bloc/home_event.dart';
import 'package:deals_dray/home/bloc/home_state.dart';
import 'package:deals_dray/home/model/HomeResponse.dart';
import 'package:deals_dray/home/widgets/BannerWidget.dart';
import 'package:deals_dray/home/widgets/CardHolder.dart';
import 'package:deals_dray/home/widgets/CategoryWidget.dart';
import 'package:deals_dray/home/widgets/ProductWidget.dart';
import 'package:deals_dray/home/widgets/TopSellingProductWidget.dart';
import 'package:deals_dray/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> bannerImagePathList = [];
  List<Product> productList = [];
  int currentBottomIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(const OnFetchHomeResponse());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.sp,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: Icon(
          Icons.dehaze_outlined,
          color: Colors.black,
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 75 / 100,
            height: 40.sp,
            child: SearchBar(
                backgroundColor: MaterialStatePropertyAll(Colors.white),
                hintText: 'Search here',
                elevation: MaterialStatePropertyAll(2),
                keyboardType: TextInputType.text,
                leading: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  width: 20.sp,
                  height: 20.sp,
                )),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentBottomIndex,
          onTap: (value) {
            // setState(() {
            currentBottomIndex = value;
            // });
          },
          selectedItemColor: Colors.red,
          selectedLabelStyle: const TextStyle(
            color: Colors.red,
          ),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(
            color: Colors.grey,
          ),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.handshake_outlined), label: 'Deals'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2), label: 'Profile'),
          ]),
      floatingActionButton: Card(
        elevation: 20.sp,
        color: Color.fromARGB(255, 205, 18, 5),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          24.sp,
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.sp,
            vertical: 10.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat,
                size: 30.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                'Chat',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(
            top: 10.sp,
          ),
          child: BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber[300],
                ),
              );
            } else if (state is HomeFailureStatus) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is HomeSuccessStatus) {
              //adding all banners in one place
              //so that it will be helpful to display it.

              // banner1
              state.response.data?.bannerOne.forEach(
                (element) {
                  if (element.banner != null) {
                    bannerImagePathList.add(element.banner!);
                  }
                },
              );

              //banner2
              state.response.data?.bannerTwo.forEach(
                (element) {
                  if (element.banner != null) {
                    bannerImagePathList.add(element.banner!);
                  }
                },
              );

              // banner3
              state.response.data?.bannerThree.forEach(
                (element) {
                  if (element.banner != null) {
                    bannerImagePathList.add(element.banner!);
                  }
                },
              );

              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        BannerWidget(bannerPathList: bannerImagePathList),
                        SizedBox(
                          height: 16.sp,
                        ),
                        KYCCardView(
                          text:
                              "You need to provide the required documents for your account activation.",
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CategoryWidget(
                              iconData: Icons.mobile_screen_share_outlined,
                              startColor: Color.fromARGB(255, 16, 57, 220),
                              color: Color.fromARGB(255, 110, 136, 243),
                              text: 'Mobile',
                            ),
                            CategoryWidget(
                              iconData: Icons.laptop,
                              startColor: Color.fromARGB(255, 61, 156, 64),
                              color: Color.fromARGB(255, 116, 188, 118),
                              text: 'Laptop',
                            ),
                            CategoryWidget(
                              iconData: Icons.camera_alt_rounded,
                              startColor: Color.fromARGB(255, 239, 46, 33),
                              color: Color.fromARGB(255, 194, 118, 113),
                              text: 'Camera',
                            ),
                            CategoryWidget(
                              iconData: Icons.lightbulb,
                              startColor: Color.fromARGB(255, 229, 141, 10),
                              color: Color.fromARGB(255, 184, 144, 83),
                              text: 'LED',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(
                              4.sp,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color.fromARGB(255, 135, 190, 234),
                                Color.fromARGB(255, 24, 59, 173)
                              ]),
                              color: const Color.fromARGB(255, 135, 190, 234),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Exclusive For You',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Transform.rotate(
                                            angle: pi,
                                            child: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            )))
                                  ],
                                ),
                                ProductWidget(
                                    productList:
                                        state.response.data?.products ?? []),
                              ],
                            )),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                            padding: EdgeInsets.all(
                              4.sp,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 241, 213, 135),
                                Color.fromARGB(255, 244, 170, 11)
                              ]),
                              color: const Color.fromARGB(255, 135, 190, 234),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '  Top Sellers',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 28.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Transform.rotate(
                                        angle: pi,
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TopSellingProductWidget(
                                    productList: state.response.data
                                            ?.topSellingProducts ??
                                        [])
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('None of the state are active!'),
            );
          }, listener: (context, state) {
            if (state is HomeFailureStatus) {
              Utility.showToast(
                  "Something went wrong while networkCall", context);
            } else if (state is HomeSuccessStatus) {
              Utility.showToast("Welcome", context, isSuccessMessage: true);
            }
          })),
    );
  }
}
