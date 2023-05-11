import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class EditReviewsCubit extends Cubit<EditReviewsStates> {
  EditReviewsCubit() : super(EditReviewsInitialState());

  static EditReviewsCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();
  late double rate;

  Future<void> editReview(
      {required String productID, required String reviewID}) async {
    if (formKey.currentState!.validate()) {
      emit(EditReviewsLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
        final response =
            await dio.patch("${UrlsStrings.allReviewsUrl}/$reviewID", data: {
          "review": reviewController.text,
          "rating": rate,
          "product": productID,
          "user": CacheHelper.getId()
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 201) {
          emit(EditReviewsSuccessState());
          reviewController.clear();
        } else {
          emit(EditReviewsFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        String errorMessage = e.type.toString();
        if (e.response != null) {
          errorMessage = e.response!.data.toString();
        }
        emit(EditReviewsFailureState(msg: errorMessage));
      } catch (e) {
        emit(EditReviewsFailureState(msg: "$e"));
      }
    }
  }

  @override
  Future<void> close() {
    reviewController.dispose();
    return super.close();
  }
}
