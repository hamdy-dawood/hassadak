import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'states.dart';

class DeleteReviewsCubit extends Cubit<DeleteReviewsStates> {
  DeleteReviewsCubit() : super(DeleteReviewsInitialState());

  static DeleteReviewsCubit get(context) => BlocProvider.of(context);

  final dio = Dio();

  Future<void> deleteReview({required String id}) async {
    emit(DeleteReviewsLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.delete("${UrlsStrings.allReviewsUrl}/$id");
      if (response.data["status"] == "success" && response.statusCode == 201) {
        emit(DeleteReviewsSuccessState());
      } else {
        emit(DeleteReviewsFailureState(msg: response.data["message"]));
      }
    } on DioError catch (e) {
      emit(DeleteReviewsFailureState(msg: "$e"));
    }
  }
}
