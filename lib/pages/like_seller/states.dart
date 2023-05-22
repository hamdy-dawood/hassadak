abstract class LikeSellerStates {}

class LikeSellerInitialState extends LikeSellerStates {}

class LikeSellerSuccessState extends LikeSellerStates {}

class LikeSellerFailureState extends LikeSellerStates {
  final String msg;

  LikeSellerFailureState({required this.msg});
}
