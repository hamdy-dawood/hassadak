part of 'cubit.dart';

class OfferProductsStates {}

class OfferProductsInitialState extends OfferProductsStates {}

class OfferProductsLoadingState extends OfferProductsStates {}

class OfferProductsSuccessState extends OfferProductsStates {}

class NetworkErrorState extends OfferProductsStates {}

class OfferProductsFailedState extends OfferProductsStates {
  final String msg;

  OfferProductsFailedState({required this.msg});
}
