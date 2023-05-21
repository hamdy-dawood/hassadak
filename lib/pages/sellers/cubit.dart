import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllSellersCubit extends Cubit<AllSellersStates> {
  AllSellersCubit() : super(AllSellersInitialState());

  static AllSellersCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: true);
  AllSellersResponse? allSellers;

  Future<void> getAllSellers() async {
    emit(AllSellersLoadingState());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(UrlsStrings.allSellersUrl,
          queryParameters: {
            "role": "seller",
          },
          options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allSellers = AllSellersResponse.fromJson(response.data);
        emit(AllSellersSuccessState());
      } else {
        emit(AllSellersFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllSellersFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(NetworkErrorState());
      } else {
        errorMsg = 'An unexpected error: ${e.error}';
        emit(AllSellersFailedState(msg: errorMsg));
      }
    } catch (e) {
      emit(AllSellersFailedState(msg: 'An unknown error: $e'));
    }
  }
}
