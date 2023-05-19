import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllProductsCubit extends Cubit<AllProductsStates> {
  AllProductsCubit() : super(AllProductsInitialState());

  static AllProductsCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: true);
  AllProductsResponse? allProducts;

  Future<void> getAllProducts({String? id = ""}) async {
    emit(AllProductsLoadingState());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';

      final response =
          await dio.get("${UrlsStrings.allProductsUrl}$id", options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        emit(AllProductsSuccessState());
      } else {
        emit(AllProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllProductsFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(NetworkErrorState());
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(AllProductsFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
