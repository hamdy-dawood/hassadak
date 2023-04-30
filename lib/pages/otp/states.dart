abstract class OtpStates {}

class OtpInitialState extends OtpStates {}

class OtpLoadingState extends OtpStates {}

class OtpSuccessState extends OtpStates {
  final String msg;

  OtpSuccessState({required this.msg});
}

class OtpFailureState extends OtpStates {
  final String msg;

  OtpFailureState({required this.msg});
}
