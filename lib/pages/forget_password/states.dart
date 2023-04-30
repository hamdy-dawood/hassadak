abstract class ForgetPasswordStates {}

class ForgetPasswordInitialState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordSuccessState extends ForgetPasswordStates {
  final String msg;

  ForgetPasswordSuccessState({required this.msg});
}

class ForgetPasswordFailureState extends ForgetPasswordStates {
  final String msg;

  ForgetPasswordFailureState({required this.msg});
}
