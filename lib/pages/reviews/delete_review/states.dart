abstract class DeleteReviewsStates {}

class DeleteReviewsInitialState extends DeleteReviewsStates {}

class DeleteReviewsLoadingState extends DeleteReviewsStates {}

class DeleteReviewsSuccessState extends DeleteReviewsStates {}

class DeleteReviewsFailureState extends DeleteReviewsStates {
  final String msg;

  DeleteReviewsFailureState({required this.msg});
}
