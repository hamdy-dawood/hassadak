import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class GetSellerCubit extends Cubit<GetSellerStates> {
  GetSellerCubit() : super(GetSellerInitialState());

  static GetSellerCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: false);
  GetSellerResponse? sellerResponse;

  Future<void> getSeller({required String id}) async {
    emit(GetSellerLoadingState());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.get("${UrlsStrings.getSellerUrl}/$id", options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 201) {
        sellerResponse = GetSellerResponse.fromJson(response.data);
        emit(GetSellerSuccessState());
      } else {
        emit(GetSellerFailedState(msg: response.data["status"]));
      }
    }  on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(GetSellerFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(GetSellerFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(NetworkErrorState());
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(GetSellerFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
