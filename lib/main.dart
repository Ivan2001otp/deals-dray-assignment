import 'package:deals_dray/SplashScreen/bloc/splash_bloc.dart';
import 'package:deals_dray/home/Home.dart';
import 'package:deals_dray/home/bloc/bloc_home.dart';
import 'package:deals_dray/SplashScreen/pages/splash_screen.dart';
import 'package:deals_dray/login/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context)=>HomeBloc()),
        BlocProvider<SplashBloc>(create: (context)=>SplashBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child:  LoginScreen(),
        builder: (_, childScreen) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Deals-Dray',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
            home: childScreen,
          );
        },
      ),
    );
  }
}
