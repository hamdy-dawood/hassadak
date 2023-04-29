part of 'cubit.dart';

class AllCategoriesStates {}

class AllCategoriesInitialStates extends AllCategoriesStates {}

class AllCategoriesLoadingStates extends AllCategoriesStates {}

class AllCategoriesSuccessStates extends AllCategoriesStates {
  final List id;

  AllCategoriesSuccessStates({required this.id});
}

class AllCategoriesFailedStates extends AllCategoriesStates {
  final String msg;

  AllCategoriesFailedStates({required this.msg});
}
