part of 'cubit.dart';

class AllFavouritesStates {}

class AllFavouritesInitialStates extends AllFavouritesStates {}

class AllFavouritesLoadingStates extends AllFavouritesStates {}

class AllFavouritesSuccessStates extends AllFavouritesStates {}

class NetworkErrorState extends AllFavouritesStates {}

class AllFavouritesFailedStates extends AllFavouritesStates {
  final String msg;

  AllFavouritesFailedStates({required this.msg});
}
