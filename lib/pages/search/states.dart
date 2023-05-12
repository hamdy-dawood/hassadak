part of 'cubit.dart';

class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchNetworkErrorState extends SearchStates {}

class SearchFailedState extends SearchStates {
  final String msg;

  SearchFailedState({required this.msg});
}
