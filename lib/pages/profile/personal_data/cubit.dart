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

  Future<void> getPersonalData() async {
    emit(PersonalDataLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get(UrlsStrings.getMeUrl);
      if (response.data["status"] == "success" && response.statusCode == 200) {
        profileResponse = PersonalDataResp.fromJson(response.data);
        emit(PersonalDataSuccessState());
      } else {
        emit(PersonalDataFailureState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(PersonalDataFailureState(msg: "$e"));
    }
  }
}
