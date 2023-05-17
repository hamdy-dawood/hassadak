import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  final dio = Dio();
  SearchResponse? searchResponse;

  Future<void> getSearch({String? id = ""}) async {
    emit(SearchLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get("${UrlsStrings.allProductsUrl}$id");
      if (response.data["status"] == "success" && response.statusCode == 200) {
        searchResponse = SearchResponse.fromJson(response.data);
        emit(SearchSuccessState());
      } else {
        emit(SearchFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(SearchFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(SearchNetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(SearchNetworkErrorState());
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(SearchNetworkErrorState());
      }
    } catch (e) {
      emit(SearchFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
