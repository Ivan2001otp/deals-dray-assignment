import 'package:deals_dray/SplashScreen/bloc/splash_event.dart';
import 'package:deals_dray/SplashScreen/bloc/splash_state.dart';
import 'package:deals_dray/services/NetworkService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final NetworkService _networkService = NetworkService();

  SplashBloc() : super(SplashInitial()) {
    on<OnPostDeviceDetail>((event, emit) async {
      emit(SplashLoading());
      try {
        Map<String, dynamic> response =
            await _networkService.postSplashScreenDeviceInfo();
        String? result = response['data']['deviceId'];

        //adding a bit delay
        await Future.delayed(
          const Duration(seconds: 3),
        );
        
        if (result != null) {
          emit(
            SplashSuccessStatus(response['data']['message']),
          );
        } else {
          emit(
            SplashFailureStatus('Splash Response is error!'),
          );
        }
      } catch (e) {
        emit(
          SplashFailureStatus(
            e.toString(),
          ),
        );
      }
    });
  }
}
