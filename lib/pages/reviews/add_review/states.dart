abstract class AddReviewsStates {}

class AddReviewsInitialState extends AddReviewsStates {}

class AddReviewsLoadingState extends AddReviewsStates {}

class AddReviewsSuccessState extends AddReviewsStates {}

class AddReviewsFailureState extends AddReviewsStates {
  final String msg;

  AddReviewsFailureState({required this.msg});
}

class NetworkErrorState extends AddReviewsStates {}
