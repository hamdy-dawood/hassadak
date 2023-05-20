abstract class EditDataStates {}

class EditDataInitialState extends EditDataStates {}

class EditDataLoadingState extends EditDataStates {}

class EditDataSuccessState extends EditDataStates {}

class EditDataFailureState extends EditDataStates {
  final String msg;

  EditDataFailureState({required this.msg});
}

class EditNetworkErrorState extends EditDataStates {}
