import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';
import 'states.dart';

class PersonalDataCubit extends Cubit<PersonalDataStates> {
  PersonalDataCubit() : super(PersonalDataInitialState());

  static PersonalDataCubit get(context) => BlocProvider.of(context);
  final dio = Dio();
  PersonalDataResp? profileResponse;

  Future<void> getPersonalData({required String id}) async {
    emit(PersonalDataLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get("${UrlsStrings.getUserUrl}/$id");
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
        emit(PersonalDataFailureState(msg: errorMsg));
      } else if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        errorMsg = 'Connection timed out';
        emit(NetworkErrorState());
      } else if (e.type == DioErrorType.other) {
        errorMsg = 'Received invalid status code: ${e.response?.statusCode}';
        emit(NetworkErrorState());
      } else {
        errorMsg = 'An unexpected error : ${e.error}';
        emit(PersonalDataFailureState(msg: errorMsg));
      }
    } catch (e) {
      emit(PersonalDataFailureState(msg: 'An unknown error : $e'));
    }
  }
}
