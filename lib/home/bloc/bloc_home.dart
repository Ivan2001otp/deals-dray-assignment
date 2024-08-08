import 'package:deals_dray/home/bloc/home_event.dart';
import 'package:deals_dray/home/bloc/home_state.dart';
import 'package:deals_dray/home/model/HomeResponse.dart';
import 'package:deals_dray/services/NetworkService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NetworkService _networkService = NetworkService();

  HomeBloc() : super(HomeInitial()) {
    on<OnFetchHomeResponse>((event, emit) async {
       emit(HomeLoading());
       
      try {
       
        Map<String, dynamic> response = await _networkService.fetchData();
       
        HomeResponse resp = HomeResponse.fromJson(response);

        debugPrint(resp.data.toString());

        emit(
          HomeSuccessStatus(
            HomeResponse.fromJson(response),
          ),
        );
      } catch (e) {
        emit(HomeFailureStatus(e.toString()));
      }
    });
  }
}
