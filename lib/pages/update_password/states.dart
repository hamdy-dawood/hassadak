abstract class UpdatePasswordStates {}

class UpdatePasswordInitialState extends UpdatePasswordStates {}

class UpdatePasswordLoadingState extends UpdatePasswordStates {}

class UpdatePasswordSuccessState extends UpdatePasswordStates {}

class UpdatePasswordFailureState extends UpdatePasswordStates {
  final String msg;

  UpdatePasswordFailureState({required this.msg});
}

class CurrentPassVisibilityState extends UpdatePasswordStates {}

class UpdatePasswordVisibilityState extends UpdatePasswordStates {}

class UpdateConfPasswordVisibilityState extends UpdatePasswordStates {}
