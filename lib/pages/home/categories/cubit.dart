import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  AllCategoriesCubit() : super(AllCategoriesInitialStates());

  static AllCategoriesCubit get(context) => BlocProvider.of(context);

  AllCategories? allCategories;
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: false);
  int length = 0;

  Future<void> getAllCategories() async {
    emit(AllCategoriesLoadingStates());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.get(UrlsStrings.allCategoriesUrl, options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        allCategories = AllCategories.fromJson(response.data);
        length = allCategories!.results;
        emit(AllCategoriesSuccessStates(id: allCategories!.data.doc));
      } else {
        emit(AllCategoriesFailedStates(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(AllCategoriesNetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Invalid status code: ${e.response?.statusCode}';
        emit(AllCategoriesNetworkErrorState());
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(AllCategoriesFailedStates(msg: errorMsg));
      }
    } catch (e) {
      emit(AllCategoriesFailedStates(msg: 'An unknown error: $e'));
    }
  }
}
