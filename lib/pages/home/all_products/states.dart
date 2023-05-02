part of 'cubit.dart';

class AllProductsStates {}

class AllProductsInitialStates extends AllProductsStates {}

class AllProductsLoadingStates extends AllProductsStates {}

class AllProductsSuccessStates extends AllProductsStates {}

class AllProductsFailedStates extends AllProductsStates {
  final String msg;

  AllProductsFailedStates({required this.msg});
}

class ChangeFavouriteStates extends AllProductsStates {}
