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
  final formKey = GlobalKey<FormState>();
  final reviewController = TextEditingController();
  final int rate = 0;

  Future<void> addReview({required String productID}) async {
    if (formKey.currentState!.validate()) {
      emit(AddReviewsLoadingState());
      try {
        dio.options.headers['Authorization'] =
            'Bearer ${CacheHelper.getToken()}';
        final response = await dio.post(UrlsStrings.allReviewsUrl, data: {
          "review": reviewController.text,
          "rating": 4,
          "product": productID,
          "user": CacheHelper.getId()
        });
        if (response.data["status"] == "success" &&
            response.statusCode == 201) {
          emit(AddReviewsSuccessState());
        } else {
          emit(AddReviewsFailureState(msg: response.data["status"]));
        }
      } on DioError catch (e) {
        emit(AddReviewsFailureState(msg: "$e"));
      }
    }
  }
}
