abstract class PersonalDataStates {}

class PersonalDataInitialState extends PersonalDataStates {}

class PersonalDataLoadingState extends PersonalDataStates {}

class PersonalDataSuccessState extends PersonalDataStates {}

class PersonalDataFailureState extends PersonalDataStates {
  final String msg;

  PersonalDataFailureState({required this.msg});
}

class ChanceVisibilityState extends PersonalDataStates {}
