part of 'cubit.dart';

class AllProductsStates {}

class AllProductsInitialState extends AllProductsStates {}

class AllProductsLoadingState extends AllProductsStates {}

class AllProductsSuccessState extends AllProductsStates {}

class AllProductsFailedState extends AllProductsStates {
  final String msg;

  AllProductsFailedState({required this.msg});
}

class ChangeFavouriteState extends AllProductsStates {}
