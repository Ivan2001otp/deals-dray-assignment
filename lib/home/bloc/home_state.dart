import 'package:deals_dray/home/model/HomeResponse.dart';

abstract class HomeState {
  HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial();
}

class HomeLoading extends HomeState {
  HomeLoading();
}

class HomeSuccessStatus extends HomeState {
  final HomeResponse response;
  HomeSuccessStatus(this.response);
}

class HomeFailureStatus extends HomeState {
  final String message;
  HomeFailureStatus(this.message);
}
