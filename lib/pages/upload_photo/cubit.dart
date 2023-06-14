import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

import 'states.dart';

class UploadUserPhotoCubit extends Cubit<UploadUserPhotoStates> {
  UploadUserPhotoCubit() : super(UploadUserPhotoInitialState());

  static UploadUserPhotoCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  File? myImage;

  Future<void> uploadPhoto() async {
    emit(UploadUserPhotoLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.patch(UrlsStrings.uploadUerPhotoUrl,
          data: FormData.fromMap({
            "image": myImage != null
                ? MultipartFile.fromFileSync(
                    myImage!.path,
                    filename: myImage!.path.split("/").last,
                  )
                : null,
          }));
      if (response.data["status"] == "success" && response.statusCode == 201) {
        emit(UploadUserPhotoSuccessState());
      } else {
        emit(UploadUserPhotoFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(UploadUserPhotoFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Invalid status code: ${e.response?.data}';
        emit(UploadUserPhotoFailureState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(UploadUserPhotoFailureState(msg: 'An unknown error: $e'));
    }
  }

  chooseMyImage({ImageSource? source}) {
    ImagePicker.platform.getImage(source: source!).then((value) {
      if (value != null) {
        myImage = File(value.path);
        emit(UploadUserChangeImageStates());
      }
    });
  }
}
