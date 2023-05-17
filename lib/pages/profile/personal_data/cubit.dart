import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class PersonalDataCubit extends Cubit<PersonalDataStates> {
  PersonalDataCubit() : super(PersonalDataInitialState());

  static PersonalDataCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  final dioCacheManager = DioCacheManager(CacheConfig());
  final myOptions =
      buildCacheOptions(const Duration(days: 2), forceRefresh: false);
  PersonalDataResp? profileResponse;

  Future<void> getPersonalData({required String id}) async {
    emit(PersonalDataLoadingState());
    try {
      dio.interceptors.add(dioCacheManager.interceptor);
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response =
          await dio.get("${UrlsStrings.getUserUrl}/$id", options: myOptions);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        profileResponse = PersonalDataResp.fromJson(response.data);
        emit(PersonalDataSuccessState());
      } else {
        emit(PersonalDataFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      String errorMsg;
      if (e.type == DioErrorType.cancel) {
        errorMsg = 'Request was cancelled';
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        print("Received invalid status code: ${e.response?.statusCode}");
        print(errorMsg);
      } else {
        errorMsg = 'An unexpected error occurred: ${e.error}';
        print(errorMsg);
        emit(NetworkErrorState());
      }
    } catch (e) {
      emit(PersonalDataFailureState(msg: 'An unknown error occurred: $e'));
    }
  }
}
