part of 'cubit.dart';

class DeleteFavStates {}

class DeleteFavInitialStates extends DeleteFavStates {}

class DeleteFavLoadingStates extends DeleteFavStates {}

class DeleteFavSuccessStates extends DeleteFavStates {}

class DeleteFavFailedStates extends DeleteFavStates {
  final String msg;

  DeleteFavFailedStates({required this.msg});
}
