abstract class EditReviewsStates {}

class EditReviewsInitialState extends EditReviewsStates {}

class EditReviewsLoadingState extends EditReviewsStates {}

class EditReviewsSuccessState extends EditReviewsStates {}

class EditReviewsFailureState extends EditReviewsStates {
  final String msg;

  EditReviewsFailureState({required this.msg});
}
