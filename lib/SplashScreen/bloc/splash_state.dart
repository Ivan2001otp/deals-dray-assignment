
abstract class SplashState {
  SplashState();
}

class SplashInitial extends SplashState {
  SplashInitial();
}

class SplashLoading extends SplashState {
  SplashLoading();
}

class SplashSuccessStatus extends SplashState {
  final String response;
  SplashSuccessStatus(this.response);
}

class SplashFailureStatus extends SplashState {
  final String message;
  SplashFailureStatus(this.message);
}
