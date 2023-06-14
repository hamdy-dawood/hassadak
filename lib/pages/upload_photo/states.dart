abstract class UploadUserPhotoStates {}

class UploadUserPhotoInitialState extends UploadUserPhotoStates {}

class UploadUserPhotoLoadingState extends UploadUserPhotoStates {}

class UploadUserPhotoSuccessState extends UploadUserPhotoStates {}

class UploadUserChangeImageStates extends UploadUserPhotoStates {}

class NetworkErrorState extends UploadUserPhotoStates {}

class UploadUserPhotoFailureState extends UploadUserPhotoStates {
  final String msg;

  UploadUserPhotoFailureState({required this.msg});
}
