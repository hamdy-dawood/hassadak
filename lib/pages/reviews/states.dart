abstract class ReviewsStates {}

class ReviewsInitialState extends ReviewsStates {}

class ReviewsLoadingState extends ReviewsStates {}

class ReviewsSuccessState extends ReviewsStates {}

class ReviewsFailureState extends ReviewsStates {
  final String msg;

  ReviewsFailureState({required this.msg});
}
