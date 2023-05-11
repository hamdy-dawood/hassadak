part of 'cubit.dart';

class AllSellersStates {}

class AllSellersInitialState extends AllSellersStates {}

class AllSellersLoadingState extends AllSellersStates {}

class AllSellersSuccessState extends AllSellersStates {}

class SellersNotHaveAccessState extends AllSellersStates {}

class NetworkErrorState extends AllSellersStates {}

class AllSellersFailedState extends AllSellersStates {
  final String msg;

  AllSellersFailedState({required this.msg});
}
