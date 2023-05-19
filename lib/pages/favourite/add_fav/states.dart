part of 'cubit.dart';

abstract class AddFavStates {}

class AddFavInitialStates extends AddFavStates {}

class AddFavSuccessStates extends AddFavStates {}

class AddFavFailedStates extends AddFavStates {
  final String msg;

  AddFavFailedStates({required this.msg});
}

class FavStatus {
  final bool isLoved;

  FavStatus(this.isLoved);
}

class ChangeFavStates extends AddFavStates {
  final Map<int, FavStatus> favStatusMap;

  ChangeFavStates(this.favStatusMap);
}
