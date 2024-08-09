import 'dart:async';

import 'package:deals_dray/SplashScreen/bloc/splash_bloc.dart';
import 'package:deals_dray/SplashScreen/bloc/splash_event.dart';
import 'package:deals_dray/SplashScreen/bloc/splash_state.dart';
import 'package:deals_dray/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashBloc>().add(
            const OnPostDeviceDetail(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
        if (state is SplashLoading) {
          return Image.asset(
            "assets/images/splash_screen.png",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        } else if (state is SplashFailureStatus) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is SplashSuccessStatus) {
          return Image.asset(
            "assets/images/splash_screen.png",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        }
        return const SizedBox.shrink();
      }, listener: (context, state) {
        if (state is SplashSuccessStatus) {
          Navigator.pushReplacement(
              context,
              // MaterialPageRoute(
              //   builder: (context) => HomePage(),
              // ),
              PageRouteBuilder(
                  pageBuilder: ((context, animation, secondaryAnimation) =>
                      const HomePage()),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;

                    var tween = Tween(begin: begin, end: end);
                    var curvedAnimation =
                        CurvedAnimation(parent: animation, curve: curve);

                    var offsetAnimation = tween.animate(curvedAnimation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  }));
        }
      }),
    );
  }
}
