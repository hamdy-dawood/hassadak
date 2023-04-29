abstract class NewPasswordStates {}

class NewPasswordInitialState extends NewPasswordStates {}

class NewPasswordLoadingState extends NewPasswordStates {}

class NewPasswordSuccessState extends NewPasswordStates {}

class NewPasswordFailureState extends NewPasswordStates {
  final String msg;

  NewPasswordFailureState({required this.msg});
}

class NewPasswordVisibilityState extends NewPasswordStates {}

class NewConfPasswordVisibilityState extends NewPasswordStates {}
