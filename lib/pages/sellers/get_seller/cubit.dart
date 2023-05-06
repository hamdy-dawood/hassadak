import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hassadak/constants/strings.dart';
import 'package:hassadak/core/cache_helper.dart';

import 'model.dart';

part 'states.dart';

class GetSellerCubit extends Cubit<GetSellerStates> {
  GetSellerCubit() : super(GetSellerInitialState());

  static GetSellerCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  GetSellerResponse? sellerResponse;

  Future<void> getSeller({required String id}) async {
    emit(GetSellerLoadingState());
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.getToken()}';
      final response = await dio.get("${UrlsStrings.getSellerUrl}/$id");
      if (response.data["status"] == "success" && response.statusCode == 201) {
        sellerResponse = GetSellerResponse.fromJson(response.data);
        emit(GetSellerSuccessState());
      } else {
        emit(GetSellerFailedState(msg: response.data["status"]));
      }
    } on DioError catch (e) {
      emit(GetSellerFailedState(msg: "$e"));
    }
  }
}
