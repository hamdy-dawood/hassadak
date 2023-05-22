abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginFailureState extends LoginStates {
  final String msg;

  LoginFailureState({required this.msg});
}

class NetworkErrorState extends LoginStates {}

class ChanceVisibilityState extends LoginStates {}
