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
        print("//"*100);
        print(response.data);
      } else {
        emit(SearchFailedState(msg: response.data["status"]));
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
        emit(SearchNetworkErrorState());
      }
    } catch (e) {
      emit(SearchFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
