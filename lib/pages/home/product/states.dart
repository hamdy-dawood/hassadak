part of 'cubit.dart';

class ProductStates {}

class ProductInitialStates extends ProductStates {}

class ProductLoadingStates extends ProductStates {}

class ProductSuccessStates extends ProductStates {}

class ProductFailedStates extends ProductStates {
  final String msg;

  ProductFailedStates({required this.msg});
}
