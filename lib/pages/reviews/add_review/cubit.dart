import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class AddReviewsCubit extends Cubit<AddReviewsStates> {
  AddReviewsCubit() : super(AddReviewsInitialState());

  static AddReviewsCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();
  late double rate;

  Future<void> addReview({required String productID}) async {
    if (formKey.currentState!.validate()) {
      emit(AddReviewsLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
        final response = await dio.post(UrlsStrings.allReviewsUrl, data: {
          "review": reviewController.text,
          "rating": rate,
          "product": productID,
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 201) {
          emit(AddReviewsSuccessState());
          reviewController.clear();
        } else {
          emit(AddReviewsFailureState(msg: response.data["status"]));
          print(response.data["status"]);
        }
      } on DioError catch (e) {
        String errorMsg;
        if (e.type == DioErrorType.cancel) {
          errorMsg = 'Request was cancelled';
          emit(AddReviewsFailureState(msg: errorMsg));
        } else if (e.type == DioErrorType.receiveTimeout ||
            e.type == DioErrorType.sendTimeout) {
          errorMsg = 'Connection timed out';
          emit(NetworkErrorState());
        } else if (e.type == DioErrorType.other) {
          errorMsg = 'Invalid status code: ${e.error}';
          emit(NetworkErrorState());
          print(errorMsg);
        } else {
          errorMsg = 'An unexpected error : ${e.error}';
          emit(AddReviewsFailureState(msg: errorMsg));
        }
      } catch (e) {
        emit(AddReviewsFailureState(msg: 'An unknown error: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    reviewController.dispose();
    return super.close();
  }
}
