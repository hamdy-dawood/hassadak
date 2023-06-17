abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class NetworkErrorState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {
  final String msg;

  RegisterFailureState({required this.msg});
}

class PasswordVisibilityState extends RegisterStates {}

class ConfPasswordVisibilityState extends RegisterStates {}
