part of 'cubit.dart';

class AllOffersStates {}

class AllOffersInitialStates extends AllOffersStates {}

class AllOffersLoadingStates extends AllOffersStates {}

class AllOffersSuccessStates extends AllOffersStates {}

class AllOffersFailedStates extends AllOffersStates {
  final String msg;

  AllOffersFailedStates({required this.msg});
}
