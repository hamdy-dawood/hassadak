import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';
import 'package:hassadak/pages/home/all_products/model.dart';

part 'states.dart';

class OfferProductsCubit extends Cubit<OfferProductsStates> {
  OfferProductsCubit() : super(OfferProductsInitialState());

  static OfferProductsCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: true);
  AllProductsResponse? allProducts;

  Future<void> getOfferProducts() async {
    emit(OfferProductsLoadingState());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';

      final response = await dio.get(
          "${UrlsStrings.allProductsUrl}?discount=Success&discountPerc[gt]=0",
          options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allProducts = AllProductsResponse.fromJson(response.data);
        emit(OfferProductsSuccessState());
      } else {
        emit(OfferProductsFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(OfferProductsFailedState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(OfferProductsFailedState(msg: errorMsg));
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(OfferProductsFailedState(msg: 'An unknown error occurred: $e'));
    }
  }
}
