part of 'cubit.dart';

class GetSellerStates {}

class GetSellerInitialState extends GetSellerStates {}

class GetSellerLoadingState extends GetSellerStates {}

class GetSellerSuccessState extends GetSellerStates {}

class GetSellerFailedState extends GetSellerStates {
  final String msg;

  GetSellerFailedState({required this.msg});
}
