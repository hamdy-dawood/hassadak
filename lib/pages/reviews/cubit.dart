import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class ReviewsCubit extends Cubit<ReviewsStates> {
  ReviewsCubit() : super(ReviewsInitialState());

  static ReviewsCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  ReviewsResponse? reviewsResponse;

  Future<void> getReviews({required String id}) async {
    emit(ReviewsLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(
        "${UrlsStrings.allReviewsUrl}?product=$id",
      );

      if (response.data["status"] == "success" && response.statusCode == 200) {
        reviewsResponse = ReviewsResponse.fromJson(response.data);
        emit(ReviewsSuccessState());
      } else {
        emit(ReviewsFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
      } else if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
      } else if (e.type == DioErrorType.badResponse) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        print("Received invalid status code: ${e.response?.statusCode}");
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
        emit(ReviewsNetworkErrorState());
      }
    } catch (e) {
      emit(ReviewsFailureState(msg: 'An unknown error occurred: $e'));
      print(e);
    }
  }
}
