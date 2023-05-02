part of 'cubit.dart';

class AddFavStates {}

class AddFavInitialStates extends AddFavStates {}

class AddFavLoadingStates extends AddFavStates {}

class AddFavSuccessStates extends AddFavStates {}

class AddFavFailedStates extends AddFavStates {
  final String msg;

  AddFavFailedStates({required this.msg});
}
